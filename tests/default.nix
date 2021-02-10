{
  inherit (import ./cityvizor-oci.nix {}) cv_podman cv_docker;
  pg-ssl = import ./postgresql-ssl.nix {};
}
