{ config, lib, pkgs, ... }:
let
  data = import ../data;

  statusIp = data.hosts.status.addr.pub.ipv6;
  statusPorts = "9100";

  proxyIp = data.hosts.status.addr.pub.ipv6;
  proxyPorts = "80";
in
{

  imports = [
    ../modules/cityvizor-oci.nix
  ];

  networking.firewall.allowedTCPPorts = [ 5432 ];

  # restrict connections to prometheus exporters to status.otevrenamesta.cz only
  # restrict connections to pg to specific hosts
  networking.firewall.extraCommands = ''
    iptables -I INPUT -i lo -j ACCEPT
    ip6tables -I INPUT -p tcp -m multiport --dports ${statusPorts} ! -s ${statusIp} -j DROP
    ip6tables -I INPUT -p tcp -m multiport --dports ${proxyPorts} ! -s ${proxyIp} -j DROP
  '';
  networking.firewall.extraStopCommands = ''
    iptables -D INPUT -i lo -j ACCEPT || true
    ip6tables -D INPUT -p tcp -m multiport --dports ${statusPorts} ! -s ${statusIp} -j DROP || true
    ip6tables -D INPUT -p tcp -m multiport --dports ${proxyPorts} ! -s ${proxyIp} -j DROP || true
  '';

  # ipv6 only ct, this allows to reach v4 only docker registry
  networking.proxy.default = "http://[${data.hosts.mesta-services-2.addr.pub.ipv6}]:3128";

  services.cityvizor = {
    enable = true;
    containers = {
      pinned = false;
      extraOptions = [ "--cgroup-manager=cgroupfs" ];
    };
    database = {
      host = "pg.cityvizor.cz";
      name = "cvbeta";
      user = "cvbetauser";
      enableSSL = true;
    };
  };
}
