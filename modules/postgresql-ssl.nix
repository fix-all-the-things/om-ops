{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.services.postgresql;
  fqdn = config.services.postgresql.fqdn;
  copyCerts = ''
    cp ${config.security.acme.certs.${fqdn}.directory}/key.pem ${config.services.postgresql.dataDir}/key.pem
    cp ${config.security.acme.certs.${fqdn}.directory}/fullchain.pem ${config.services.postgresql.dataDir}/fullchain.pem
    chown postgres:postgres ${config.services.postgresql.dataDir}/{key,fullchain}.pem
    chmod 600 ${config.services.postgresql.dataDir}/{key,fullchain}.pem
  '';
in
{
  options = {
    services.postgresql = {
      enableSSL = mkEnableOption "SSL for PostgreSQL";
      enableACME = mkEnableOption "ACME certificate generation";
      preferServerCiphers = mkEnableOption "Prefer server cipher suite";
      fqdn = mkOption {
        type = types.str;
        description = ''
          Fully qualified domain name of this server.
          Must have DNS record for ACME to work.
        '';
      };
      serverAliases = mkOption {
        type = types.listOf types.str;
        default = [];
        description = ''
          Additional names to include in certificate.
        '';
      };
    };
  };

  config = mkIf cfg.enableSSL {
    services.postgresql.preferServerCiphers = mkDefault true;

    services.postgresql.settings = {
      ssl = "on";
      ssl_key_file = "key.pem";
      ssl_cert_file = "fullchain.pem";
    } // optionalAttrs cfg.preferServerCiphers {
      ssl_prefer_server_ciphers = "on";
    };

    services.nginx = optionalAttrs cfg.enableACME {
      enable = true;
      virtualHosts."${fqdn}" = {
        forceSSL = true;
        enableACME = true;
        serverAliases = cfg.serverAliases;
        root = mkDefault (pkgs.runCommand "hello-document-root" {} ''
          mkdir $out
          echo "Hello from ${fqdn}" > $out/index.html
        '');
      };
    };

    systemd.services.postgresql = optionalAttrs cfg.enableACME {
      wants = [ "acme-finished-${fqdn}.target" ];
      after = [ "acme-finished-${fqdn}.target" ];
      preStart = lib.mkAfter ''
        echo "Init certificates"
        ${copyCerts}
      '';
      serviceConfig.SupplementaryGroups = [ config.security.acme.certs."${fqdn}".group ];
    };

    security.acme.certs = optionalAttrs cfg.enableACME {
      "${fqdn}" = {
        postRun = ''
          test -d ${config.services.postgresql.dataDir} || {
            echo "No postgres dataDir yet, not updating"
            exit 0
          }
          echo "Copying updated certs"

          ${copyCerts}

          systemctl reload postgresql
        '';
      };
    };
  };
}
