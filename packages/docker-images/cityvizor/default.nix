{ dockerTools }:
{
  cityvizor-client = dockerTools.pullImage (import ./cityvizor-client.nix);
  cityvizor-server = dockerTools.pullImage (import ./cityvizor-server.nix);
  landing-page     = dockerTools.pullImage (import ./landing-page.nix);
  server-kotlin    = dockerTools.pullImage (import ./server-kotlin.nix);
}
