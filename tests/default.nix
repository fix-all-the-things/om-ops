{
  inherit (import ./cityvizor-oci.nix {}) cv_podman cv_docker;
  pg-ssl = import ./postgresql-ssl.nix {};
  paro2 = import ./paro2.nix {};
}
