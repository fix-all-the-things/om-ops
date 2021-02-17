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
      develop = true;
    };

  };

  testScript = ''
    machine.start()
    machine.wait_for_unit("nginx.service")
    machine.wait_for_unit("phpfpm-paro2.service")


    def checkNoDB():
        machine.succeed("curl -s localhost | grep 'Base table or view not found'")


    checkNoDB()

    with subtest("Delete and re-create"):
        machine.succeed("rm -rf /var/www/paro2")
        machine.succeed("curl localhost | grep 'File not found'")
        machine.succeed("systemd-tmpfiles --create")
        checkNoDB()


    def sh(x):
        print(machine.succeed(x))


    sh("su - paro2 -c 'cat docs/schema/schema.sql | mariadb paro2'")

    # sh("su - paro2 -c 'cake bake migration_snapshot Initial'")
    # sh("su - paro2 -c 'cake migrations status'")
    # sh("su - paro2 -c 'rm config/Migrations/schema-dump-default.lock'")
    # sh("su - paro2 -c 'cake migrations status'")
    # sh("su - paro2 -c 'cake migrations rollback --fake'")
    # sh("su - paro2 -c 'cake migrations status'")
    # sh("su - paro2 -c 'rm config/Migrations/schema-dump-default.lock'")
    # sh("su - paro2 -c 'cake migrations migrate -vvv'")
    # sh("su - paro2 -c 'cake migrations status'")

    print(machine.succeed("curl localhost | grep FAQ"))
  '';
})

