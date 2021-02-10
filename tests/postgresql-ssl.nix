let
  fqdn = "pg.example.org";
in
import <nixpkgs/nixos/tests/make-test-python.nix> ({pkgs, ...}: rec {
  name = "postgresql-ssl";
  meta = with pkgs.stdenv.lib.maintainers; {
    maintainers = [ sorki ];
  };

  machine = { lib, ... }: {
    imports = [
      ../modules/postgresql-ssl.nix
    ];

    services.postgresql = {
      enable = true;
      enableSSL = true;
      enableACME = true;
      inherit fqdn;
    };
    security.acme = {
      email = "email@example.org";
      acceptTerms = true;
    };

    # fake renewal
    systemd.services."acme-${fqdn}".serviceConfig = {
      ExecStart = lib.mkForce "${pkgs.coreutils}/bin/touch /var/lib/acme/${fqdn}/renewed";
    };
  };

  testScript = ''
    machine.start()
    machine.wait_for_unit("postgresql.service")
    machine.succeed("systemctl start acme-${fqdn}.service")
    machine.succeed("sleep 3")
    machine.succeed("journalctl -u postgresql | grep -q reloading")
    machine.wait_for_unit("nginx.service")
  '';
})

