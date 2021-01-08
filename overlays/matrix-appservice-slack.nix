self: super:
let
  src = super.fetchFromGitHub {
    owner = "otevrenamesta";
    repo = "matrix-appservice-slack";
    # nix branch
    # can be updated with `update-nix-fetchgit matrix-appservice-slack.nix`
    rev = "9edd9153653434472300b2b0a0b2a4cd83172b01"; # heads/nix
    sha256 = "1lqj0s87zjszkl6ajvg1088a5896xh7g7gwd0f3vrrc220in7lwa";
  };
in
{
  matrix-appservice-slack = self.callPackage "${src}/package.nix" { };
}
