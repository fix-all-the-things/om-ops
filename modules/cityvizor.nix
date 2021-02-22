{ config, pkgs, lib, ... }:

# TODO:
# - service for updater
# - run migrate

with lib;

let
  cfg = config.services.cityvizor;
  baseDir = "/var/lib/cityvizor";
  user = "cv";
  group = user;


  # postgres is a pg super-user
  demoDump = user: pkgs.runCommand "db-demo-for-user-${user}.sql" {}
    ''
      sed 's/postgres/${user}/g' ${pkgs.cityvizor.db-demo-dump} > $out
    '';
in
{
  options = import ./cityvizor-options.nix { inherit pkgs lib; };
  config = mkMerge [
    (mkIf cfg.enable {

      services.cityvizor = {
        server.enable = mkDefault true;
        proxy.enable = mkDefault true;
      };

      users.users.${user} = {
        inherit group;
        home = baseDir;
        isSystemUser = true;
      };

      users.groups.${group} = {};

      systemd.tmpfiles.rules = let
        writable = [ "app" "client" "data" "imports" ];
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
