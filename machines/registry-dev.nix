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
     hostName =  "registry-dev";
  };

  om.wireguard = {
    enable = true;
    # route ipv4 traffic thru wg
    allowedIPs = [ "0.0.0.0/0" "fc00::/64" ];
  };

  users.extraUsers.root.openssh.authorizedKeys.keys =
    with import ../ssh-keys.nix; [ ms ];
}
