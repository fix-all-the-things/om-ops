
# -- #!/usr/bin/env nix-shell
# -- #! nix-shell -i bash -E "with (import <nixpkgs> {}); import (pkgs.fetchurl { url = \"https://raw.githubusercontent.com/svanderburg/composer2nix/master/release.nix\"; sha256 = \"0n8nnlzbl9zhx9bzn8yfkhvimkvv5j5awcm45qf7i4d94cz0nxh7\"; }) {}"

# needs composer2nix

set -euo pipefail

if [ $# = 0 ]; then
  echo "Usage: $0 <git revision>"
  exit 1
fi

REV=$1
PROJECT="dsw2"
SOURCEDIR="$PROJECT-$REV"

curl -Lo archive.tar.gz "https://gitlab.com/otevrenamesta/$PROJECT/-/archive/$REV/$PROJECT-$REV.tar.gz"
tar xzf archive.tar.gz

# --no-copy-composer-env is used because we modified it to pass
# the --no-scripts flag to "composer install"
# Because composer2nix is early prototype, make sure to keep the
# env file in sync with upstream.
# See also: https://github.com/svanderburg/composer2nix/pull/11
# XXX
#composer2nix \
/home/srk/git/composer2nix/result/bin/composer2nix \
        --config-file="$SOURCEDIR/composer.json" \
        --lock-file="$SOURCEDIR/composer.lock" \
        --composition=composition.nix \
        --no-copy-composer-env

echo ""
echo "Done: generated composition.nix and php-packages.nix"
echo "Now you need to edit default.nix and change rev and sha256"
