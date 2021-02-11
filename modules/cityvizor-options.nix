{ pkgs, lib, ... }:

with lib;

{
  services.cityvizor = {
    enable = mkEnableOption "CityVizor";

    hostName = mkOption {
      type = types.str;
      default = "cityvizor";
      description = ''
        Host name where this application is going to be served.

        Creates nginx vhost which you can further modify under
        <option>services.nginx.virtualHosts."${hostName}"</option>
      '';
    };

    database = {
      demoData.enable = mkEnableOption "loading of demo database";

      enableSSL = mkEnableOption "SSL for database connection";

      host = mkOption {
        type = types.str;
        #default = "localhost";
        description = ''
          Database host address.
        '';
      };

      port = mkOption {
        type = types.port;
        default = 5432;
        description = "Database port.";
      };

      name = mkOption {
        type = types.str;
        default = "cvprod";
        description = "Database name.";
      };

      user = mkOption {
        type = types.nullOr types.str;
        default = "cvproduser";
        description = "Database user.";
      };

      createLocally = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to create a local database automatically.";
      };

      postgresql-package = mkOption {
        type = types.pkg;
        default = pkgs.postgresql_13;
      };
    };

    proxy = {
      enable = mkEnableOption "CityVizor nginx proxy";
    };

    server = {
      enable = mkEnableOption "CityVizor server";
      port = mkOption {
        type = types.port;
        default = 3000;
      };
      redundantInstances = mkOption {
        type = types.int;
        default = 2;
      };
    };

    containers = {
      backend = mkOption {
        type = types.enum [ "docker" "podman" ];
        default = "podman";
        description = ''
          OCI container runtime to use
        '';
      };

      extraOptions = mkOption {
        type = types.listOf types.str;
        default = [];
        description = ''
          Extra options for container backend run command.
        '';
        example = literalExample ''
          [ "--cgroup-manager=cgroupfs" ]
        '';
      };

      pinned = mkOption {
        type = types.bool;
        default = true;
        description = ''
          Use pinned container images. If set to false
          backend will pull these from registry.
        '';
      };
    };
  };
}