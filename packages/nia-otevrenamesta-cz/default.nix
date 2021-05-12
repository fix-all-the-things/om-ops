{ pkgs ? import <nixpkgs> {
    inherit system;
  }
, system ? builtins.currentSystem
}:

let
  rev = "eb47282cd836a210d289a0508360cec119c974a4";
  sha256 = "1fxhsgy2vbhhwafqkvx7fqc8ngpxggjxbjpl67am4pinda9d73lh";
in
(import ./composition.nix { inherit pkgs system; }).overrideAttrs (attrs:
{
  name = "nia.otevrenamesta.cz";
  src = pkgs.fetchzip {
    url = "https://github.com/otevrenamesta/nia.otevrenamesta.cz/archive/${rev}.tar.gz";
    inherit sha256;
  };
})
