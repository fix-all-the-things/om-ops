{ config, pkgs, lib, ... }:

let
  vpsadminos = builtins.fetchTarball {
    url = "https://github.com/vpsfreecz/vpsadminos/archive/a7097badbafb29efd11e495df8546067a0d06637.tar.gz";
    sha256 = "1hs65azpziqgwsldj4afk005pwjwvyyq919hzfl0qh5hiniv424r";
  };
in
{
  imports = [
    <nixpkgs/nixos/modules/virtualisation/container-config.nix>
    "${vpsadminos}/os/lib/nixos-container/vpsadminos.nix"
  ];

  systemd.services.systemd-udev-trigger.enable = false;

  # vpsf doesn't use dhcp for interface configuration
  # configure with networking.interfaces.<name?>.useDHCP as needed
  networking.useDHCP = false;

  services.resolved.enable = false;

  services.prometheus.exporters.node = {
    disabledCollectors = [ "powersupplyclass" "hwmon" ];
  };
}

