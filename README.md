# otevrenamesta.cz configuration

## Install [Morph](https://github.com/DBCDK/morph).

```nix
    environment.systemPackages = with pkgs; [
      morph
    ];
```

## Deploy environment

```bash
morph deploy morph.nix switch
```

## Deploy a single machine

```bash
morph deploy --on=<machine_name> morph.nix switch
```

More in [docs/Morph.md](./docs/Morph.md).
