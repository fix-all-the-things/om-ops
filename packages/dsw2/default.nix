{ pkgs ? import <nixpkgs> {
    inherit system;
  }
, system ? builtins.currentSystem
}:

(import ./composition.nix { inherit pkgs system; }).overrideAttrs (attrs:
rec {
  name = "dsw2";
  src = pkgs.fetchFromGitLab {
    owner = "otevrenamesta";
    repo = "dsw2";
    # can be updated with `update-nix-fetchgit default.nix`
    rev = "457f25199343ebf838c40d1a96c3a32c3aa6af2b"; # heads/master
    sha256 = "0n5hidz5sfjgknkdwz48ff8z3yw89dzqx2sxkk182gmsia7mb5i7";
  };
})
