{ config, lib, pkgs, ... }:
let
  replicationUser = "wal_recv";
  replicationSlot = "main_wal_receiver";
  pgPackage = pkgs.postgresql_12;
  data = import ../data;

  statusIp = data.hosts.status.addr.pub.ipv4;
  statusPorts = "9100,9187";
in
{

  imports = [
    ../modules/postgresql-ssl.nix
    ../modules/wireguard.nix
  ];

  services.openssh.ports = [ 12322 ];

  networking.firewall.allowedTCPPorts = [ 80 443 5432 ];

  # restrict connections to prometheus exporters to status.otevrenamesta.cz only
  # restrict connections to pg to specific hosts
  networking.firewall.extraCommands = ''
    iptables -I INPUT -p tcp -m multiport --dports ${statusPorts} ! -s ${statusIp} -j DROP
    iptables -I INPUT -p tcp --dport 5432 ! -s ${data.hosts.cv-prod.addr.pub.ipv4} -j DROP
    ip6tables -I INPUT -p tcp --dport 5432 ! -s ${data.hosts.cv-beta.addr.pub.ipv6} -j DROP
    iptables -I INPUT -i lo -j ACCEPT
  '';
  networking.firewall.extraStopCommands = ''
    iptables -D INPUT -i lo -j ACCEPT || true
    iptables -D INPUT -p tcp -m multiport --dports ${statusPorts} ! -s ${statusIp} -j DROP || true
    iptables -D INPUT -p tcp --dport 5432 ! -s ${data.hosts.cv-prod.addr.pub.ipv4} -j DROP || true
    ip6tables -D INPUT -p tcp --dport 5432 ! -s ${data.hosts.cv-beta.addr.pub.ipv6} -j DROP || true
  '';

  boot.kernel.sysctl."kernel.shmmax" = 1073741824; # 1024M
  services.postgresql = {
    enable = true;
    enableTCPIP = true;
    enableSSL = true;
    enableACME = true;
    fqdn = "pg.${data.domains.om}";
    serverAliases = [ "pg.${data.domains.cv}" ];

    package = pgPackage;
    extraPlugins = with pgPackage.pkgs; [
      postgis
      timescaledb
    ];
    ensureDatabases = [
      "cvbeta"
      "cvprod"
      "bench"
    ];
    ensureUsers = [
      { name = "cvproduser";
        ensurePermissions = {
          "DATABASE cvprod" = "ALL PRIVILEGES";
        };
      }
      { name = "cvbetauser";
        ensurePermissions = {
          "DATABASE cvbeta" = "ALL PRIVILEGES";
        };
      }
    ];
    authentication = ''
      hostssl cvprod cvproduser ${data.hosts.cv-prod.addr.pub.ipv4}/32 trust
      hostssl cvbeta cvbetauser ${data.hosts.cv-beta.addr.pub.ipv6}/128 trust
      # - sample
      # hostssl replication ${replicationUser} 127.0.0.1/32 trust
    '';

    # shared_buffers to 25% of the memory in your system.
    settings = {
      shared_buffers = "1024MB";
      temp_buffers = "8MB";
      work_mem = "16MB";
      max_connections = 250;
      max_stack_depth = "1MB";
      log_connections = true;
      wal_level = "replica";
      max_wal_senders = 10;
      max_replication_slots = 10;
    };

    initialScript = pkgs.writeText "pg-init-script" ''
      CREATE ROLE ${replicationUser} LOGIN REPLICATION;
      SELECT * FROM pg_create_physical_replication_slot('${replicationSlot}');

    '';
  };

  services.postgresqlBackup = {
    enable = true;
  };

  services.prometheus.exporters.postgres = {
    enable = true;
    openFirewall = true;
    runAsLocalSuperUser = true;
  };

  om.wireguard = {
    enable = true;
    ips = [
      "${data.hosts.cv-beta.addr.priv.ipv4}/32"
      "${data.hosts.cv-beta.addr.priv.ipv6}/128"
    ];
  };
}
