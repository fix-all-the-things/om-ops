{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.cityvizor;
  baseDir = "/var/lib/cityvizor";

  # nix branch, pin at some point
  cvSrc = "https://github.com/otevrenamesta/cityvizor/archive/nix.tar.gz";
  cvOverlay =
    import "${builtins.fetchTarball cvSrc}/overlay.nix";

  cvServerImage = pkgs.dockerTools.pullImage
  {
    imageName = "cityvizor/cityvizor-server";
    imageDigest = "sha256:5cc05c1c0b340e31d22bdbd0aec96adf9133d4f7f8f696815afa455f67ba4cf0";
    sha256 = "0kj06glaibyv6dxgr4xdxxqwbn1nskwkz3xdihl6r3cp4fdfz973";
    finalImageName = "cityvizor/cityvizor-server";
    finalImageTag = "prod";
  };
  cvModded = pkgs.dockerTools.buildImage {
    name = "cv-server-modded";
    tag = "latest";
    fromImage = cvServerImage;
    diskSize = 2333;
    runAsRoot =  ''
      #!${pkgs.runtimeShell}
      mkdir -p /data
      ls -l /
      ls -lR /user
      sed -i 's~bin/bash~bin/bash -ex~g' /user/src/app/entrypoint.sh
      sed -i 's/0.0.0.0/::/' /user/src/app/environment/environment.system.js
    '';
  };
  # postgres is a pg super-user
  demoDump = user: pkgs.runCommand "db-demo-for-user-${user}.sql" {}
    ''
      sed 's/postgres/${user}/g' ${pkgs.cityvizor.db-demo-dump} > $out
    '';


  makeServer = hostPort: {
    image = "cityvizor/cityvizor-server:latest";
    imageFile = pkgs.docker-images.cityvizor.cityvizor-server;
    # image = "cv-server-modded:latest";
    #imageFile = cvModded;
    # only for modded
    #workdir = "/user/src/app/";
    #entrypoint = "./entrypoint.sh";
    cmd = [ "-mserver" ];
    # create admin..
    #cmd = [ "-mserver" "-a" ];
    ports = [ "${builtins.toString hostPort}:3000" ];
    environment = {
      DATABASE_NAME = cfg.database.name;
      DATABASE_HOST = cfg.database.host;
      DATABASE_USERNAME = cfg.database.user;
      #XXX: ignored by cv
      #DATABASE_PORT = builtins.toString cfg.database.port;
      # XXX
      EDESKY_API_KEY = "sample";
      # XXX
      JWT_SECRET = "secret";
      NODE_ENV = "system";
    };
    volumes = [
      "/etc/hosts:/etc/hosts" # to be able to reach pg
      "/var/lib/cityvizor:/user/src/app/data"
    ];
 };
in

{
  options = import ./cityvizor-options.nix { inherit pkgs lib; };
  config = mkMerge [
    (mkIf cfg.enable  {
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

      /*
      */

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

      services.nginx = {
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
            "localhost:3000" = {};
            "localhost:3001" = {};
          };
        };

        virtualHosts.${cfg.hostName} = {
          default = true;
          http2 = true;
          locations = {
            "/" = {
              proxyPass = "http://localhost:8000";
            };
            "/landing/" = {
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
        package = cfg.postgresql-package;
        ensureDatabases = [ cfg.database.name ];
        ensureUsers = [{
          name = cfg.database.user;
          ensurePermissions = {
            "DATABASE ${cfg.database.name}" = "ALL PRIVILEGES";
          };
        }];
      };

    })
    (mkIf cfg.database.demoData.enable {
      systemd.services.init-cv-db = {
        description = "CityVizor database initialization";
        after = [ "postgresql.service" ];
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
      };
    })

    (mkIf (cfg.server-kotlin.enable) {
    })

  ];
}
