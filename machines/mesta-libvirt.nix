{ config, lib, pkgs, ... }:
let
  brDev = config.virtualisation.libvirtd.networking.bridgeName;
  extIf = "venet0";
  statusIp = "83.167.228.98";
  statusPorts = "9100,9113,9154,7980";
  data = import ../data;
in
{
  imports = [
    ../modules/libvirt.nix
    ../modules/deploy.nix
  ];

  # restrict connections to prometheus exporters to status.otevrenamesta.cz only
  networking.firewall.extraCommands = ''
    iptables -I FORWARD -o ${brDev} -p tcp -m multiport --dports ${statusPorts} ! -s ${statusIp} -j DROP
    iptables -I INPUT -i lo -j ACCEPT
    iptables -I INPUT -p tcp -m multiport --dports ${statusPorts} ! -s ${statusIp} -j DROP
    ip6tables -I INPUT -p tcp -m multiport --dports ${statusPorts} -j DROP
  '';
  networking.firewall.extraStopCommands = ''
    iptables -D FORWARD -o ${brDev} -p tcp -m multiport --dports ${statusPorts} ! -s ${statusIp} -j DROP || true
    iptables -D INPUT -i lo -j ACCEPT || true
    iptables -D INPUT -p tcp -m multiport --dports ${statusPorts} ! -s ${statusIp} -j DROP || true
    ip6tables -D INPUT -p tcp -m multiport --dports ${statusPorts} -j DROP || true
  '';

  virtualisation.libvirtd = {
    enable = true;
    networking = {
      enable = true;
      externalInterface = extIf;
      infiniteLeaseTime = true;
      ipv6 = {
        network = "fda7:1646:3af8:666e::/64";
        hostAddress = "fda7:1646:3af8:666e::1";
        forwardPorts = [
          # proxy
          { destination = "[fda7:1646:3af8:666e:5054:ff:fe27:cbe]:80";  sourcePort = 80; }
          { destination = "[fda7:1646:3af8:666e:5054:ff:fe27:cbe]:443"; sourcePort = 443; }

          # mail
          { destination = "[fda7:1646:3af8:666e:5054:ff:fe6b:6c86]:25"; sourcePort = 25; }
          { destination = "[fda7:1646:3af8:666e:5054:ff:fe6b:6c86]:143"; sourcePort = 143; }
          { destination = "[fda7:1646:3af8:666e:5054:ff:fe6b:6c86]:465"; sourcePort = 465; }
          { destination = "[fda7:1646:3af8:666e:5054:ff:fe6b:6c86]:587"; sourcePort = 587; }
          { destination = "[fda7:1646:3af8:666e:5054:ff:fe6b:6c86]:993"; sourcePort = 993; }
          { destination = "[fda7:1646:3af8:666e:5054:ff:fe6b:6c86]:995"; sourcePort = 995; }
          { destination = "[fda7:1646:3af8:666e:5054:ff:fe6b:6c86]:4190"; sourcePort = 4190; }
          { destination = "[fda7:1646:3af8:666e:5054:ff:fe6b:6c86]:12340"; sourcePort = 12340; }
        ];
      };
    };
  };

  networking.nat = {
     externalInterface = extIf;
     internalInterfaces = [ "wg0" ];
     forwardPorts = [
       { destination = "192.168.122.100:25";    sourcePort = 25;}    # mail SMTP
       { destination = "192.168.122.100:110";   sourcePort = 110;}   # mail POP3
       { destination = "192.168.122.100:143";   sourcePort = 143;}   # mail IMAP
       { destination = "192.168.122.100:465";   sourcePort = 465;}   # mail Message Submission, SSL
       { destination = "192.168.122.100:587";   sourcePort = 587;}   # mail Message Submission
       { destination = "192.168.122.100:993";   sourcePort = 993;}   # mail IMAPS, SSL
       { destination = "192.168.122.100:995";   sourcePort = 995;}   # mail POP3S, SSL
       { destination = "192.168.122.100:4190";  sourcePort = 4190;}  # mail dovecot
       { destination = "192.168.122.100:12340"; sourcePort = 12340;} # mail dovecot
       { destination = "192.168.122.100:9100";  sourcePort = 10091;} # mail prometheus node collector
       { destination = "192.168.122.100:9154";  sourcePort = 10094;} # mail prometheus postfix collector
       { destination = "192.168.122.100:7980";  sourcePort = 10098;} # mail prometheus rspamd collector

       { destination = "192.168.122.101:9100";  sourcePort = 10191;} # sympa prometheus node collector

       { destination = "192.168.122.103:9100";  sourcePort = 10391;} # matomo prometheus node collector

       { destination = "192.168.122.104:80";    sourcePort = 80;}    # proxy web
       { destination = "192.168.122.104:443";   sourcePort = 443;}   # proxy ssl
       { destination = "192.168.122.104:9100";  sourcePort = 10491;} # proxy prometheus node collector
       { destination = "192.168.122.104:9113";  sourcePort = 10493;} # proxy prometheus nginx collector

       { destination = "192.168.122.105:9100";  sourcePort = 10591;} # mediawiki prometheus node collector
     ];
  };

  # wireguard
  networking.firewall.allowedUDPPorts = [ 23333 ];
  networking.wireguard.interfaces.wg0 = {
    ips = [
      "${data.hosts.mesta-libvirt.addr.priv.ipv4}/32"
      "${data.hosts.mesta-libvirt.addr.priv.ipv6}/128"
    ];
    listenPort = 23333;
    privateKeyFile = "/secrets/wireguard/private";

    peers =
    let makePeer = host:
      let hostData = data.hosts.${host};
      in { allowedIPs = [
            "${hostData.addr.priv.ipv4}/32"
            "${hostData.addr.priv.ipv6}/128"
          ];
          inherit (hostData.wg) publicKey;
         };

    in map makePeer [
      "cv-beta"
      "cv-prod"
      "mesta-services"
      "mesta-services-2"
      "pg"
      "status"
    ];
  };
}
