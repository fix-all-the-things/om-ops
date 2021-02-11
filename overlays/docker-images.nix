self: super:
{
  docker-images = self.callPackage ../packages/docker-images { };
}
