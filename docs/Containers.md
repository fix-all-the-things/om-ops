# oci-containers

NixOS has support for running OCI compatible comtainers
with two different backends - `docker` and `podman`.

Containers defined via `virtualisation.oci-containers.containers.<name>`
have generated services `docker-<name>.service` or `podman-<name>.service` respectively.

With `podman` backend, enabling `virtualisation.podman.dockerCompat` aliases
`podman` command to `docker` command, the rest of this guide uses `podman <..>` but you
can use `docker <..>` if you prefer.

When `virtualisation.oci-containers.containers.<name>.imageFile` is set
the image is imported from Nix store. When not set it is downloaded
from Docker registry based on configured tag.

## Toggling all services

To stop all podman containers, use:

```
systemctl stop podman-\*
```

Respectively for `docker` backend and start/restart operations.

## Updating containers

Example for CityVizor:

```
docker pull docker.io/cityvizor/cityvizor-client:<tag>
docker pull docker.io/cityvizor/cityvizor-server:<tag>
docker pull docker.io/cityvizor/landing-page:<tag>
systemctl restart podman-cv-\*
```

## Resetting to clean state

### Delete all images

Warning: This will stop all containers first, only use on development/staging
environments.

To remove all stored images use:

```
podman rmi --force --all
```

Next service start triggers download of all images (if not pinned using `imageFile`):

```
systemctl restart podman-\*
```

### System reset

If you need to clean all images and containers, stop everything
and issue system reset:

```
podman system reset
```

## Debugging containers

To debug issues with containers, [cntr](https://github.com/Mic92/cntr) tool is provided
and can be used to get a shell in container with tools from host, for example:

```
cntr attach <NAMEorID>
cntr attach cv-landing-page
cntr attach 01ac0d8630a7
```
