{ config, pkgs, lib, ... }:
let
  data = import ../data;
  recommendedProxy = ''
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header X-Forwarded-Host $host;
    proxy_set_header X-Forwarded-Server $host;
  '';

  addWellKnownLocations = vhosts:
    let contents = [
          "Contact: mailto:security@${data.domains.om}"
          "Preferred-Languages: cs, en"
        ];
    in
    lib.mapAttrs
      (name: vhost:
        (lib.recursiveUpdate vhost {
          locations = {

            "/security.txt" = {
              return = ''
                200 "${lib.concatStringsSep "\\n" contents}"
              '';
            };
            "/.well-known/security.txt" = {
              return = ''
                200 "${lib.concatStringsSep "\\n" contents}"
              '';
            };
          };
        })
      )
      vhosts;
in
{

  imports = [
    ../modules/wireguard.nix
  ];

  om.wireguard.enable = true;

  networking = {
    firewall.allowedTCPPorts = [ 80 443 ];
  };

  services.prometheus.exporters.nginx = {
    enable = true;
    openFirewall = true;
  };

  services.nginx = {
    enable = true;
    statusPage = true;
    clientMaxBodySize = "2G";
    #recommendedProxySettings = true;
    recommendedTlsSettings = true;
    recommendedGzipSettings = true;

    virtualHosts = addWellKnownLocations {

      "cityvizor.cz" = {
        serverAliases = [ "www.cityvizor.cz" "demo.cityvizor.cz" ];
        forceSSL = true;
        enableACME = true;

        locations = {
          "/" = {
            proxyPass = "http://[${data.hosts.cv-prod.addr.pub.ipv6}]:80";
            extraConfig = recommendedProxy;
          };
        };
      };

      "beta.cityvizor.cz" = {
        serverAliases = [ "demo.beta.cityvizor.cz" ];
        forceSSL = true;
        enableACME = true;
        locations = {
          "/" = {
            proxyPass = "http://[${data.hosts.cv-beta.addr.pub.ipv6}]:80";
            extraConfig = recommendedProxy;
          };
        };
      };

      "minio.cityvizor.cz" = {
        serverAliases = [ "minio.otevrenamesta.cz" ];
        forceSSL = true;
        enableACME = true;
        locations = {
          "/" = {
            proxyPass = "http://${data.hosts.mesta-services-2.addr.pub.ipv4}:80";
            extraConfig = recommendedProxy;
          };
        };
      };

      "dsw2.otevrenamesta.cz" = {
        serverAliases = [
          "novemestonm.dsw2.otevrenamesta.cz"
          "medlanky.dsw2.otevrenamesta.cz"
          "dotace.praha3.cz"
          "dotace.praha12.cz"
          "dotace.praha8.cz"
          "dotace.praha14.cz"
          "dotace.praha4.cz"
          "loket.dsw2.otevrenamesta.cz"
          "praha4.dsw2.otevrenamesta.cz"
          "praha6.dsw2.otevrenamesta.cz"
          "praha11.dsw2.otevrenamesta.cz"
          "tacr.dsw2.otevrenamesta.cz"
          "usti-nad-labem.dsw2.otevrenamesta.cz"
        ];
        forceSSL = true;
        enableACME = true;

        locations = {
          "/" = {
            proxyPass = "http://185.8.165.109";
            extraConfig = ''
              proxy_set_header Host $host;
              proxy_set_header X-Real-IP $remote_addr;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
              proxy_set_header X-Forwarded-Proto $scheme;
            '';
          };
        };
      };

      "forum.vesp.cz" = {
        forceSSL = true;
        enableACME = true;

        locations = {
          "/" = {
            proxyPass = "http://[2a03:3b40:fe:32::]";
            extraConfig = ''
              proxy_set_header Host $host;
            '';
          };
        };
      };

      "forum.otevrenamesta.cz" = {
        serverAliases = [ "vesp.cz" ];
        forceSSL = true;
        enableACME = true;

        extraConfig = ''
          location = /registrace {
            return 301 https://ec.europa.eu/eusurvey/runner/VeSP2020;
          }
          location / {
            return 301 https://forum.vesp.cz$request_uri;
          }
          location /_matrix {
            proxy_pass http://37.205.14.138:10984;
            proxy_set_header Host $host;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          }

        '';
      };

      # 200203 docasne, bude nahrazeno konferencnim webem
      "www.vesp.cz" = {
        forceSSL = true;
        enableACME = true;

        extraConfig = ''
          location /2020/ {
            alias /var/www/;
            autoindex off;
          }
          location /2020 {
            return 301 https://www.vesp.cz/2020/;
          }
          location = /faktomluva {
            return 301 https://ec.europa.eu/eusurvey/runner/Faktomluva;
          }
          location = /registrace {
            return 301 https://ec.europa.eu/eusurvey/runner/VeSP2020;
          }
          location / {
            return 301 https://www.otevrenamesta.cz/2020/VeSP2020.html;
          }
        '';
      };

      "glpi.otevrenamesta.cz" = {
        forceSSL = true;
        enableACME = true;

        locations = {
          "/" = {
            proxyPass = "http://37.205.14.138:10480";
            extraConfig = ''
              proxy_set_header Host $host;
            '';
          };
        };
      };

      "iot.otevrenamesta.cz" = {
        forceSSL = true;
        enableACME = true;

        locations = {
          "/" = {
            proxyPass = "http://37.205.14.2";
          };
        };
        locations."/ws" = {
          proxyPass = "http://37.205.14.2";
          extraConfig = ''
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "upgrade";
            proxy_set_header Host $host;
          '';
        };
      };

      "lists.otevrenamesta.cz" = {
        forceSSL = true;
        enableACME = true;

        locations = {
          "/" = {
            proxyPass = "http://192.168.122.101";
            extraConfig = ''
              proxy_set_header Host $host;
              proxy_set_header X-Forwarded-Proto $scheme;
              proxy_set_header Front-End-Https On;
            '';

          };
        };
      };

      "matrix.vesp.cz" = {
        forceSSL = true;
        enableACME = true;

        locations = {
          "/" = {
            proxyPass = "http://37.205.14.138:10984";
            extraConfig = ''
              proxy_set_header Host $host;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            '';
          };
          "/slack" = {
            proxyPass = "http://37.205.14.138:10985";
            extraConfig = ''
              proxy_set_header Host $host;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            '';
          };

        };
      };

      # VH: down (2021/06)
      "midpoint.otevrenamesta.cz" = {
        forceSSL = true;
        enableACME = true;

        locations = {
          "/" = {
            proxyPass = "http://192.168.122.102:8080";
          };
        };
      };

      # needed for mail server to obtain LE cert
      "mx.otevrenamesta.cz" = {
        enableACME = true;
        addSSL = true;
        acmeFallbackHost = "192.168.122.100";
      };

      "navstevnost.otevrenamesta.cz" = {
        enableACME = true;
        forceSSL = true;

        locations = {
          "/" = {
            proxyPass = "http://192.168.122.103";
            extraConfig = ''
              proxy_set_header Host $host;
              proxy_set_header X-Forwarded-Proto $scheme;
              proxy_set_header X-Real-IP $remote_addr;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
              proxy_set_header X-Forwarded-Host $host;
              proxy_set_header X-Forwarded-Server $host;
            '';

          };
        };
      };

      "nia.otevrenamesta.cz" = {
        forceSSL = true;
        enableACME = true;

        locations = {
          "/" = {
            proxyPass = "http://${data.hosts.mesta-services-2.addr.pub.ipv4}:80";
            extraConfig = ''
              proxy_set_header Host $host;
            '';
          };
        };
      };

      "proxy.otevrenamesta.cz" = {
        forceSSL = true;
        enableACME = true;

        locations = {
          "/" = {
            root = "/var/www";
          };
        };
      };

      "riot.vesp.cz" = {
        serverAliases = [ "element.vesp.cz" ];
        forceSSL = true;
        enableACME = true;

        locations = {
          "/" = {
            proxyPass = "http://37.205.14.138:10980";
            extraConfig = ''
              proxy_set_header Host $host;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            '';
          };
        };
      };

      "soubory.otevrenamesta.cz" = {
        forceSSL = true;
        enableACME = true;
        serverAliases = [ "az.otevrenamesta.cz" ];

        extraConfig = ''
          location ^~ /loleaflet {
                   proxy_pass http://172.16.9.44:9980;
                   #proxyPass = "http://[2a01:430:17:1::ffff:689]";
                   proxy_set_header Host $host;
               }
          location ^~ /hosting/discovery {
                   proxy_pass http://172.16.9.44:9980;
                   proxy_set_header Host $host;
               }
          # main websocket
          location ~ ^/lool/(.*)/ws$ {
              proxy_pass http://172.16.9.44:9980;
              proxy_set_header Upgrade $http_upgrade;
              proxy_set_header Connection "Upgrade";
              proxy_set_header Host $host;
              proxy_read_timeout 36000s;
          }

          location ~ ^/lool {
                   proxy_pass http://172.16.9.44:9980;
                   proxy_set_header Upgrade $http_upgrade;
                   proxy_set_header Connection "upgrade";
                   proxy_set_header Host $host;
               }
          location / {
              proxy_pass http://172.16.9.44;
              #proxy_pass http://[2a01:430:17:1::ffff:689]
              proxy_pass_header Authorization;
              proxy_set_header Host $host;
              proxy_set_header X-Real-IP  $remote_addr;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
              proxy_http_version 1.1;
              proxy_set_header Connection "";
              proxy_buffering off;
              proxy_request_buffering off;
              client_max_body_size 0;
              proxy_read_timeout  36000s;
              proxy_redirect off;
              proxy_ssl_session_reuse off;
               }
          '';
      };

      # VH: down (2021/06)
      "test.nia.otevrenamesta.cz" = {
        forceSSL = true;
        enableACME = true;

        locations = {
          "/" = {
            proxyPass = "http://37.205.14.138:10780";
            extraConfig = ''
              proxy_set_header Host $host;
            '';
          };
        };
      };

      "ucto.otevrenamesta.cz" = {
        forceSSL = true;
        enableACME = true;

        locations = {
          "/" = {
            proxyPass = "http://37.205.14.138:10880";
            extraConfig = ''
              proxy_set_header Host $host;
              proxy_set_header X-Forwarded-Proto $scheme;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
              proxy_set_header X-Real-IP $remote_addr;
            '';
          };
        };
      };

      "virtuoso.otevrenamesta.cz" = {
        forceSSL = true;
        enableACME = true;

        locations = {
          "/" = {
            proxyPass = "http://77.93.223.72:8890";
          };
        };
      };

      # VH: down (2021/06)
      "webmail.otevrenamesta.cz" = {
        forceSSL = true;
        enableACME = true;

        locations = {
          "/" = {
            proxyPass = "http://37.205.14.138:10380";
            extraConfig = ''
              proxy_set_header Host $host;
            '';
          };
        };
      };

      "wiki.otevrenamesta.cz" = {
        forceSSL = true;
        enableACME = true;
        serverAliases = [ "wiki.vesp.cz" ];

        locations = {
          "/" = {
            proxyPass = "http://192.168.122.105";
            extraConfig = ''
              proxy_set_header Host $host;
              proxy_set_header X-Real-IP $remote_addr;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
              proxy_set_header X-Forwarded-Proto $scheme;
              proxy_set_header X-Forwarded-Host $host;
              proxy_set_header X-Forwarded-Server $host;
            '';
          };
        };
      };

      # VH: down (2021/06)
      "wp.otevrenamesta.cz" = {
        forceSSL = true;
        enableACME = true;
        serverAliases = [ "p7.wp.otevrenamesta.cz" "ck.wp.otevrenamesta.cz" "paro.wp.otevrenamesta.cz" "www2.vesp.cz" ];

        locations = {
          "/" = {
            proxyPass = "http://37.205.14.138:10580";
            extraConfig = ''
              proxy_set_header        Host $host;
              proxy_set_header        X-Real-IP $remote_addr;
              proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
              proxy_set_header        X-Forwarded-Proto $scheme;
              proxy_set_header        X-Forwarded-Host $host;
              proxy_set_header        X-Forwarded-Server $host;
            '';
          };
        };
      };

      "www.otevrenamesta.cz" = {
        default = true;
        forceSSL = true;
        enableACME = true;
        serverAliases = [ "otevrenamesta.cz" ];

        locations = {
          "/" = {
            proxyPass = "https://otevrenamesta.gitlab.io";
            extraConfig = ''
              proxy_set_header Host $host;
              proxy_set_header X-Forwarded-Proto $scheme;
            '';
          };

          "/_matrix" = {
            proxyPass = "http://37.205.14.138:10984";
            extraConfig = ''
              proxy_set_header Host $host;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            '';
          };
        };
      };

      "users.otevrenamesta.cz" = {
        forceSSL = true;
        enableACME = true;
        locations = {
          "/" = {
            proxyPass = "http://${data.hosts.mesta-services-2.addr.pub.ipv4}:80";
            extraConfig = recommendedProxy;
          };
        };
      };

      "paro2.otevrenamesta.cz" = {
        serverAliases = [ "paro.vxk.cz" ];
        forceSSL = true;
        enableACME = true;
        locations = {
          "/" = {
            proxyPass = "http://${data.hosts.mesta-services-2.addr.pub.ipv4}:80";
            extraConfig = recommendedProxy;
          };
        };
      };

      # VH: down (2021/06)
      "beta.paro2.otevrenamesta.cz" = {
        forceSSL = true;
        enableACME = true;
        locations = {
          "/" = {
            proxyPass = "http://${data.hosts.mesta-services-2.addr.pub.ipv4}:80";
            extraConfig = recommendedProxy;
          };
        };
      };

      "wp.paro2.otevrenamesta.cz" = {
        forceSSL = true;
        enableACME = true;
        locations = {
          "/" = {
            proxyPass = "http://${data.hosts.mesta-services-2.addr.pub.ipv4}:80";
            extraConfig = recommendedProxy;
          };
        };
      };

      # smarttabor
      "new.otevrenamesta.cz" = {
        forceSSL = true;
        enableACME = true;
        # serverAliases = [
        #   "new.otevrenamesta.cz"
        #   "www.otevrenamesta.cz"
        # ];
        locations = {
          "/" = {
            proxyPass = "http://${data.hosts.smarttabor.addr.priv.ipv4}:80";
            extraConfig = recommendedProxy;
          };
        };
      };

      "web.otevrenamesta.cz" = {
        forceSSL = true;
        enableACME = true;
        serverAliases = [
          "example.web.otevrenamesta.cz"
          "web.otevrenamesta.cz"
          "stredni.web.otevrenamesta.cz"
          "mala.web.otevrenamesta.cz"
        ];
        locations = {
          "/" = {
            proxyPass = "http://${data.hosts.smarttabor.addr.priv.ipv4}:80";
            extraConfig = recommendedProxy;
          };
        };
      };

      "taborskasetkani.eu" = {
        forceSSL = true;
        enableACME = true;
        serverAliases = [
          "www.taborskasetkani.eu"
        ];
        locations = {
          "/" = {
            proxyPass = "http://${data.hosts.smarttabor.addr.priv.ipv4}:80";
            extraConfig = recommendedProxy;
          };
        };
      };

    };
  };
}
