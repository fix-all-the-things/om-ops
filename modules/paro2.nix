{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.services.paro2;
  baseDir = "/var/lib/paro2";
  user = "paro2";
  group = user;
  devDir = "/var/www/paro2";

  phpPackage = pkgs.php74.buildEnv {
    extensions = { enabled, all }: with all;
      enabled ++ [ redis ];
  };

  generatedConfig = pkgs.writeText "config.php" ''
  <?php
  return [
      'debug' => ${if cfg.debug then "true" else "false"},
      'Security' => [
          'salt' => file_get_contents("${baseDir}/secrets/salt"),
      ],
      'Datasources' => [
          'default' => [
              'host' => 'localhost',
              'unix_socket' => '/run/mysqld/mysqld.sock',
              'username' => '${user}',
              'database' => '${cfg.database.name}',
          ],
      ],
      'EmailTransport' => [
          'default' => [
              'host' => '${cfg.smtp.host}',
              'port' => ${builtins.toString cfg.smtp.port},
              'username' => ${showNull cfg.smtp.user},
              'password' => ${showNull cfg.smtp.password},
              'client' => null,
              'tls' => ${toString cfg.smtp.tls},
          ],
      ],
  ];
  '';

  showNull = x: if isNull x then "null" else x;
in
{
  options = {
    services.paro2 = {
      enable = mkEnableOption "participativni rozpocet 2";
      debug = mkEnableOption "debugging";
      develop = mkEnableOption "mutable deployment for development";

      hostName = mkOption {
        type = types.str;
        default = "paro2.otevrenamesta.cz";
        description = ''
          Host name where this application is going to be served.

          Creates nginx vhost which you can further modify under
          <option>services.nginx.virtualHosts."$${hostName}"</option>
        '';
      };

      configFile = mkOption {
        type = types.path;
        example = "/var/lib/paro2/config.php";
        default = generatedConfig;
        description = ''
          Path to the file that will be used as <filename>config/app.php</filename>.
        '';
      };

      package = mkOption {
        type = types.path;
        default = import ../packages/participativni-rozpocet { inherit pkgs; };
      };

      database = {
        createLocally = mkOption {
          type = types.bool;
          default = false;
          description = "Whether to create a local database automatically.";
        };

        name = mkOption {
          type = types.str;
          default = "paro2";
          description = "Database name.";

        };
      };

      smtp = {
        enable = mkEnableOption "SMTP";

        host = mkOption {
          description = "SMTP host to connect to";
          default = "localhost";
          type = types.str;
        };

        port = mkOption {
          description = "SMTP port";
          type = types.port;
        };

        user = mkOption {
          description = "SMTP user name";
          type = types.nullOr types.str;
          default = null;
        };

        password = mkOption {
          description = "SMTP password";
          type = types.nullOr types.str;
          default = null;
        };

        tls = mkEnableOption "SMTP TLS";
      };
    };
  };

  config = mkIf cfg.enable {

    services.paro2 = {
      debug = mkDefault cfg.develop;
      database.createLocally = mkDefault cfg.develop;
      smtp = {
        port = mkDefault 587;
        tls = mkDefault true;
      };
    };

    services.phpfpm.pools.paro2 = {
      inherit user;
      inherit group;
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
      phpEnv = optionalAttrs (!cfg.develop) {
        "APPDIR_LOGS" = "${baseDir}/logs";
        "APPDIR_TMP" = "${baseDir}/tmp";
        "APPDIR_CACHE" = "${baseDir}/tmp/cache";
        "APPDIR_CONFIG" = "${baseDir}/config";
      };
    };

    services.nginx.enable = true;
    services.nginx.virtualHosts.${cfg.hostName} = {
      default = true;
      root =
        if cfg.develop
          then "${devDir}/webroot"
          else "${cfg.package}/webroot";

      locations."/" = {
        index = "index.php";
        tryFiles = "$uri $uri/ /index.php?$args";
      };

      locations."~ \\.php$" = {
        extraConfig = ''
          fastcgi_pass unix:${config.services.phpfpm.pools.paro2.socket};
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
        { name = "${user}";
          ensurePermissions = { "${cfg.database.name}.*" = "ALL PRIVILEGES"; };
        };
    };

    services.mysqlBackup = lib.optionalAttrs cfg.database.createLocally {
      enable = true;
      databases = [ cfg.database.name ];
    };

    systemd.services.nginx.after = lib.optional cfg.database.createLocally "mysql.service";
    systemd.services.paro2-init = {
      wantedBy = [ "multi-user.target" ];
      before = [ "phpfpm-paro2.service" ];
      script = ''
        if ! test -e "${baseDir}/secrets/salt"; then
          echo "No salt, generating"
          tr -dc A-Za-z0-9 </dev/urandom 2>/dev/null | head -c 64 > "${baseDir}/secrets/salt"
        fi
      '';

      serviceConfig = {
        Type = "oneshot";
        User = user;
        Group = group;
        PrivateTmp = true;
      };
    };

    users.users.${user} = {
      inherit group;
      home =
        if cfg.develop
          then devDir
          else baseDir;
      isSystemUser = true;
      # allow login when mutable
      useDefaultShell = cfg.develop;

      packages = optionals cfg.develop (with pkgs; [
        git
        mariadb
        phpPackage
        phpPackage.packages.composer
      ]);
    };

    users.groups.${group} = {};

    systemd.tmpfiles.rules = let
      writable = [ "logs" "tmp" "tmp/cache" "tmp/cache/models" "tmp/cache/persistent" "tmp/cache/views" "tmp/sessions" "tmp/tests" ];
    in
    [
      "d  ${baseDir}                      0511 ${user} ${group} - -"
      "C  ${baseDir}/config               -    -       -        - ${cfg.package}/config"
      "L+ ${baseDir}/config/app_local.php -    -       -        - ${cfg.configFile}"
      "d  ${baseDir}/secrets              0770 ${user} ${group} - -"
    ] ++ (flip map writable (d:
      "d  ${baseDir}/${d}                 0700 ${user} ${group} - -"
    )) ++ optionals cfg.develop [
      "C  ${devDir}                       0750 ${user} nginx    - ${cfg.package}"
      "Z  ${devDir}                       0750 ${user} nginx    -"
      "C  ${devDir}/config/app_local.php  0750 ${user} nginx    - ${cfg.configFile}"
    ];

    # bin/cake
    environment = optionalAttrs cfg.develop {
      homeBinInPath = true;
      shellAliases = {
        bake = "cake bake";
        "mariadb.${cfg.database.name}" = "mariadb ${cfg.database.name}";
      };
    };

  };
}
