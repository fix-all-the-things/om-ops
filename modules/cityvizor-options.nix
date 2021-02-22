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

    s3 = {
      host = mkOption {
        type = types.str;
        default = "minio";
      };
      cdnHost = mkOption {
        type = types.str;
        default = "https://minio";
      };
      port = mkOption {
        type = types.port;
        default = 80;
      };
      privateBucket = mkOption {
        type = types.str;
        default = "cityvizor";
      };
      publicBucket = mkOption {
        type = types.str;
        default = "cityvizor-public";
      };
      accessKey = mkOption {
        type = types.str;
      };
      secretKey = mkOption {
        type = types.str;
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

      tag = mkOption {
        type = types.str;
        default = "master";
        example = "5-1-0";
        description = ''
          Container image tag to use.
        '';
      };
    };
  };
}
