{ config, lib, pkgs, modulesPath, ... }:

{
  # same as imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
  hardware.enableRedistributableFirmware = true;

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "ehci_pci" "nvme" "smartpqi" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/3c782768-62e5-41e0-8222-bfda5182a7b5";
      fsType = "ext4";
    };

  fileSystems."/data" =
    { device = "/dev/disk/by-uuid/cb28904d-1641-4967-8ab0-d2d879d4553c";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/1AF7-6E34";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/ccaa500e-88e9-4b61-a41b-727c327f39c0"; }
    ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
