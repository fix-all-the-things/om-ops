{ config, lib, pkgs, ... }:
let
  proxyIp = "37.205.14.17";
  proxyPorts = "80";
  statusIp = "83.167.228.98";
  statusPorts = "9100";

  # IP address for containers on host side
  ctHostIp = "192.168.123.1";
  ctMinioIp = "192.168.123.2";
in
{
  services.openssh.ports = [ 12322 ];

  networking.firewall.allowedTCPPorts = [
    22 # forwarded to shells ct
    80 # nginx
    3128 # squid ct, has its own acl
  ];

  # restrict incoming connections to proxy.otevrenamesta.cz only
  # to prevent X-Real-Ip: etc header spoofing
  networking.firewall.extraCommands = ''
    iptables -I INPUT -i lo -j ACCEPT
    iptables -I INPUT -p tcp -m multiport --dports ${proxyPorts} ! -s ${proxyIp} -j DROP
    iptables -I INPUT -p tcp -m multiport --dports ${statusPorts} ! -s ${statusIp} -j DROP
  '';
  networking.firewall.extraStopCommands = ''
    iptables -I INPUT -i lo -j ACCEPT
    iptables -D INPUT -p tcp -m multiport --dports ${proxyPorts} ! -s ${proxyIp} -j DROP || true
    iptables -D INPUT -p tcp -m multiport --dports ${statusPorts} ! -s ${statusIp} -j DROP || true
  '';

  # enable nat for containers
  # for containers with private network this allows internet access from within
  # XXX: as of 21.05 we can also add networking.nat.enableIPv6 and isolate e.g. users as well
  networking.nat.enable = true;
  networking.nat.internalInterfaces = ["ve-+"];
  networking.nat.externalInterface = "venet0";

  boot.enableContainers = true;

  containers = {
    shells = {
      autoStart = true;
      config = { config, pkgs, ... }: {
        imports = [ ../env.nix ];
        environment.systemPackages = with pkgs; [
          minio-client
          dnsutils
        ];

        networking.firewall.allowedTCPPorts = [ 8000 ];

        services.openssh.enable = true;
        services.nginx = {
          enable = true;
          virtualHosts.def = {
            default = true;
            listen = [ { addr = "localhost"; port = 8000; } ];
            locations."~ ^/~(.+?)(/.*)?$" = {
              alias = "/home/$1/public_html$2";
              extraConfig = ''
                 index index.html index.htm;
                 autoindex on;
              '';

            };
            root = pkgs.runCommand "hello-document-root" {} ''
              mkdir $out
              echo "Hello from users.otevrenamesta.cz" > $out/index.html
            '';
          };
        };

        # to be able to read user dirs
        # user needs to
        /*
        chmod o+x ~
        mkdir public_html
        echo "Hello" > public_html/index.html
        chmod o+x public_html/
        chmod o+r public_html/index.html
        */
        # and we also need to switch
        systemd.services.nginx.serviceConfig.ProtectHome = "read-only";

        users.users = {
          lada = {
            isNormalUser = true;
            createHome = true;
            uid = 1000;
            openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [ ln ];
          };
          srk = {
            isNormalUser = true;
            createHome = true;
            uid = 1001;
            openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [ srk ];
          };
          b42 = {
            isNormalUser = true;
            createHome = true;
            uid = 1002;
            openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [ mm ];
          };
          smarek = {
            isNormalUser = true;
            createHome = true;
            uid = 1003;
            openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [ ms ];
          };
          srdecny = {
            isNormalUser = true;
            createHome = true;
            uid = 1004;
            openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [ vs ];
          };
          vencax = {
            isNormalUser = true;
            createHome = true;
            uid = 1005;
            openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [ vk ];
          };
        };
      };
    };

    minio = {
      autoStart = true;
      privateNetwork = true;
      hostAddress = ctHostIp;
      localAddress = ctMinioIp;
      forwardPorts = [ { protocol = "tcp"; hostPort = 9000; containerPort = 9000; } ];

      config = { config, pkgs, ... }: {
        imports = [ ];

        networking.firewall.allowedTCPPorts = [ 9000 ];

        services.minio = {
          enable = true;
          browser = true;
          region = "eu-central-1";
          accessKey = (import ../secrets/minio.nix).accessKey;
          secretKey = (import ../secrets/minio.nix).secretKey;
        };
      };
    };

    squid = {
      autoStart = true;
      ephemeral = true;

      config = { config, pkgs, ... }: {
        imports = [ ];

        networking.firewall.allowedTCPPorts = [ 3128 ];
        services.squid = {
          enable = true;
          proxyPort = 3128;
          extraConfig = ''
            acl localnet src 2a03:3b40:fe:a4::1
            cache deny all
          '';
        };
      };
    };

    /*
    template = {
      autoStart = true;
      config = { config, pkgs, ... }: {
        imports = [ ];
      };
    };
    */

  };

  services.nginx = {
    enable = true;
    clientMaxBodySize = "2G";
    recommendedOptimisation = true;
    recommendedProxySettings = true;

    virtualHosts = {
      "minio.cityvizor.cz" = {
        serverAliases = [ "minio.otevrenamesta.cz" ];
        locations = {
          "/" = {
            proxyPass = "http://${ctHostIp}:9000";
          };
        };
      };
      "users.otevrenamesta.cz" = {
        locations = {
          "/" = {
            proxyPass = "http://localhost:8000";
          };
        };
      };
    };
  };
}
