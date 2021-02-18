{ callPackage }:
{
  staging = callPackage ./staging {};
  master  = callPackage ./master {};
}
