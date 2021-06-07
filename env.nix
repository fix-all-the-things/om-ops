{ config, pkgs, lib, ... }:
let
  vimCustom = (pkgs.vimUtils.makeCustomizable pkgs.vim).customize {
    name = "vim";
    vimrcConfig = {
      customRC = ''
        runtime vimrc

        set mouse=
        if has("autocmd")
          au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
        endif
      '';
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [ vim-nix ];
      };
    };
  };

  scripts = pkgs.callPackage ./packages/scripts.nix { };
in
{
  time.timeZone = "Europe/Amsterdam";
  networking.nameservers = lib.mkDefault [
    "1.1.1.1"
    "208.67.222.222"
    "208.67.220.220"
    "2606:4700:4700::1111"
  ];

  services.openssh.enable = true;
  services.nginx.appendHttpConfig = ''
    error_log stderr;
    access_log syslog:server=unix:/dev/log combined;
  '';

  nix.useSandbox = true;
  nix.buildCores = 0;

  boot.loader.grub.configurationLimit = lib.mkDefault 10;

  environment.systemPackages = with pkgs; [
    htop
    lynx
    screen
    tmux
    vimCustom
    wget
    git
    nmap
    tcpdump
    wireguard
    scripts.wgKeygen
  ];

  security.acme = {
    email = "alert@otevrenamesta.cz";
    acceptTerms = true;
  };

  users.extraUsers.root.openssh.authorizedKeys.keys =
    with import ./ssh-keys.nix; [ deploy ln mm srk ms vh ];

  system.stateVersion = lib.mkDefault "18.09";
}
