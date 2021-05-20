{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.services.phpapp;
  phpPackage = pkgs.php74.buildEnv {
    extensions = { enabled, all }: with all;
      enabled ++ [ redis ];
  };

in
{
  options = {
    services.phpapp = {
      enable = mkEnableOption "enable generic PHP app";

      hostName = mkOption {
        type = types.str;
        default = "phpapp.otevrenamesta.cz";
        description = ''
          Host name where this application is going to be served.

          Creates nginx vhost which you can further modify under
          <option>services.nginx.virtualHosts."$${hostName}"</option>
        '';
      };

      package = mkOption {
        type = types.path;
        default = pkgs.runCommand "default_phpapp" {}
          ''
          mkdir $out
          echo '<?php print("Hello world"); ?>' > $out/index.php
          '';
      };

      user = mkOption {
        type = types.str;
        default = "phpapp";
      };

      group = mkOption {
        type = types.str;
        default = "phpapp";
      };

      devDir = mkOption {
        type = types.str;
        default = "/var/www/phpapp";
      };

      database = {
        createLocally = mkOption {
          type = types.bool;
          default = false;
          description = "Whether to create a local database automatically.";
        };

        name = mkOption {
          type = types.str;
          default = "phpapp";
          description = "Database name.";

        };
      };

    };
  };

  config = mkIf cfg.enable {

    services.phpfpm.pools.phpapp = {
      inherit (cfg) user group;
      inherit phpPackage;
      settings = mapAttrs (name: mkDefault) {
        "listen.owner" = "nginx";
        "listen.group" = "nginx";
        "listen.mode" = "0600";
        "pm" = "dynamic";
        "pm.max_children" = 5;
        "pm.start_servers" = 2;
        "pm.min_spare_servers" = 1;
        "pm.max_spare_servers" = 3;
        "pm.max_requests" = 500;
      };
      phpEnv = {
      };
    };

    services.nginx.enable = true;
    services.nginx.virtualHosts.${cfg.hostName} = {
      default = true;
      root = cfg.devDir;

      locations."/" = {
        index = "index.php";
        tryFiles = "$uri $uri/ /index.php?$args";
      };

      locations."~ \\.php$" = {
        extraConfig = ''
          fastcgi_pass unix:${config.services.phpfpm.pools.phpapp.socket};
          fastcgi_index index.php;
        '';
      };
    };

    services.redis.enable = true;

    services.mysql = lib.optionalAttrs cfg.database.createLocally {
      enable = true;
      bind = "127.0.0.1";
      package = pkgs.mariadb;
      ensureDatabases = [ cfg.database.name ];
      ensureUsers = lib.singleton
        { name = "${cfg.user}";
          ensurePermissions = { "${cfg.database.name}.*" = "ALL PRIVILEGES"; };
        };
    };

    services.mysqlBackup = lib.optionalAttrs cfg.database.createLocally {
      enable = true;
      databases = [ cfg.database.name ];
    };

    systemd.services.nginx.after = lib.optional cfg.database.createLocally "mysql.service";

    users.users.${cfg.user} = {
      group = cfg.group;
      home = cfg.devDir;
      isSystemUser = true;
      # allow login when mutable
      useDefaultShell = true;

      packages = with pkgs; [
        git
        mariadb
        phpPackage
        phpPackage.packages.composer
      ];
    };

    users.groups.${cfg.group} = {};

    systemd.tmpfiles.rules =
    [
      "C  ${cfg.devDir}                       0750 ${cfg.user} nginx    - ${cfg.package}"
      "Z  ${cfg.devDir}                       0750 ${cfg.user} nginx    -"
    ];

    environment = {
      homeBinInPath = true;
      shellAliases = {
        "mariadb.${cfg.database.name}" = "mariadb ${cfg.database.name}";
      };
    };

  };
}
