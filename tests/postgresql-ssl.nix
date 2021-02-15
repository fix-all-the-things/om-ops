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

    environment.systemPackages = with pkgs; [
      openssl
    ];
  };

  testScript = ''
    machine.start()
    with subtest("starts with self-signed"):
        machine.wait_for_unit("postgresql.service")

    with subtest("reload uses new cert"):
        oldFingerprint = machine.succeed(
            "openssl s_client -starttls postgres -host localhost -port 5432 < /dev/null 2>/dev/null | openssl x509 -fingerprint -noout -in /dev/stdin"
        )
        # fake renewal
        machine.succeed("rm -rf /var/lib/acme/${fqdn}")
        machine.succeed("systemctl start acme-selfsigned-${fqdn}.service")
        machine.succeed("systemctl start acme-${fqdn}.service")
        machine.succeed("sleep 3")
        machine.succeed("journalctl -u postgresql | grep -q reloading")
        newFingerprint = machine.succeed(
            "openssl s_client -starttls postgres -host localhost -port 5432 < /dev/null 2>/dev/null | openssl x509 -fingerprint -noout -in /dev/stdin"
        )
        assert oldFingerprint != newFingerprint
  '';
})

