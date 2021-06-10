{ config, lib, pkgs, ... }:
let
  proxyIp = "37.205.14.17";
  proxyPorts = "80";
  statusIp = "83.167.228.98";
  statusPorts = "9100";

  # IP address for containers on host side
  ctHostIp = "192.168.123.1";
  ctMinioIp = "192.168.123.2";
  ctParo2Ip = "192.168.123.3";
  ctParo2BetaIp = "192.168.123.4";
  ctNiaIp = "192.168.123.5";
  ctWpdevIp = "192.168.123.6";
in
{
  imports = [
    ../modules/wireguard.nix
  ];

  om.wireguard.enable = true;

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
    ip6tables -I INPUT -p tcp -m multiport --dports ${proxyPorts} -j DROP
    ip6tables -I INPUT -p tcp -m multiport --dports ${statusPorts} -j DROP
  '';
  networking.firewall.extraStopCommands = ''
    iptables -D INPUT -i lo -j ACCEPT || true
    iptables -D INPUT -p tcp -m multiport --dports ${proxyPorts} ! -s ${proxyIp} -j DROP || true
    iptables -D INPUT -p tcp -m multiport --dports ${statusPorts} ! -s ${statusIp} -j DROP || true
    ip6tables -D INPUT -p tcp -m multiport --dports ${proxyPorts} -j DROP || true
    ip6tables -D INPUT -p tcp -m multiport --dports ${statusPorts} -j DROP || true
  '';

  # enable nat for containers
  # for containers with private network this allows internet access from within
  # XXX: as of 21.05 we can also add networking.nat.enableIPv6 and isolate e.g. users as well
  networking.nat.enable = true;
  networking.nat.internalInterfaces = ["ve-+"];
  networking.nat.externalInterface = "venet0";

  # enabled by default in 21.05, remove after update
  # https://github.com/NixOS/nixpkgs/pull/114240
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

    # unused for now
    squid = {
      autoStart = false;
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

    paro2 = {
      autoStart = true;
      privateNetwork = true;
      hostAddress = ctHostIp;
      localAddress = ctParo2Ip;
      forwardPorts = [ { protocol = "tcp"; hostPort = 9001; containerPort = 80; } ];

      config = { config, pkgs, ... }: {
        imports = [
          ../env.nix
          ../modules/paro2.nix
        ];

        networking.firewall.allowedTCPPorts = [ 80 ];

        services.openssh.enable = true;
        users.extraUsers.root.openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [ ms vk ];
        users.extraUsers.paro2.openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [ ms vk ];

        services.paro2 = {
          enable = true;
          develop = true;
          hostName = "paro2.otevrenamesta.cz";
          # enabled by develop = true
          # database.createLocally = true;
        };
      };
    };

    paro2-beta = {
      autoStart = false;
      privateNetwork = true;
      hostAddress = ctHostIp;
      localAddress = ctParo2BetaIp;
      forwardPorts = [ { protocol = "tcp"; hostPort = 9002; containerPort = 80; } ];

      config = { config, pkgs, ... }: {
        imports = [
          ../env.nix
          ../modules/paro2.nix
        ];

        networking.firewall.allowedTCPPorts = [ 80 ];

        services.openssh.enable = true;
        users.extraUsers.root.openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [ ms vk ];
        users.extraUsers.paro2.openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [ ms vk ];

        services.paro2 = {
          enable = true;
          develop = true;
          hostName = "beta.paro2.otevrenamesta.cz";
        };
      };
    };

    nia = {
      autoStart = true;
      privateNetwork = true;
      hostAddress = ctHostIp;
      localAddress = ctNiaIp;
      forwardPorts = [ { protocol = "tcp"; hostPort = 9003; containerPort = 80; } ];

      config = { config, pkgs, ... }: {
        imports = [
          ../modules/nia-otevrenamesta-cz.nix
        ];

        environment.systemPackages = with pkgs; [
          php fish byobu git unbound
        ];

        networking = {
          firewall.allowedTCPPorts = [ 80 ];

          domain = "otevrenamesta.cz";
          hostName =  "nia";
        };

        users.extraUsers.root.openssh.authorizedKeys.keys =
          with import ../ssh-keys.nix; [ ms ];

        services.mysql = {
          enable = true;
          package = pkgs.mariadb;
          bind = "127.0.0.1";
          ensureDatabases = [ "niatest" ];
          ensureUsers = [
            {
              name = "niatest";
              ensurePermissions = {
                "niatest.*" = "ALL PRIVILEGES";
              };
            }
          ];
        };

        services.mysqlBackup = {
          enable = true;
          databases = [ "niatest" ];
        };

        services.nia-otevrenamesta-cz = {
          enable = true;
          hostName = "${config.networking.hostName}.${config.networking.domain}";
          configFile = "/var/lib/nia-otevrenamesta-cz/config.php";
          privateKeyFile = "/var/lib/nia-otevrenamesta-cz/private.key";
        };

        services.nginx.virtualHosts.${config.services.nia-otevrenamesta-cz.hostName} = {
          serverAliases = [ "test.nia.otevrenamesta.cz" ];
        };
      };
    };

    # for wordpress development
    wpdev = {
      autoStart = true;
      privateNetwork = true;
      hostAddress = ctHostIp;
      localAddress = ctWpdevIp;
      forwardPorts = [ { protocol = "tcp"; hostPort = 9004; containerPort = 80; } ];

      config = { config, pkgs, ... }: {
        imports = [
          ../modules/phpapp.nix
        ];

        networking = {
          firewall.allowedTCPPorts = [ 80 ];
          domain = "paro2.otevrenamesta.cz";
          hostName =  "wp";
        };

        users.extraUsers.root.openssh.authorizedKeys.keys =
          with import ../ssh-keys.nix; [ ms vk ];

        services.openssh.enable = true;

        services.phpapp = {
          enable = true;
          database = {
            createLocally = true;
          };
          hostName = "wp.paro2.otevrenamesta.cz";
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

    virtualHosts = {
      "minio.cityvizor.cz" = {
        serverAliases = [ "minio.otevrenamesta.cz" ];
        locations = {
          "/" = {
            proxyPass = "http://${ctHostIp}:9000";
          };
        };
      };

      "paro2.otevrenamesta.cz" = {
        serverAliases = [ "paro.vxk.cz" ];
        locations = {
          "/" = {
            proxyPass = "http://${ctHostIp}:9001";
          };
        };
      };

      "beta.paro2.otevrenamesta.cz" = {
        locations = {
          "/" = {
            proxyPass = "http://${ctHostIp}:9002";
          };
        };
      };

      "nia.otevrenamesta.cz" = {
        locations = {
          "/" = {
            proxyPass = "http://${ctHostIp}:9003";
          };
        };
      };

      "wp.paro2.otevrenamesta.cz" = {
        locations = {
          "/" = {
            proxyPass = "http://${ctHostIp}:9004";
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
