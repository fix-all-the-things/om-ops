rec {
  mesta-libvirt = {
    addr = {
      pub = {
        ipv4 = "37.205.14.17";
        ipv6 = "2a03:3b40:fe:3d::";
      };
      priv = {
        ipv4 = "10.23.42.1";
        ipv6 = "fc00::1";
      };
    };
    wg = {
      publicKey = "aAEaJiZ2o1ZykkeafQ8bzsBJIxQN1ByZdZ0akstnEyI=";
    };
  };

  proxy = mesta-libvirt;

  mesta-services = {
    addr.pub = {
      ipv4 = "37.205.14.138";
      ipv6 = "2a03:3b40:fe:32::";
    };
  };

  mesta-services-2 = {
    addr.pub = {
      ipv4 = "37.205.12.242";
      ipv6 = "2a03:3b40:fe:1b::1";
    };
  };

  status = {
    addr.pub = {
      ipv4 = "83.167.228.98";
      ipv6 = "2a01:430:17:1::ffff:5";
    };
    addr.int.v4 = "172.16.9.18";
  };

  pg = {
    addr = {
      pub = {
        ipv4 = "37.205.8.221";
        ipv6 = "2a01:430:17:1::ffff:1380";
      };
      priv = {
        ipv4 = "10.23.42.10";
        ipv6 = "fc00::10";
      };
    };
    wg = {
      publicKey = "QLelIUxKvxWwtWitNpHlbr52gXhiVnyvIpW/1x3nfSc=";
    };
  };

  cv-beta = {
    addr ={
      pub = {
        ipv6 = "2a03:3b40:fe:a4::1";
      };
      priv = {
        ipv4 = "10.23.42.100";
        ipv6 = "fc00::100";
      };
    };
    wg = {
      publicKey = "of+cs4hngTCEnpBCqA5ajpDxqDU2atQ8L6brhFs+4T4=";
    };
  };

  cv-prod = {
    addr = {
      pub = {
        ipv4 = "37.205.14.126";
        ipv6 = "2a01:430:17:1::ffff:336";
      };
      priv = {
        ipv4 = "10.23.42.101";
        ipv6 = "fc00::101";
      };
    };
    wg = {
      publicKey = "KTiPL+6nrMhdo3MvheVBeU60MaCjEzNgF6UGiYqvKhA=";
    };
  };

  wireguard = mesta-libvirt;
}
