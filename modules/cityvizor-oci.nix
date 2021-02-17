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

  makeServer = hostPort: {
    image = "cityvizor/cityvizor-server:latest";
    cmd = [ "-mserver" ];
    ports = [ "${builtins.toString hostPort}:3000" ];
    extraOptions = cfg.containers.extraOptions;
    environment = {
      DATABASE_NAME = cfg.database.name;
      DATABASE_HOST = cfg.database.host;
      DATABASE_PORT = builtins.toString cfg.database.port;
      DATABASE_USERNAME = cfg.database.user;
      DATABASE_SSL = builtins.toString cfg.database.enableSSL;
      # XXX
      EDESKY_API_KEY = "sample";
      # XXX
      JWT_SECRET = "secret";
      NODE_ENV = "system";
    };
    volumes = [
      "/etc/hosts:/etc/hosts" # to be able to reach external pg
      "/var/lib/cityvizor:/user/src/app/data"
    ];
  } // optionalAttrs cfg.containers.pinned {
    imageFile = pkgs.docker-images.cityvizor.cityvizor-server;
  };
in

{
  options = import ./cityvizor-options.nix { inherit pkgs lib; };
  config = mkMerge [
    (mkIf cfg.enable  {
      services.cityvizor = {
        server.enable = mkDefault true;
        proxy.enable = mkDefault true;
      };

      networking.firewall.allowedTCPPorts = [ 80 ];

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
            image = "cityvizor/cityvizor-client:latest";
            dependsOn = [ "cv-server" ];
            ports = [ "8000:80" ];
            extraOptions = cfg.containers.extraOptions;
          } // optionalAttrs cfg.containers.pinned {
            imageFile = pkgs.docker-images.cityvizor.cityvizor-client;
          };

          cv-server = makeServer cfg.server.port;

          cv-landing-page = {
            image = "cityvizor/landing-page:latest";
            ports = [ "8001:80" ];
            extraOptions = cfg.containers.extraOptions;
          } // optionalAttrs cfg.containers.pinned {
            imageFile = pkgs.docker-images.cityvizor.landing-page;
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
            })(range 1 cfg.server.redundantInstances));
      };

      systemd.tmpfiles.rules = let
        writable = [ "app" "client" "data" ];
      in
      [
        "d  ${baseDir}                     0511 root root - -"
      ] ++ (flip map writable (d:
        "d  ${baseDir}/${d}                0700 root root - -"
      ));

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

        virtualHosts.${cfg.hostName} = {
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

  ];
}
