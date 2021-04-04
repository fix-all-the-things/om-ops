{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.cityvizor;
  baseDir = "/var/lib/cityvizor";

  # nix branch, pin at some point
  cvSrc = "https://github.com/otevrenamesta/cityvizor/archive/nix.tar.gz";
  cvOverlay =
    import "${builtins.fetchTarball cvSrc}/overlay.nix";

  # postgres is a pg super-user
  demoDump = user: pkgs.runCommand "db-demo-for-user-${user}.sql" {}
    ''
      sed 's/postgres/${user}/g' ${pkgs.cityvizor.db-demo-dump} > $out
    '';

  images = pkgs.docker-images.cityvizor."${cfg.containers.tag}";

  makeServer = hostPort: {
    image = "cityvizor/cityvizor-server:${cfg.containers.tag}";
    cmd = [ "-mserver" ];
    ports = [ "${builtins.toString hostPort}:3000" ];
    extraOptions = cfg.containers.extraOptions;
    environment = {
      DATABASE_NAME = cfg.database.name;
      DATABASE_HOST = cfg.database.host;
      DATABASE_PORT = builtins.toString cfg.database.port;
      DATABASE_USERNAME = cfg.database.user;
      DATABASE_SSL = builtins.toString cfg.database.enableSSL;
      URL = "https://${cfg.hostName}";
      NODE_ENV = "system";
      S3_HOST = cfg.s3.host;
      S3_CDN_HOST = cfg.s3.cdnHost;
      S3_PORT = toString cfg.s3.port;
      S3_PRIVATE_BUCKET = cfg.s3.privateBucket;
      S3_PUBLIC_BUCKET = cfg.s3.publicBucket;
      S3_ACCESS_KEY = cfg.s3.accessKey;
    } // optionalAttrs cfg.smtp.enable {
      EMAIL_SMTP = cfg.smtp.host;
      EMAIL_PORT = toString cfg.smtp.port;
      EMAIL_USER = cfg.smtp.user;
      EMAIL_ADDRESS = cfg.smtp.address;
    };
    volumes =
    let
      dotEnv = pkgs.writeText "cv-dot-env" ''
        EDESKY_API_KEY='${cfg.server.edeskyApiKey}'
        JWT_SECRET='${cfg.server.jwtSecret}'
        S3_SECRET_KEY='${cfg.s3.secretKey}'
        ${optionalString cfg.smtp.enable ''
          EMAIL_PASSWORD='${cfg.smtp.password}'
        ''}
      '';
    in
    [
      "/etc/hosts:/etc/hosts" # to be able to reach external pg
      "/var/lib/cityvizor/data:/home/node/data"
      "${dotEnv}:/home/node/app/.env"
    ];
  } // optionalAttrs cfg.containers.pinned {
    imageFile = images.cityvizor-server;
  };

  ctNetLocalhost = {
    docker = "172.17.0.1";
    podman = if cfg.containers.enableCustomCNI
      then "10.77.0.1"
      else "10.88.0.1";
  };

  contentJSON = pkgs.writeText "content.json" (builtins.toJSON cfg.landing-page.settings);

  user = "cv";
  group = user;
in

{
  options = import ./cityvizor-options.nix { inherit pkgs lib; };
  config = mkMerge [
    (mkIf cfg.enable  {
      services.cityvizor = {
        server.enable = mkDefault true;
        proxy.enable = mkDefault true;
        containers.extraOptions = optional cfg.containers.enableCustomCNI "--net=podman-ipv6";
      };

      assertions = [
        { assertion = cfg.containers.enableCustomCNI -> cfg.containers.backend == "podman";
          message = "enableCustomCNI requires podman backend";
        }
      ];

      networking.firewall.allowedTCPPorts = [
        80
        6379 # redis only binds to internal container network
      ];
      networking.extraHosts = ''
        ${ctNetLocalhost."${cfg.containers.backend}"} redis.cityvizor.otevrenamesta
      '';

      nixpkgs.overlays = [
        cvOverlay
        (import ../overlays/docker-images.nix)
      ];

      virtualisation.docker = optionalAttrs (cfg.containers.backend == "docker") {
        enable = true;
        extraOptions = "--userland-proxy=false";
      };

      virtualisation.podman = optionalAttrs (cfg.containers.backend == "podman") {
        enable = true;
        dockerCompat = true;
      };

      virtualisation.oci-containers= {
        backend = cfg.containers.backend;
        containers = {
          cv-client = {
            image = "cityvizor/cityvizor-client:${cfg.containers.tag}";
            dependsOn = [ "cv-server" ];
            ports = [ "8000:80" ];
            volumes = [
              "${contentJSON}:/usr/share/nginx/html/assets/js/content.json"
            ];
            extraOptions = cfg.containers.extraOptions;
          } // optionalAttrs cfg.containers.pinned {
            imageFile = images.cityvizor-client;
          };

          cv-server = makeServer cfg.server.port;

          cv-landing-page = {
            image = "cityvizor/landing-page:${cfg.containers.tag}";
            ports = [ "8001:80" ];
            volumes = [
              "${contentJSON}:/usr/share/nginx/html/cfg/content.json"
            ];
            extraOptions = cfg.containers.extraOptions;
          } // optionalAttrs cfg.containers.pinned {
            imageFile = images.landing-page;
          };

          # worker uses the same image as server
          # with different cmd and no ports
          cv-worker = (makeServer 0) // {
            cmd =  [ "-mworker" ];
            ports = [];
          };
        }
        // listToAttrs (map (num: {
              name = "cv-server-${toString num}";
              value = (makeServer (cfg.server.port + num)) // { dependsOn = [ "cv-server" ]; };
            })(range 1 cfg.server.redundantInstances))
        // optionalAttrs cfg.demo.enable {
            cv-demo = {
              image = "cityvizor/cityvizor-demo:${cfg.containers.tag}";
              ports = [ "8002:80" ];
              extraOptions = cfg.containers.extraOptions;
            } // optionalAttrs cfg.containers.pinned {
              imageFile = images.cityvizor-demo;
            };
        };


      };

      users.users.${user} = {
        inherit group;
        home = baseDir;
        isSystemUser = true;
        uid = 1000;
      };

      users.groups.${group} = {
        gid = 1000;
      };

      systemd.tmpfiles.rules = let
        writable = [ "app" "client" "data" "imports" ];
      in
      [
        "d  ${baseDir}                     0511 ${user} ${group} - -"
      ] ++ (flip map writable (d:
        "d  ${baseDir}/${d}                0700 ${user} ${group} - -"
      ));

      services.redis = {
        enable = true;
        bind = ctNetLocalhost."${cfg.containers.backend}";
      };

      systemd.services.redis.serviceConfig = {
        Restart = "always";
        RestartSec = 5;
        # this changes to
        # unitConfig.startLimitIntervalSec = 0;
        # with 21.05 and no StartLimitBurst is needed
        StartLimitIntervalSec = 0;
        StartLimitBurst = 0;
      };

      services.nginx = optionalAttrs cfg.proxy.enable {
        enable = true;
        recommendedOptimisation = true;
        recommendedProxySettings = true;
        eventsConfig = ''
          worker_connections 65536;
        '';

        appendConfig = ''
          worker_rlimit_nofile 65536;
        '';
        upstreams = {
          "api".servers = {
            "127.0.0.1:${toString cfg.server.port}" = {};
          } // listToAttrs (map (num: {
              name = "127.0.0.1:${toString (cfg.server.port + num)}";
              value = {};
            }) (range 1 cfg.server.redundantInstances));
        };

        virtualHosts = {
          "${cfg.hostName}" = {
            default = true;
            http2 = true;
            locations = {
              "=/" = {
                return = "302 /landing";
              };
              "/" = {
                proxyPass = "http://127.0.0.1:8000";
              };
              "/landing" = {
                proxyPass = "http://127.0.0.1:8001/landing/";
              };
              "/api" = {
                proxyPass = "http://api";
              };
            };
          };
        } // optionalAttrs cfg.demo.enable {
          "demo.${cfg.hostName}" = {
            locations = {
              "/" = {
                proxyPass = "http://127.0.0.1:8002";
              };
            };
          };
        };
      };

      services.postgresql = optionalAttrs cfg.database.createLocally {
        enable = true;
        enableTCPIP = true;
        ensureDatabases = [ cfg.database.name ];
        ensureUsers = [{
          name = cfg.database.user;
          ensurePermissions = {
            "DATABASE ${cfg.database.name}" = "ALL PRIVILEGES";
          };
        }];
        authentication = ''
          host ${cfg.database.name} ${cfg.database.user} 127.0.0.1/32 trust
          host ${cfg.database.name} ${cfg.database.user} ::1/128      trust
        '';
      };

      environment.systemPackages =
      let backend = cfg.containers.backend;
          tag = cfg.containers.tag;
      in
      lib.optional (!cfg.containers.pinned)
        (pkgs.writeScriptBin "cityvizor-update"
        ''
          set -ex
          ${backend} pull docker.io/cityvizor/cityvizor-client:${tag}
          ${optionalString cfg.demo.enable ''
            ${backend} pull docker.io/cityvizor/cityvizor-demo:${tag}
          ''}
          ${backend} pull docker.io/cityvizor/cityvizor-server:${tag}
          ${backend} pull docker.io/cityvizor/landing-page:${tag}
          echo "Restarting services"
          systemctl restart ${backend}-cv-\*
        '');

    })

    (mkIf cfg.database.demoData.enable {
      systemd.services.init-cv-db = {
        description = "CityVizor demo database initialization";
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = pkgs.writeShellScript "init-cv-db-script" ''
            if [ ! -f ${baseDir}/db-init-done ]; then
              ${pkgs.postgresql}/bin/psql \
                -d ${cfg.database.name} \
                -h ${cfg.database.host} \
                -U ${cfg.database.user} \
                -f ${demoDump cfg.database.user}
            fi
          '';

          # Run as root (Prefixed with +)
          ExecStartPost = "+" + (pkgs.writeShellScript "init-cv-db-script-post" ''
            touch ${baseDir}/db-init-done
          '');
        };
      }
      // optionalAttrs cfg.database.createLocally { after = [ "postgresql.service" ]; };
    })

    (mkIf cfg.containers.enableCustomCNI  {
      environment.etc."cni/net.d/10-podman-ipv6-bridge.conflist".text = builtins.readFile ../files/10-podman-ipv6-bridge.conflist;
    })

  ];
}
