{ config, pkgs, ... }:

let
  riotConfig = {
    default_server_config = {
      "m.homeserver" = {
        base_url = "https://matrix.vesp.cz";
        server_name = "vesp.cz";
      };
    };
    defaultCountryCode = "CZ";
    # don't allow choosing custom homeserver
    disable_custom_urls = true;
    branding = {
      authHeaderLogoUrl = "/vesp-logo.svg";
      authFooterLinks = [
        { text = "Provozují Otevřená města, z.s."; url = "https://www.otevrenamesta.cz"; }
        { text = "Server poskytuje vpsFree.cz, z.s."; url = "https://www.vpsfree.cz"; }
      ];
    };
    embeddedPages.welcomeUrl = "/vesp-welcome.html";
  };
  riotPkg = pkgs.element-web.override { conf = riotConfig; };
  slackBridgeRegistration = ../secrets/matrix-appservice-slack/slack-registration.yaml;
in
{
  imports = [
    ../modules/matrix-appservice-slack.nix
    ../modules/mautrix-facebook.nix
  ];

  nixpkgs.overlays = let
    # https://github.com/matrix-org/synapse/issues/6211
    # https://twistedmatrix.com/trac/ticket/9740
    # https://github.com/twisted/twisted/pull/1225
    # can be removed after upgrading to twisted > 20.3.y
    twistedSmtpTLSv10Patch = pkgs.fetchpatch {
      name = "twisted-smtp-tlsv10.patch";
      url = "https://github.com/twisted/twisted/pull/1225.diff";
      sha256 = "14bk57b90n2kzd8mv9xngqzsr0dr7a05nj2mpkp6dmyhjsd3skih";
    };
    customPython3 = pkgs.python3.override {
      packageOverrides = python-self: python-super: {
        twisted = python-super.twisted.overrideAttrs (attrs: {
          pname = "patched-Twisted";
          # package overrides patchPhase, adding patch to `patches` does nothing
          patchPhase = attrs.patchPhase + ''
            patch -p1 < ${twistedSmtpTLSv10Patch}
          '';
        });
      };
    };
  in [
    (self: super: rec {
      matrix-synapse = super.matrix-synapse.override { python3 = customPython3; };
    })
    (import ../overlays/mautrix-facebook.nix)
    (import ../overlays/matrix-appservice-slack.nix)
  ];

  environment.systemPackages = with pkgs; [
    matrix-synapse
  ];

  networking = {
     hostName = "matrix";
     domain = "vesp.cz";
  };

  users.extraUsers.root.openssh.authorizedKeys.keys =
    with import ../ssh-keys.nix; [ rh ];

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "slack_bridge" ];
    ensureUsers = [{
      name = "slackbridge";
      ensurePermissions = {
        "DATABASE slack_bridge" = "ALL PRIVILEGES";
      };
    }];
    initialScript = pkgs.writeText "matrix-db-init.sql" ''
      CREATE ROLE "matrix-synapse" WITH LOGIN PASSWORD 'synapse';
      CREATE DATABASE "matrix-synapse" WITH OWNER "matrix-synapse"
        TEMPLATE template0
        LC_COLLATE = "C"
        LC_CTYPE = "C";
    '';
  };

  services.postgresqlBackup = {
    enable = true;
  };

  services.matrix-synapse = {
    enable = true;
    no_tls = true;
    server_name = "vesp.cz";
    registration_shared_secret = (import ../secrets/matrix.nix).registration-secret;
    public_baseurl = "https://matrix.vesp.cz/";
    database_type = "psycopg2";
    database_args = {
      database = "matrix-synapse";
    };
    listeners = [
      { # federation
        bind_address = "";
        port = 8448;
        resources = [
          { compress = true; names = [ "client" "webclient" "metrics" ]; }
          { compress = false; names = [ "federation" ]; }
        ];
        tls = false;
        type = "http";
        x_forwarded = true;
      }
    ];
    app_service_config_files = [
      slackBridgeRegistration

      # NOTE needs to be copied manually after mautrix-facebook is first started
      "/var/lib/matrix-synapse/facebook-registration.yml"
    ];
    enable_metrics = true;
    report_stats = true;
    extraConfig = ''
      max_upload_size: "100M"
      # see the comment above synapsePkg definition
      web_client_location: "https://riot.vesp.cz/"

      email:
        smtp_host: mx.otevrenamesta.cz
        smtp_port: 25
        # Disabled due to #22
        # smtp_port: 587
        # smtp_user: matrix
        # smtp_password: ${(import ../secrets/matrix.nix).smtpPassword};
        require_transport_security: true
        notif_from: "Matrix <matrix@otevrenamesta.cz>"
        template_dir: ${../media/synapse-email-templates}
        # Enable mail notifications
        enable_notifs: true
    '';

    enable_registration = true;
#    enable_registration_captcha = true;
#    recaptcha_public_key = ./matrix/recaptcha.pub;
#    recaptcha_private_key = ./matrix/recaptcha;
  };

  services.nginx = {
    enable = true;
    statusPage = true;
    virtualHosts."riot.vesp.cz" = {
      root = riotPkg;
      locations."=/vesp-logo.svg".alias = ../media/vesp135px-matrix.svg;
      # keep this in sync with ${riotPkg}/welcome.html
      locations."=/vesp-welcome.html".alias = ../media/matrix-welcome.html;
    };
  };

  services.matrix-appservice-slack = {
    enable = true;
    registrationFile = slackBridgeRegistration;
    configFile = ../secrets/matrix-appservice-slack/slack-config.yaml;
  };

  services.mautrix-facebook = {
    enable = true;
    settings = {
      homeserver.address = "http://localhost:8448";
      homeserver.domain = "vesp.cz";
      bridge.permissions = {
        "vesp.cz" = "user";
        "@b42:matrix.org" = "admin";
        "@nesnera_om:vesp.cz" = "admin";
      };
    };
  };

  services.prometheus.exporters.postgres = {
    enable = true;
    openFirewall = true;
    runAsLocalSuperUser = true;
  };
  services.prometheus.exporters.nginx = {
    enable = true;
    openFirewall = true;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      80    # nginx+riot
      8448  # Matrix federation and client connections
      9898  # Slack bridge
    ];
  };
}
