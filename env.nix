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
  nix.useSandbox = true;
  nix.buildCores = 0;
  systemd.tmpfiles.rules = [ "d /tmp 1777 root root 7d" ];

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
  ];

  security.acme = {
    email = "alert@otevrenamesta.cz";
    acceptTerms = true;
  };

  users.extraUsers.root.openssh.authorizedKeys.keys =
    with import ./ssh-keys.nix; [ deploy ln mm srk ];

  system.stateVersion = "18.09";
}
