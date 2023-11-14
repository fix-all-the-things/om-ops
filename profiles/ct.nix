{ config, pkgs, lib, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/virtualisation/container-config.nix>
  ];

  systemd.services.systemd-udev-trigger.enable = false;

  services.resolved.enable = false;

  services.prometheus.exporters.node = {
    disabledCollectors = [ "powersupplyclass" "hwmon" ];
  };
}

