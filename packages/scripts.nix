{ writeShellScriptBin, wireguard }:
{
  wgKeygen = writeShellScriptBin "om-wg-keygen" ''
    set -e
    test -f /secrets/wireguard/private && { echo "Already there"; exit 1; }
    umask 077
    mkdir -p /secrets/wireguard/
    pushd /secrets/wireguard/
    ${wireguard}/bin/wg genkey > private
    ${wireguard}/bin/wg pubkey < private > public
    echo "    wg = {"
    echo "      publicKey = \"$( cat public )\";"
    echo "    };"
    popd
  '';
}
