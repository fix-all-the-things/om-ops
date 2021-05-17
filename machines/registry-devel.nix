{ config, lib, pkgs, ... }:

{
  imports = [
    ../modules/wireguard.nix
  ];

  environment.systemPackages = with pkgs; [
    php fish byobu git unbound
  ];

  networking = {
     domain = "otevrenamesta.cz";
     hostName =  "registry-devel";
  };

  om.wireguard.enable = true;

  users.extraUsers.root.openssh.authorizedKeys.keys =
    with import ../ssh-keys.nix; [ ms ];
}
