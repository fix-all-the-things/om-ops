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
    imageFile = pkgs.docker-images.cityvizor.cityvizor-server;
    cmd = [ "-mserver" ];
    ports = [ "${builtins.toString hostPort}:3000" ];
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

      virtualisation.docker = {
        enable = true;
        #extraOptions = "--ipv6 --fixed-cidr-v6=2001:dac:1::/64 --userland-proxy=false";
        extraOptions = "--userland-proxy=false";
      };

      virtualisation.podman = {
        enable = true;
        #extraOptions = "--ipv6"; #--fixed-cidr-v6=2001:dac:1::/64";
      };

      virtualisation.oci-containers= {
        backend = "podman";
        containers = {
          cv-client = {
            image = "cityvizor/cityvizor-client:latest";
            imageFile = pkgs.docker-images.cityvizor.cityvizor-client;
            dependsOn = [ "cv-server" ];
            ports = [ "8000:80" ];
          };

          cv-server = makeServer 3000;
          cv-server-2 = makeServer 3001;

          cv-server-kotlin = {
            image = "cityvizor/server-kotlin:prod";
            imageFile = pkgs.docker-images.cityvizor.server-kotlin;
            environment = {
              JDBC_URL = "jdbc:postgresql://${cfg.database.host}:${builtins.toString cfg.database.port}/${cfg.database.name}?user=${cfg.database.user}";
            };
            ports = [ "6000:8080" ];
            volumes = [ "/etc/hosts:/etc/hosts" ];
          };

          cv-landing-page = {
            image = "cityvizor/landing-page:latest";
            imageFile = pkgs.docker-images.cityvizor.landing-page;
            ports = [ "8001:80" ];
          };
        };
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
            "localhost:${toString cfg.server.port}" = {};
          } // listToAttrs (map (num: {
              name = "localhost:${toString (cfg.server.port + num)}";
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
              proxyPass = "http://localhost:8000";
            };
            "/landing" = {
              proxyPass = "http://localhost:8001/landing/";
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
