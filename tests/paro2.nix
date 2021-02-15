import <nixpkgs/nixos/tests/make-test-python.nix> ({pkgs, ...}: rec {
  name = "paro2";

  meta = with pkgs.stdenv.lib.maintainers; {
    maintainers = [ sorki ];
  };

  machine = { lib, ... }: {
    imports = [
      ../modules/paro2.nix
    ];

    services.paro2 = {
      enable = true;
      privateKeyFile = "/run/keys/paro2.private.key";
    };

  };

  testScript = ''
    machine.start()
    machine.wait_for_unit("nginx.service")
    machine.wait_for_unit("phpfpm-paro2.service")
    print(machine.succeed("curl localhost"))
  '';
})

