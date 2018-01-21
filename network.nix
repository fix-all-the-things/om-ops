{
  network.description = "otevrenamesta-cz infrastructure";

  ckan =
    { config, lib, pkgs, ...}:
    {
      imports = [
        ./env.nix
        ./ckan.nix
      ];
    };

  ckan-pub =
    { config, lib, pkgs, ...}:
    {
      imports = [
        ./env.nix
        ./ckan-pub.nix
      ];
    };

  redmine =
    { config, lib, pkgs, ...}:
    {
      imports = [
        ./env.nix
        #./redmine.nix
      ];
    };
  hydra =
    { config, lib, pkgs, ... }:
    {
      imports = [
        ./env.nix
        ./hydra-master.nix
      ];
    };
  hydra_slave =
    { config, lib, pkgs, ... }:
    {
      imports = [
        ./env.nix
        ./hydra-slave.nix
      ];
    };
}
