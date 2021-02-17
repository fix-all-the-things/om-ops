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
      database.createLocally = true;
    };

  };

  testScript = { nodes, ...}: ''
    machine.start()
    machine.wait_for_unit("nginx.service")
    machine.wait_for_unit("phpfpm-paro2.service")

    machine.succeed(
        "cat ${nodes.machine.config.services.paro2.package}/docs/schema/schema.sql | mariadb paro2"
    )
    print(machine.succeed("curl localhost"))
    print(machine.succeed("curl localhost | grep FAQ"))
  '';
})

