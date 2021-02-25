{ config, lib, pkgs, ... }:
let
  data = import ../data;

  statusIp = data.hosts.status.addr.pub.ipv6;
  statusPorts = "9100";

  proxyIp = data.hosts.proxy.addr.pub.ipv6;
  proxyPorts = "80";
in
{

  imports = [
    ../modules/cityvizor-oci.nix
    ../modules/wireguard.nix
  ];

  services.openssh.ports = [ 12322 ];

  users.extraUsers.root.openssh.authorizedKeys.keys =
    with import ../ssh-keys.nix; [ ms vs ];

  networking.firewall.allowedTCPPorts = [ 80 15432 ];

  # restrict connections to prometheus exporters to status.otevrenamesta.cz only
  # restrict connections to nginx to proxy
  networking.firewall.extraCommands = ''
    ip6tables -I INPUT -p tcp --dport 15432 -j DROP
    ip6tables -I INPUT -p tcp -m multiport --dports ${statusPorts} ! -s ${statusIp} -j DROP
    ip6tables -I INPUT -p tcp -m multiport --dports ${proxyPorts} ! -s ${proxyIp} -j DROP
    iptables -I INPUT -i lo -j ACCEPT
  '';
  networking.firewall.extraStopCommands = ''
    iptables -D INPUT -i lo -j ACCEPT || true
    ip6tables -D INPUT -p tcp -m multiport --dports ${statusPorts} ! -s ${statusIp} -j DROP || true
    ip6tables -D INPUT -p tcp -m multiport --dports ${proxyPorts} ! -s ${proxyIp} -j DROP || true
    ip6tables -D INPUT -p tcp --dport 15432 -j DROP || true
  '';

  # ipv6 only ct, this allows to reach v4 only docker registry
  # networking.proxy.default = "http://[${data.hosts.mesta-services-2.addr.pub.ipv6}]:3128";

  services.cityvizor = {
    enable = true;
    containers = {
      pinned = false;
      extraOptions = [ "--cgroup-manager=cgroupfs" ];
      tag = "staging";
    };
    database = {
      host = "pg.cityvizor.cz";
      port = 15432;
      name = "cvbeta";
      user = "cvbetauser";
      enableSSL = true;
    };
    s3 = {
      host = "minio.cityvizor.cz";
      port = 80;
      cdnHost = "https://minio.cityvizor.cz";
      privateBucket = "cityvizor-test";
      publicBucket = "cityvizor-test-public";
      accessKey = (import ../secrets/minio-cityvizor-test.nix).accessKey;
      secretKey = (import ../secrets/minio-cityvizor-test.nix).secretKey;
    };

    landing-page.settings.tracking.html = [
      (builtins.readFile ../files/cityvizor-matomo.html)
      (builtins.readFile ../files/cityvizor-google-analytics.html)
    ];
    landing-page.settings.tracking.js = [
      (builtins.readFile ../files/cityvizor-matomo.js)
      (builtins.readFile ../files/cityvizor-google-analytics.js)
    ];
  };

  environment = {
    systemPackages = with pkgs; [
      cntr
      postgresql_12
    ];
    shellAliases = {
      "psql.beta" = "psql -h 10.88.0.1 -p 15432 -U cvbetauser cvbeta";
    };
  };

  # hack around v4 container not able to access v6 pg
  systemd.services.socat-bridge = {
    wantedBy = [ "multi-user.target" ];
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.socat}/bin/socat tcp-listen:15432,reuseaddr,fork tcp6:[${data.hosts.pg.addr.pub.ipv6}]:5432";
      Restart = "always";
    };
  };

  networking.extraHosts = ''
    10.88.0.1 pg.cityvizor.cz
  '';
  # end of hack

  om.wireguard = {
    enable = true;
    # route ipv4 traffic thru wg, since we don't have external v4 address
    allowedIPs = [ "0.0.0.0/0" ];
  };
}
