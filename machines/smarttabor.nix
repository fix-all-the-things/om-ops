{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      ../env.nix
      ../modules/wireguard.nix
      ./smarttabor-hardware.nix
    ];

  om.wireguard.enable = true;

  networking.useDHCP = false;
  networking.hostName = "smarttabor";
  networking.interfaces.eno1.useDHCP = true;
  networking.interfaces.eno2.useDHCP = true;

  users.users.vencax = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [ vk ];
  };

  system.stateVersion = "20.09";
}
