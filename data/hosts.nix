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

  proxy = {
    addr = {
      pub = mesta-libvirt.addr.pub;
      priv = {
        ipv4 = "10.23.42.30";
        ipv6 = "fc00::30";
      };
    };
    wg = {
      publicKey = "fA/Clr7cuq83KBMcOE4+m7YS6yXqztxfvAUE7FLxkHc=";
    };
  };

  mesta-services = {
    addr = {
      pub = {
        ipv4 = "37.205.14.138";
        ipv6 = "2a03:3b40:fe:32::";
      };
      priv = {
        ipv4 = "10.23.42.2";
        ipv6 = "fc00::2";
      };
    };
    wg = {
      publicKey = "/fApBe80FZQngUtDj+ipisf/FeqZCK+UDlETMGV9aFY=";
    };
  };

  mesta-services-2 = {
    addr = {
      pub = {
        ipv4 = "37.205.12.242";
        ipv6 = "2a03:3b40:fe:1b::1";
      };
      priv = {
        ipv4 = "10.23.42.3";
        ipv6 = "fc00::3";
      };
    };
    wg = {
      publicKey = "emKv5LxjFgAexf92dQjySMWLqiXUvsxYV+8LNBK44DQ=";
    };
  };

  status = {
    addr = {
      pub = {
        ipv4 = "83.167.228.98";
        ipv6 = "2a01:430:17:1::ffff:5";
      };
      priv = {
        ipv4 = "10.23.42.9";
        ipv6 = "fc00::9";
      };
      int.ipv4 = "172.16.9.18";
    };
    wg = {
      publicKey = "NnaPs4QlJzybVQgD0airoaRfR1jVB4OrN9v83ZrUUh4=";
    };
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
        ipv6 = "2a03:3b40:fe:134::1";
      };
      priv = {
        ipv4 = "10.23.42.100";
        ipv6 = "fc00::100";
      };
    };
    wg = {
      publicKey = "3lrRjxG7w5VctvI9lPcloBBICsf2mbbWWQM3mc0vGiw=";
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

  registry-dev = {
    addr = {
      priv = {
        ipv4 = "10.23.42.102";
        ipv6 = "fc00::122";
      };
    };
    wg = {
      publicKey = "Rut/XcVzADOzY7YUNJRz/fdMGyJAuBdowQbmVy0iMko=";
    };
  };

  wireguard = mesta-libvirt;

  smarttabor = {
    addr = {
      priv = {
        ipv4 = "10.23.42.20";
        ipv6 = "fc00::121";
      };
    };
    wg = {
      publicKey = "EAk2ry17VtBZX7D1S3OV7AiJq9XqJnokv6GcQg4xTQc=";
    };
  };
}
