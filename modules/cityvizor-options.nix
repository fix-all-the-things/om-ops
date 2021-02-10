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
        default = "cvdb";
        description = "Database name.";
      };

      user = mkOption {
        type = types.nullOr types.str;
        default = "cvuser";
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
    };

    };
  };
}
