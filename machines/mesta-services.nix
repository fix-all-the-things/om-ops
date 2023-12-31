{ config, lib, pkgs, ... }:
let
  brDev = config.virtualisation.libvirtd.networking.bridgeName;
  extIf = "venet0";
  data = import ../data;
  proxyIp = data.hosts.proxy.addr.pub.ipv4;
  proxyPorts = "80,8000,8001,8002,8008,8080";
  statusIp =  data.hosts.status.addr.pub.ipv4;
  statusPorts = "9100,9187,9113";
in
{
  imports = [
    ../modules/libvirt.nix
    ../modules/wireguard.nix
  ];

  om.wireguard.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    networking = {
      enable = true;
      externalInterface = extIf;
      infiniteLeaseTime = true;
      ipv6 = {
        network = "fda7:1646:3af8:666d::/64";
        hostAddress = "fda7:1646:3af8:666d::1";
        forwardPorts = [
          #{ destination = "[fda7:1646:3af8:666d:5054:ff:fe27:cbe]:22";  sourcePort = 22; }
          #{ destination = "[fda7:1646:3af8:666d:5054:ff:fe27:cbe]:80";  sourcePort = 80; }
          #{ destination = "[fda7:1646:3af8:666d:5054:ff:fe27:cbe]:443"; sourcePort = 443; }
        ];
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 ];

  # restrict incoming connections to proxy.otevrenamesta.cz only
  # to prevent X-Real-Ip: etc header spoofing
  # also restrict connections to prometheus exporters to status.otevrenamesta.cz only
  networking.firewall.extraCommands = ''
    iptables -I FORWARD -o ${brDev} -p tcp -m multiport --dports ${proxyPorts} ! -s ${proxyIp} -j DROP
    iptables -I FORWARD -o ${brDev} -p tcp -m multiport --dports ${statusPorts} ! -s ${statusIp} -j DROP
    iptables -I INPUT -i lo -j ACCEPT
    iptables -I INPUT -p tcp -m multiport --dports ${proxyPorts} ! -s ${proxyIp} -j DROP
    iptables -I INPUT -p tcp -m multiport --dports ${statusPorts} ! -s ${statusIp} -j DROP
    ip6tables -I INPUT -p tcp -m multiport --dports ${proxyPorts} ! -s ${data.hosts.proxy.addr.pub.ipv6} -j DROP
    ip6tables -I INPUT -p tcp -m multiport --dports ${statusPorts} -j DROP
  '';
  networking.firewall.extraStopCommands = ''
    iptables -D FORWARD -o ${brDev} -p tcp -m multiport --dports ${proxyPorts} ! -s ${proxyIp} -j DROP || true
    iptables -D FORWARD -o ${brDev} -p tcp -m multiport --dports ${statusPorts} ! -s ${statusIp} -j DROP || true
    iptables -D INPUT -i lo -j ACCEPT || true
    iptables -D INPUT -p tcp -m multiport --dports ${proxyPorts} ! -s ${proxyIp} -j DROP || true
    iptables -D INPUT -p tcp -m multiport --dports ${statusPorts} ! -s ${statusIp} -j DROP || true
    ip6tables -D INPUT -p tcp -m multiport --dports ${proxyPorts} ! -s ${data.hosts.proxy.addr.pub.ipv6} -j DROP || true
    ip6tables -D INPUT -p tcp -m multiport --dports ${statusPorts} -j DROP || true
  '';

  networking.nat = {
    forwardPorts = [
      { destination = "192.168.122.102:22"; sourcePort = 10222;}    # consul ssh
      { destination = "192.168.122.103:22"; sourcePort = 10322;}    # roundcube ssh
      { destination = "192.168.122.104:22"; sourcePort = 10422;}    # glpi ssh
      { destination = "192.168.122.105:22"; sourcePort = 10522;}    # wp ssh
      { destination = "192.168.122.107:22"; sourcePort = 10722;}    # nia ssh
      { destination = "192.168.122.108:22"; sourcePort = 10822;}    # ucto ssh
      { destination = "192.168.122.109:22"; sourcePort = 10922;}    # matrix ssh
      { destination = "192.168.122.111:22"; sourcePort = 11122;}    # dsw-test ssh

      { destination = "192.168.122.103:80"; sourcePort = 10380;}    # roundcube http
      { destination = "192.168.122.104:80"; sourcePort = 10480;}    # glpi http
      { destination = "192.168.122.105:80"; sourcePort = 10580;}    # wp http
      { destination = "192.168.122.107:80"; sourcePort = 10780;}    # nia http
      { destination = "192.168.122.108:80"; sourcePort = 10880;}    # ucto http
      { destination = "192.168.122.109:80"; sourcePort = 10980;}    # matrix http (riot)
      { destination = "192.168.122.111:80"; sourcePort = 11180;}    # dsw-test http

      { destination = "192.168.122.104:9100"; sourcePort = 10491;}  # glpi prometheus node exporter
      { destination = "192.168.122.105:9100"; sourcePort = 10591;}  # wp prometheus node exporter
      { destination = "192.168.122.107:9100"; sourcePort = 10791;}  # nia prometheus node exporter
      { destination = "192.168.122.109:9100"; sourcePort = 10991;}  # matrix prometheus node exporter
      { destination = "192.168.122.109:9187"; sourcePort = 10997;}  # matrix prometheus postgresql exporter
      { destination = "192.168.122.109:9113"; sourcePort = 10993;}  # matrix prometheus nginx exporter

      { destination = "192.168.122.109:8448"; sourcePort = 10984;}  # matrix synapse (clients+federation)
      { destination = "192.168.122.109:9898"; sourcePort = 10985;}  # matrix slack bridge
    ];
  };

  virtualisation.docker.enable = true;

  services.mysql.enable = true;
  services.mysql.package = pkgs.mysql;
  services.mysqlBackup = {
    enable = true;
    databases = [ "glpi" ];
  };

  services.nginx = {
    enable = true;
    clientMaxBodySize = "2G";
    recommendedProxySettings = true;

    virtualHosts = {
      "forum.vesp.cz" = {
        locations = {
          "/" = {
            proxyPass = "http://unix:/var/discourse/shared/standalone/nginx.http.sock:";
            extraConfig = ''
              proxy_set_header X-Forwarded-Proto https;
            '';
          };
        };
      };
    };
  };
}
