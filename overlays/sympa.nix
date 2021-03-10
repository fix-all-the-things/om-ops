self: super:
{
  sympa = super.sympa.overrideAttrs (old: {
    patches = (old.patches or []) ++ [ ../files/sympa-csdate.patch ];
  });
}
