# morph

[morph](https://github.com/DBCDK/morph) is a simple deployment tool
for deploying network of NixOS machines.

Description of our main network is in [morph.nix](../morph.nix).

## Building

To build a complete deployment

```
morph build morph.nix
```

Or a single machine

```
morph build --on=proxy morph.nix
```

## Deploy

Deploy single machine, use `dry-activate` to just copy paths
and see what is about to restart, then proceed with `switch`
if everything looks good.

```
morph deploy --on=proxy morph.nix dry-activate
morph deploy --on=proxy morph.nix switch
```
