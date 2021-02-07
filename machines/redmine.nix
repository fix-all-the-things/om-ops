{ config, pkgs, lib, ... }:

{

  environment.systemPackages = with pkgs; [
  ];

  networking = {
     firewall.allowedTCPPorts = [ 3000 ];

     domain = "otevrenamesta.cz";
     hostName =  "redmine";

  };

  services.redmine = {
    enable = true;
    database.type = "postgresql";

    settings = {
      default = {
        email_delivery = {
          delivery_method = ":smtp";
          smtp_settings = {
            enable_starttls_auto = true;
            address = "mail.openalt.org";
            port = "587";
            domain = "openalt.org";
            authentication = ":cram_md5";
            user_name = "projekty@otevrenamesta.cz";
            password = (import ../secrets/redmine.nix).smtp_password;
            openssl_verify_mode = 0;
          };
        };
        etherpad = {
          host = "https://pad.openalt.org";
          showLineNumbers = true;
        };
      };
    };

    extraEnv = "";
    plugins = let
      gitlabPirati = pkgs.fetchgit {
        url = "https://gitlab.pirati.cz/to/docker-redmine.git";
        rev = "649e5cb8740e6b9bcc15c7747c99923cf7fa8f7f";
        sha256 = "04zcqk3m5p1x1v8nm2654vvp08cdb2wzxqhwfgy4nrvpz0jdj7n1";
      };
    in
    {
      #NoMethodError: undefined method `to_prepare' for ActionDispatch::Reloader:Class
      #easy_wbs = "${gitlabPirati}/plugins/easy_wbs";
      #easy_mindmup = "${gitlabPirati}/plugins/easy_mindmup";

      #NoMethodError: undefined method `alias_method_chain' for User (call 'User.connection' to establish a connection):Class
      #event_notifications = pkgs.fetchFromGitHub {
      #owner = "jrupesh";
      #repo = "event_notifications";
      #rev = "be2bd8c2004743a4c366b7595353621a12e143d8";
      #sha256 = "1jfh71pw9hiihqrzwizs4cgfq9ly6hym8d49hyfyxnc4m86jnynk";
      #};

      quick_edit = pkgs.fetchFromGitHub {
        owner = "windviki";
        repo = "redmine_quick_edit";
        rev = "e025a6b9cc8b2e55acab6da0d71959d319a2723c";
        sha256 = "0jz6ngv92lfwmzx9dm81jaigjyajszd3p7mnydx7jmggxsswsghv";
      };

      #NoMethodError: undefined method `requires_redmine_crm' for main:Object
      #redmine_agile = pkgs.fetchFromGitHub {
      # owner = "imasdetres";
      # repo = "redmine_agile";
      # rev = "597810f7311b0b23661cb026b1f864c6d4525de1";
      # sha256 = "17rjqpqwhk2s8wz417iw1y35kd3b5mq63kd2csnbjd9j71sdiw0v";
      #};

      # `method_missing': undefined local variable or method `rcrm_acts_as_list' for #<Class:0x0000000006611b50> (NameError)
      #redmine_checklists = "${gitlabPirati}/plugins/redmine_checklists";

      # NameError: uninitialized constant Rich
      #redmine_ckeditor = pkgs.fetchFromGitHub {
      #  owner = "a-ono";
      #  repo = "redmine_ckeditor";
      #  rev = "1.2.3";
      #  sha256 = "1r7z1b1mjva4rc66x3792q4r913aqq87ny0vz6zpnvjr0kabckgr";
      #};
      redmine_issue_completion = pkgs.fetchFromGitHub {
        owner = "tbird1965";
        repo = "redmine_issue_completion";
        rev = "dfd99c49ff8f12e7b051170d54ac34ede17e6b22";
        sha256 = "047x65ix80647pvyfyy2qsb3n17x527y860lflv1m156b6nwhm32";
      };

      redmine_issues_tree = pkgs.fetchFromGitHub {
        owner = "Loriowar";
        repo = "redmine_issues_tree";
        rev = "223014cef531cf02e51244a75c6c6e3fcf395025";
        sha256 = "0d119v7kd2y5fjwp9k3im8m36l85fyhgkhrd3d9brnkkg0gc4nv2";
      };

      redmine_my_page = pkgs.fetchFromGitHub {
        owner = "jrupesh";
        repo = "redmine_my_page";
        rev = "5690fbe73db1eae11d0f991982048b64a50e3f25";
        sha256 = "1nrd01bzl1y9mchlg13n0rgfbvsx7hprgf5c46y18lfv8z0kwyja";
      };

      redmine_silencer = pkgs.fetchFromGitHub {
        owner = "networkteam";
        repo = "redmine_silencer";
        rev = "ec195cc314caab04e84af0628fd61f7181a382f4";
        sha256 = "1r8x6s74fd9qj3g63lpbv1yfn4kxdp6mbzqpnvb4k0d0mccjkv6m";
      };
    };
    # 5/12, not great
  };
}
