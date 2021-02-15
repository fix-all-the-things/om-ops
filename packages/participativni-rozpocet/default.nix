{ pkgs ? import <nixpkgs> {
    inherit system;
  }
, system ? builtins.currentSystem
}:

(import ./composition.nix { inherit pkgs system; }).overrideAttrs (attrs:
rec {
  name = "participativni-rozpocet";
  src = pkgs.fetchFromGitLab {
    owner = "otevrenamesta";
    repo = "participativni-rozpocet";
    # can be updated with `update-nix-fetchgit default.nix`
    rev = "79c1e0a71b5287037c765ca40fabd686b5cb9589"; # heads/master
    sha256 = "137f4i4nf641vf7vsdnsl3143rb5z048ava2i37ysczh8fyqs3xb";
  };
})
