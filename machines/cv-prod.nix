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

  networking.firewall.allowedTCPPorts = [ 80 ];

  # restrict connections to prometheus exporters to status.otevrenamesta.cz only
  # restrict connections to nginx to proxy
  # v6 only, drop v4
  networking.firewall.extraCommands = ''
    ip6tables -I INPUT -p tcp -m multiport --dports ${statusPorts} ! -s ${statusIp} -j DROP
    ip6tables -I INPUT -p tcp -m multiport --dports ${proxyPorts} ! -s ${proxyIp} -j DROP
    iptables -I INPUT -p tcp -m multiport --dports ${proxyPorts} -j DROP
    iptables -I INPUT -p tcp -m multiport --dports ${statusPorts} -j DROP
    iptables -I INPUT -i lo -j ACCEPT
  '';
  networking.firewall.extraStopCommands = ''
    iptables -D INPUT -i lo -j ACCEPT || true
    iptables -D INPUT -p tcp -m multiport --dports ${statusPorts} -j DROP || true
    iptables -D INPUT -p tcp -m multiport --dports ${proxyPorts} -j DROP || true
    ip6tables -D INPUT -p tcp -m multiport --dports ${statusPorts} ! -s ${statusIp} -j DROP || true
    ip6tables -D INPUT -p tcp -m multiport --dports ${proxyPorts} ! -s ${proxyIp} -j DROP || true
  '';

  services.cityvizor = {
    enable = true;
    containers = {
      # XXX: pin and use proper tag
      pinned = false;
      tag = "master";
      extraOptions = [ "--cgroup-manager=cgroupfs" ];
    };
    database = {
      host = "pg.cityvizor.cz";
      port = 5432;
      name = "cvprod";
      user = "cvproduser";
      enableSSL = true;
    };
    s3 = {
      host = "minio.cityvizor.cz";
      port = 80;
      cdnHost = "https://minio.cityvizor.cz";
      privateBucket = "cityvizor";
      publicBucket = "cityvizor-public";
      accessKey = (import ../secrets/minio-cityvizor.nix).accessKey;
      secretKey = (import ../secrets/minio-cityvizor.nix).secretKey;
    };
    smtp = {
      enable = true;
      host = "mx.otevrenamesta.cz";
      user = "cvprod";
      password = (import ../secrets/cityvizor.nix).smtpPassword;
    };

    landing-page.settings.tracking.html = [
      (builtins.readFile ../files/cityvizor-matomo.html)
      (builtins.readFile ../files/cityvizor-google-analytics.html)
    ];
    landing-page.settings.tracking.scripts = [
      (builtins.readFile ../files/cityvizor-matomo.js)
      (builtins.readFile ../files/cityvizor-google-analytics.js)
    ];
  };

  environment = {
    systemPackages = with pkgs; [
      cntr
      postgresql_12
    ];
  };

  om.wireguard.enable = true;
}
