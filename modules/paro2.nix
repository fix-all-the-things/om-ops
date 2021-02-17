{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.services.paro2;
  pkg = import ../packages/participativni-rozpocet { inherit pkgs; };
  baseDir = "/var/lib/paro2";
  user = "paro2";
  dbName = user;
  group = user;

  # XXX: switch mail to tls
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
              'database' => '${dbName}',
          ],
      ],
      'EmailTransport' => [
          'default' => [
              'host' => '${cfg.smtp.host}',
              'port' => ${builtins.toString cfg.smtp.port},
              'username' => null,
              'password' => null,
              'client' => null,
              'tls' => false,
          ],
      ],
  ];
  '';
in
{
  options = {
    services.paro2 = {
      enable = mkEnableOption "participativni rozpocet 2";
      debug = mkEnableOption "debugging";

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

      smtp = {
        enable = mkEnableOption "SMTP";

        host = mkOption {
          description = "SMTP host to connect to";
          default = "localhost";
          type = types.str;
        };

        port = mkOption {
          description = "SMTP port";
          default = 25;
          type = types.port;
        };
      };
    };
  };

  config = mkIf cfg.enable {

    services.phpfpm.pools.paro2 = {
      inherit user;
      inherit group;
      phpPackage = pkgs.php74.buildEnv {
        extensions = { enabled, all }: with all;
          enabled ++ [ redis ];
      };
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
        "APPDIR_LOGS" = "${baseDir}/logs";
        "APPDIR_TMP" = "${baseDir}/tmp";
        "APPDIR_CACHE" = "${baseDir}/tmp/cache";
        "APPDIR_CONFIG" = "${baseDir}/config";
      };
    };

    services.nginx.enable = true;
    services.nginx.virtualHosts.${cfg.hostName} = {
      default = true;
      root = "${pkg}/webroot";

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

    services.mysql = {
      enable = true;
      bind = "127.0.0.1";
      package = pkgs.mariadb;
      ensureDatabases = [ dbName ];
      ensureUsers = lib.singleton
        { name = "${user}";
          ensurePermissions = { "${dbName}.*" = "ALL PRIVILEGES"; };
        };
    };

    systemd.services.nginx.after = [ "mysql.service" ];
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
      home = baseDir;
      isSystemUser = true;
    };

    users.groups.${group} = {};

    systemd.tmpfiles.rules = let
      writable = [ "logs" "tmp" "tmp/cache" "tmp/cache/models" "tmp/cache/persistent" "tmp/cache/views" "tmp/sessions" "tmp/tests" ];
    in
    [
      "d  ${baseDir}                      0511 ${user} ${group} - -"
      "C  ${baseDir}/config               -    -       -        - ${pkg}/config"
      "L+ ${baseDir}/config/app_local.php -    -       -        - ${cfg.configFile}"
      "d  ${baseDir}/secrets              0770 ${user} ${group} - -"
    ] ++ (flip map writable (d:
      "d  ${baseDir}/${d}                 0700 ${user} ${group} - -"
    ));

  };
}
