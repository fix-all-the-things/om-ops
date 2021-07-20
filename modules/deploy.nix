{ config, lib, pkgs, ... }:
let
  home-manager-src = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/209566c752c4428c7692c134731971193f06b37c.tar.gz";
    sha256 = "1canlfkm09ssbgm3hq0kb9d86bdh84jhidxv75g98zq5wgadk7jm";
  };
in
{
  imports = [
    "${home-manager-src}/nixos"
  ];

  environment.systemPackages = with pkgs; [
    morph
    screen
    git
    git-crypt
    gnupg pinentry
  ];

  home-manager.users.root = {
    home = {
      sessionVariables = {
        EDITOR = "vim";
      };
    };
    programs = {
      git = {
        enable = true;
        userEmail = "info@otevrenamesta.cz";
        userName = "Otevrena Mesta";
      };

      ssh = {
        enable = true;
        controlMaster = "auto";
        controlPersist = "1h";
        matchBlocks = {
          "consul" = {
            hostname = "37.205.14.138";
            port = 10222;
            user = "root";
            identityFile = "~/.ssh/mesta_deploy2";
          };
          "glpi" = {
            hostname = "37.205.14.138";
            port = 10422;
            user = "root";
            identityFile = "~/.ssh/mesta_deploy2";
          };
          "mail" = {
            hostname = "192.168.122.100";
            user = "root";
            identityFile = "~/.ssh/mesta_deploy2";
          };
          "matomo" = {
            hostname = "192.168.122.103";
            user = "root";
            identityFile = "~/.ssh/mesta_deploy2";
          };
          "mediawiki" = {
            hostname = "192.168.122.105";
            user = "root";
            identityFile = "~/.ssh/mesta_deploy2";
          };
          "mesta-libvirt" = {
            hostname = "37.205.14.17";
            user = "root";
            identityFile = "~/.ssh/mesta_deploy2";
          };
          "mesta-services" = {
            hostname = "37.205.14.138";
            user = "root";
            identityFile = "~/.ssh/mesta_deploy2";
          };
          "mesta-services-2" = {
            hostname = "37.205.12.242";
            port = 12322;
            user = "root";
            identityFile = "~/.ssh/mesta_deploy2";
          };
          "midpoint" = {
            hostname = "192.168.122.102";
            user = "root";
            identityFile = "~/.ssh/mesta_deploy2";
          };
          "registry-dev" = {
            hostname = "10.23.42.102";
            port = 22;
            user = "root";
            identityFile = "~/.ssh/mesta_deploy2";
          };
          "proxy" = {
            hostname = "192.168.122.104";
            user = "root";
            identityFile = "~/.ssh/mesta_deploy2";
          };
          "status" = {
            hostname = "83.167.228.98";
            user = "root";
            identityFile = "~/.ssh/mesta_deploy2";
          };
          "roundcube" = {
            hostname = "37.205.14.138";
            port = 10322;
            user = "root";
            identityFile = "~/.ssh/mesta_deploy2";
          };
          "shells" = {
            hostname = "37.205.12.242";
            user = "root";
            identityFile = "~/.ssh/mesta_deploy2";
          };
          "sympa" = {
            hostname = "192.168.122.101";
            user = "root";
            identityFile = "~/.ssh/mesta_deploy2";
          };
          "ucto" = {
            hostname = "37.205.14.138";
            port = 10822;
            user = "root";
            identityFile = "~/.ssh/mesta_deploy2";
          };
          "wp" = {
            hostname = "37.205.14.138";
            port = 10522;
            user = "root";
            identityFile = "~/.ssh/mesta_deploy2";
          };
          "matrix" = {
            hostname = "37.205.14.138";
            port = 10922;
            user = "root";
            identityFile = "~/.ssh/mesta_deploy2";
          };
          "pg" = {
            hostname = "37.205.8.221";
            port = 12322;
            user = "root";
            identityFile = "~/.ssh/mesta_deploy2";
          };
          "cv-beta" = {
            hostname = "2a03:3b40:fe:134::1";
            port = 12322;
            user = "root";
            identityFile = "~/.ssh/mesta_deploy2";
          };
          "cv-prod" = {
            hostname = "2a01:430:17:1::ffff:336";
            port = 12322;
            user = "root";
            identityFile = "~/.ssh/mesta_deploy2";
          };
### Probably still WIP machine
#          "smarttabor" = {
#            hostname = "10.23.42.20";
#            user = "root";
#            identityFile = "~/.ssh/mesta_deploy2";
#          };

          # other
          "dsw2" = {
            hostname = "185.8.165.109";
            user = "root";
            identityFile = "~/.ssh/mesta_deploy2";
          };
          "scanner" = {
            hostname = "37.205.8.3";
            user = "root";
            identityFile = "~/.ssh/mesta_deploy2";
          };

          # legacy
          "redmine" = {
            hostname = "2a01:430:17:1::ffff:1381";
            user = "root";
            identityFile = "~/.ssh/mesta_deploy2";
          };
          "az" = {
            hostname = "2a01:430:17:1::ffff:689";
            user = "root";
            identityFile = "~/.ssh/mesta_deploy2";
          };
          "kmd" = {
            hostname = "2a01:430:17:1::ffff:643";
            user = "root";
            identityFile = "~/.ssh/mesta_deploy2";
          };
        };
      };
    };
  };
}
