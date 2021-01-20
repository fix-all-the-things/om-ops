{ config, pkgs, lib, ... }:

# TODO:
# - service for updater
# - run migrate

with lib;

let
  cfg = config.services.cityvizor;
  baseDir = "/var/lib/cityvizor";
  user = "cv";
  group = "cv";

  # postgres is a pg super-user
  demoDump = user: pkgs.runCommand "db-demo-for-user-${user}.sql" {}
    ''
      sed 's/postgres/${user}/g' ${pkgs.cityvizor.db-demo-dump} > $out
    '';
in
{
  options = {
    services.cityvizor = {
      enable = mkEnableOption "CityVizor";

      hostName = mkOption {
        type = types.str;
        default = "cityvizor";
        description = ''
          Host name where this application is going to be served.

          Creates nginx vhost which you can further modify under
          <option>services.nginx.virtualHosts."$${hostName}"</option>
        '';
      };

      database = {
        demoData.enable = mkEnableOption "loading of demo database";
        # TODO: classics
        # host, port, name, user, createLocally
      };

      proxy = {
        enable = mkEnableOption "CityVizor nginx proxy";
      };

      server = {
        enable = mkEnableOption "CityVizor server";
      };

      server-kotlin = {
        enable = mkEnableOption "CityVizor server-kotlin";
        maxHeapSize = mkOption {
          type = types.str;
          default = "128m";
        };
      };
    };
  };

  config = mkMerge [
    (mkIf cfg.enable {

      services.cityvizor = {
        database.demoData.enable = mkDefault true;
        server.enable = mkDefault true;
        server-kotlin.enable = mkDefault true;
        proxy.enable = mkDefault true;
      };

      users.users.${user} = {
        inherit group;
        home = baseDir;
        isSystemUser = true;
      };

      users.groups.${group} = {};

      systemd.tmpfiles.rules = let
        writable = [ "app" "client" "data" ];
      in
      [
        "d  ${baseDir}                     0511 ${user} ${group} - -"
      ] ++ (flip map writable (d:
        "d  ${baseDir}/${d}                0700 ${user} ${group} - -"
      ));

    })

    (mkIf cfg.proxy.enable {
      services.nginx = {
        enable = true;
        recommendedOptimisation = true;
        virtualHosts.${cfg.hostName} = {
          default = true;
          locations = {
            "/" = { root = pkgs.cityvizor.client; };
            "/landing/" = {
              alias = "${pkgs.cityvizor.landing-page}/";
            };
            "/api" = {
              proxyPass = "http://localhost:3000";
            };
          } // optionalAttrs (cfg.server-kotlin.enable) {
            "/api/v1/citysync" = {
              proxyPass = "http://localhost:8080";
            };
            "/api/v2" = {
              proxyPass = "http://localhost:8080";
            };
          };
        };
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
                -d cv \
                -f ${demoDump "cvuser"}
            fi
          '';

          # Run as root (Prefixed with +)
          ExecStartPost = "+" + (pkgs.writeShellScript "init-cv-db-script-post" ''
            touch ${baseDir}/db-init-done
            '');

          User = "postgres";
          Group = "postgres";
        };
      };
    })

    (mkIf (cfg.server-kotlin.enable) {
      systemd.services.server-kotlin = {
        description = "CityVizor Kotlin Server";
        wantedBy = [ "multi-user.target" ];
        requires = [ "init-cv-db.service" ];
        after    = [ "init-cv-db.service" ];
        environment = {
          JDBC_URL = "jdbc:postgresql://localhost:5432/cv?user=cvuser";
        };

        serviceConfig = {
          ExecStart = ''
            ${pkgs.jre}/bin/java \
            -jar \
            -Xmx${cfg.server-kotlin.maxHeapSize} \
            ${pkgs.cityvizor.server-kotlin}/server-0.0.5.jar
          '';
          User = user;
        };
      };
    })

    (mkIf (cfg.server.enable) {
      systemd.services.server = {
        description = "CityVizor Server";
        wantedBy = [ "multi-user.target" ];
        requires = [ "init-cv-db.service" ];
        after    = [ "init-cv-db.service" ];
        environment = {
        };

        serviceConfig = {
          ExecStart = ''
            ${pkgs.cityvizor.server}/bin/server
          '';
          User = user;
          WorkingDirectory = baseDir;
        };
      };
    })
  ];
}
