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
  networking.firewall.extraCommands = ''
    ip6tables -I INPUT -p tcp -m multiport --dports ${statusPorts} ! -s ${statusIp} -j DROP
    ip6tables -I INPUT -p tcp -m multiport --dports ${proxyPorts} ! -s ${proxyIp} -j DROP
    iptables -I INPUT -i lo -j ACCEPT
  '';
  networking.firewall.extraStopCommands = ''
    iptables -D INPUT -i lo -j ACCEPT || true
    ip6tables -D INPUT -p tcp -m multiport --dports ${statusPorts} ! -s ${statusIp} -j DROP || true
    ip6tables -D INPUT -p tcp -m multiport --dports ${proxyPorts} ! -s ${proxyIp} -j DROP || true
  '';

  # ipv6 only ct, this allows to reach v4 only docker registry
  # networking.proxy.default = "http://[${data.hosts.mesta-services-2.addr.pub.ipv6}]:3128";

  services.cityvizor = {
    enable = true;
    hostName = "beta.cityvizor.cz";
    containers = {
      enableCustomCNI = true;
      pinned = false;
      extraOptions = [ "--cgroup-manager=cgroupfs" ];
      tag = "staging";
    };
    database = {
      host = "pg.otevrenamesta.cz";
      name = "cvbeta";
      user = "cvbetauser";
      enableSSL = true;
    };
    demo.enable = true;
    s3 = {
      host = "minio.cityvizor.cz";
      port = 80;
      cdnHost = "https://minio.cityvizor.cz";
      privateBucket = "cityvizor-test";
      publicBucket = "cityvizor-test-public";
      accessKey = (import ../secrets/minio-cityvizor-test.nix).accessKey;
      secretKey = (import ../secrets/minio-cityvizor-test.nix).secretKey;
    };
    smtp = {
      enable = true;
      host = "mx.otevrenamesta.cz";
      user = "cvbeta@otevrenamesta.cz";
      password = (import ../secrets/cityvizor-beta.nix).smtpPassword;
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
    shellAliases = {
      "psql.beta" = "psql -h pg.otevrenamesta.cz -U cvbetauser cvbeta";
    };
  };

  networking.extraHosts = ''
    ${data.hosts.pg.addr.priv.ipv6} pg.otevrenamesta.cz
  '';

  om.wireguard = {
    enable = true;
    # route ipv4 traffic thru wg, since we don't have external v4 address
    allowedIPs = [ "0.0.0.0/0" "fc00::/64" ];
  };
}
