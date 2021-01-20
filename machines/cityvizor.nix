{ config, pkgs, lib, ... }:

let
  # nix branch, pin at some point
  cvSrc = "https://github.com/otevrenamesta/cityvizor/archive/nix.tar.gz";
  cvOverlay =
    import "${builtins.fetchTarball cvSrc}/overlay.nix";
in
{
  imports = [
    ../modules/cityvizor.nix
  ];

  nixpkgs.overlays = let
  in [
    cvOverlay
  ];

  environment.systemPackages = with pkgs; [
    vim
  ];

  networking = {
     hostName = "cityvizor";
     domain = "example.org";
  };

  services.cityvizor.enable = true;

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_13;
    ensureDatabases = [ "cv" ];
    ensureUsers = [{
      name = "cvuser";
      ensurePermissions = {
        "DATABASE cv" = "ALL PRIVILEGES";
      };
    }];
    authentication = ''
      host all cvuser 127.0.0.1/32 trust
    '';
  };

  services.postgresqlBackup = {
    enable = true;
  };

  services.prometheus.exporters.postgres = {
    enable = true;
    openFirewall = true;
    runAsLocalSuperUser = true;
  };

  services.nginx.statusPage = true;
  services.prometheus.exporters.nginx = {
    enable = true;
    openFirewall = true;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      80    # nginx
    ];
  };
}
