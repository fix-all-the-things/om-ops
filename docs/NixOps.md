This guide is obsolete since we use [morph](./Morph.md).

Old NixOps deployments can be still found in attic directory at repository root.


# Environments

## Virt

```
. activate_virt
nixops create network.nix network-virt.nix
```

## Staging

```
. activate_staging
nixops create network-small-staging.nix network-staging.nix
```

## Brno

```
. activate_brno
nixops create network-small.nix network-brno.nix
```

## Host OS configuration

```
nix.useSandbox = true;

# if cache gives you problems
nix.extraOptions = ''
 binary-caches-parallel-connections = 3
 connect-timeout = 5
'';
```

## NixOps

### Delete obsolete vms
```
nixops deploy -d virt --kill-obsolete
```

### Modify deployment
```
nixops modify -d staging network-new-logical.nix network-new-physical.nix
```

### Modify and rename deployment
```
nixops modify -d staging -n temporary network-new-logical.nix network-new-physical.nix
```
