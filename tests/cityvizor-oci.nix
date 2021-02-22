{ system ? builtins.currentSystem
, config ? {}
, pkgs ? import <nixpkgs> { inherit system config; }
, lib ? pkgs.lib
}:

let
  inherit (import <nixpkgs/nixos/lib/testing-python.nix> { inherit system pkgs; }) makeTest;

  makeCVTest = backend: makeTest {

    name = "cityvizor-oci-${backend}";
    meta = with pkgs.stdenv.lib.maintainers; {
      maintainers = [ sorki ];
    };

    machine = { config, ... }: {
      imports = [
        ../modules/cityvizor-oci.nix
      ];

      services.cityvizor = {
        enable = true;
        containers.backend = backend;
        containers.tag = "staging";
        database = {
          createLocally = true;
          demoData.enable = true;
          host = "192.168.1.1";
        };
        s3 = {
          accessKey = "dummy";
          secretKey = "snake-oil";
        };
        landing-page.settings.trackingHtml = "<h3>Very customized</h3>";
      };

      networking.primaryIPAddress = "192.168.1.1";
      # allow ^ and both podman and docker ranges
      services.postgresql.authentication = ''
        host ${config.services.cityvizor.database.name} ${config.services.cityvizor.database.user} 192.168.1.1/32 trust
        host ${config.services.cityvizor.database.name} ${config.services.cityvizor.database.user} 10.0.0.0/8 trust
        host ${config.services.cityvizor.database.name} ${config.services.cityvizor.database.user} 172.0.0.0/8 trust
      '';
      networking.firewall.allowedTCPPorts = [ 5432 ];
      environment.systemPackages =
      let
        testRunner = pkgs.writers.writePython3Bin "test-runner"
          {
            libraries = [ pkgs.python3Packages.selenium ];
          } (builtins.readFile ./selenium/cityvizor.py);
       in
         [ pkgs.firefox-unwrapped pkgs.geckodriver testRunner ];


      virtualisation.memorySize = 2*1024;
      virtualisation.diskSize = 5*1024;
      virtualisation.cores = 2;
    };

    testScript = { nodes, ...}: let
      serverInstances = nodes.machine.config.services.cityvizor.server.redundantInstances;
      serverPort = nodes.machine.config.services.cityvizor.server.port;
    in
    ''
      machine.start()
      machine.wait_for_unit("postgresql.service")
      machine.wait_for_unit("${backend}-cv-server.service")
      machine.wait_for_unit("${backend}-cv-client.service")
      machine.wait_for_unit("${backend}-cv-landing-page.service")
      machine.wait_for_unit("${backend}-cv-worker.service")
      machine.wait_for_unit("nginx.service")
      machine.wait_for_open_port("${builtins.toString serverPort}")

      with subtest("check landing page redirect"):
          http_code = machine.succeed(
              f"curl -s -w '%{{http_code}}' --head --fail -v localhost"
          )
          assert http_code.split("\n")[-1] == "302"

      with subtest("check landing page"):
          machine.succeed("curl -s localhost/landing")

      with subtest("check that cutomization propagates"):
          machine.succeed("curl -s localhost/landing/cfg/content.json | grep customized")

      with subtest("check profile page"):
          machine.succeed("curl -s localhost/praha12")

      with subtest("check profile api response"):
          machine.succeed(
              "curl -s localhost/api/public/profiles/praha12 | ${pkgs.jq}/bin/jq"
          )
          print(
              machine.succeed(
                  "curl -s localhost/api/public/profiles/praha12 | ${pkgs.jq}/bin/jq"
              )
          )


      ${lib.optionalString (nodes.machine.config.services.cityvizor.server.redundantInstances != 0)
      ''
      machine.wait_for_open_port("${builtins.toString (serverPort + 1)}")
      machine.succeed("sleep 10")
      with subtest("check access to redundant server instance(s)"):
          print(machine.succeed("curl 127.0.0.1:${builtins.toString (serverPort + 1)}"))
      ''}

      with subtest("check that no npm ERRs are present in logs"):
          print(machine.fail("journalctl | grep -q ERR"))

      with subtest("run selenium test"):
          machine.succeed("mkdir pics")
          machine.succeed("PYTHONUNBUFFERED=1 test-runner | systemd-cat -t test-runner")

      machine.copy_from_vm("pics", "")

      print(machine.succeed("docker ps"))
    '';
  };
in
{
  cv_podman = makeCVTest "podman";
  cv_docker = makeCVTest "docker";
}
