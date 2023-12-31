# Wireguard client
{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.om.wireguard;
  data = import ../data;
in
{
  options = {
    om.wireguard = {
      enable = mkEnableOption "Enable OM wireguard";
      ips = mkOption {
        type = types.listOf types.str;
        default = [
          "${data.hosts.${config.networking.hostName}.addr.priv.ipv4}/32"
          "${data.hosts.${config.networking.hostName}.addr.priv.ipv6}/128"
        ];
      };

      allowedIPs = mkOption {
        type = types.listOf types.str;
        default = [ "10.23.42.0/24" "fc00::/64" ];
      };

      allowedIPsAsRoutes = mkOption {
        type = types.bool;
        default = true;
      };

      preferIPv4 = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf config.om.wireguard.enable {
    networking.wireguard.interfaces = {
      wg0 = {
        inherit (cfg) ips allowedIPsAsRoutes;

        privateKeyFile = "/secrets/wireguard/private";

        peers = [
          {
            endpoint = if cfg.preferIPv4
              then "[${data.hosts.wireguard.addr.pub.ipv4}]:23333"
              else "[${data.hosts.wireguard.addr.pub.ipv6}]:23333";
            persistentKeepalive = 25;
            inherit (cfg) allowedIPs;
            inherit (data.hosts.wireguard.wg) publicKey;
          }
        ];
      };
    };
  };
}
