{composerEnv, fetchurl, fetchgit ? null, fetchhg ? null, fetchsvn ? null, noDev ? false}:

let
  packages = {
    "aura/intl" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "aura-intl-7fce228980b19bf4dee2d7bbd6202a69b0dde926";
        src = fetchurl {
          url = https://api.github.com/repos/auraphp/Aura.Intl/zipball/7fce228980b19bf4dee2d7bbd6202a69b0dde926;
          sha256 = "05aaba8rqkx33bdy8j425nxr6q6yys8di79y6kfmmbgxlkjj7fn9";
        };
      };
    };
    "cakephp/authentication" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "cakephp-authentication-0ee1b4341e3ff69d120f3c46b41a93a26b777125";
        src = fetchurl {
          url = https://api.github.com/repos/cakephp/authentication/zipball/0ee1b4341e3ff69d120f3c46b41a93a26b777125;
          sha256 = "13v45k83xjjl0fmm2s10rb6zm3plgpfjhq584x3d28m75liv99wi";
        };
      };
    };
    "cakephp/authorization" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "cakephp-authorization-3e9a171082855b6bae4c12cc88f63514b9645102";
        src = fetchurl {
          url = https://api.github.com/repos/cakephp/authorization/zipball/3e9a171082855b6bae4c12cc88f63514b9645102;
          sha256 = "0wnfi1f4gfjiqf3c9lg659f16j1y1j831hk33lawg747fsjh65gr";
        };
      };
    };
    "cakephp/cakephp" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "cakephp-cakephp-d8c526bb3e5640235282d189fb071e9c800b4f49";
        src = fetchurl {
          url = https://api.github.com/repos/cakephp/cakephp/zipball/d8c526bb3e5640235282d189fb071e9c800b4f49;
          sha256 = "0hfv1jfgq4ai9cp2z7i7kyz0ixnszxrqjlxdbv79dp7x15rnb21p";
        };
      };
    };
    "cakephp/chronos" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "cakephp-chronos-30baea51824076719921c6c2d720bfd6b49e6dca";
        src = fetchurl {
          url = https://api.github.com/repos/cakephp/chronos/zipball/30baea51824076719921c6c2d720bfd6b49e6dca;
          sha256 = "0ymz4rl3rkszw2hxgj7a7z9g9cy8d2h4xdfvybkp7pwih47ar6fx";
        };
      };
    };
    "cakephp/migrations" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "cakephp-migrations-a41a44e726dcc3634db0c2ac6bc4e158e416d103";
        src = fetchurl {
          url = https://api.github.com/repos/cakephp/migrations/zipball/a41a44e726dcc3634db0c2ac6bc4e158e416d103;
          sha256 = "0ymza5bmd6nsc69vk8l6rxxqjzsz91mhq91a2nx027yqq61h8ffg";
        };
      };
    };
    "cakephp/plugin-installer" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "cakephp-plugin-installer-e27027aa2d3d8ab64452c6817629558685a064cb";
        src = fetchurl {
          url = https://api.github.com/repos/cakephp/plugin-installer/zipball/e27027aa2d3d8ab64452c6817629558685a064cb;
          sha256 = "040iv0gmqih3w50slsz5cxvvkgpg6anyxm71v69p43kiy4ak08a1";
        };
      };
    };
    "composer/ca-bundle" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "composer-ca-bundle-8a7ecad675253e4654ea05505233285377405215";
        src = fetchurl {
          url = https://api.github.com/repos/composer/ca-bundle/zipball/8a7ecad675253e4654ea05505233285377405215;
          sha256 = "1l4rxcgya42ms654lxybgcg15zgdzxsrzdpkzk1k4zlv8qksh2m7";
        };
      };
    };
    "laminas/laminas-diactoros" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "laminas-laminas-diactoros-36ef09b73e884135d2059cc498c938e90821bb57";
        src = fetchurl {
          url = https://api.github.com/repos/laminas/laminas-diactoros/zipball/36ef09b73e884135d2059cc498c938e90821bb57;
          sha256 = "0qzf3890j1976q6f684fydz49gd48kg3hwipzhsw0dgbcgmr8qs6";
        };
      };
    };
    "laminas/laminas-httphandlerrunner" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "laminas-laminas-httphandlerrunner-e1a5dad040e0043135e8095ee27d1fbf6fb640e1";
        src = fetchurl {
          url = https://api.github.com/repos/laminas/laminas-httphandlerrunner/zipball/e1a5dad040e0043135e8095ee27d1fbf6fb640e1;
          sha256 = "0qn0ip0ahsw4y1w442yky4i5fhnddmmznbcpjyaq53jicxzgdpk1";
        };
      };
    };
    "laminas/laminas-zendframework-bridge" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "laminas-laminas-zendframework-bridge-6ede70583e101030bcace4dcddd648f760ddf642";
        src = fetchurl {
          url = https://api.github.com/repos/laminas/laminas-zendframework-bridge/zipball/6ede70583e101030bcace4dcddd648f760ddf642;
          sha256 = "10cksxv2fzv3d14n8kmij3wvfibddzp1qz65dqgybs1w2fd1n358";
        };
      };
    };
    "mobiledetect/mobiledetectlib" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "mobiledetect-mobiledetectlib-6f8113f57a508494ca36acbcfa2dc2d923c7ed5b";
        src = fetchurl {
          url = https://api.github.com/repos/serbanghita/Mobile-Detect/zipball/6f8113f57a508494ca36acbcfa2dc2d923c7ed5b;
          sha256 = "0cf40xla0dw382cfm51627wrzzypq59s7skcznspn14bdcjsvbmx";
        };
      };
    };
    "psr/container" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-container-b7ce3b176482dbbc1245ebf52b181af44c2cf55f";
        src = fetchurl {
          url = https://api.github.com/repos/php-fig/container/zipball/b7ce3b176482dbbc1245ebf52b181af44c2cf55f;
          sha256 = "0rkz64vgwb0gfi09klvgay4qnw993l1dc03vyip7d7m2zxi6cy4j";
        };
      };
    };
    "psr/http-client" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-http-client-2dfb5f6c5eff0e91e20e913f8c5452ed95b86621";
        src = fetchurl {
          url = https://api.github.com/repos/php-fig/http-client/zipball/2dfb5f6c5eff0e91e20e913f8c5452ed95b86621;
          sha256 = "0cmkifa3ji1r8kn3y1rwg81rh8g2crvnhbv2am6d688dzsbw967v";
        };
      };
    };
    "psr/http-factory" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-http-factory-12ac7fcd07e5b077433f5f2bee95b3a771bf61be";
        src = fetchurl {
          url = https://api.github.com/repos/php-fig/http-factory/zipball/12ac7fcd07e5b077433f5f2bee95b3a771bf61be;
          sha256 = "0inbnqpc5bfhbbda9dwazsrw9xscfnc8rdx82q1qm3r446mc1vds";
        };
      };
    };
    "psr/http-message" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-http-message-f6561bf28d520154e4b0ec72be95418abe6d9363";
        src = fetchurl {
          url = https://api.github.com/repos/php-fig/http-message/zipball/f6561bf28d520154e4b0ec72be95418abe6d9363;
          sha256 = "195dd67hva9bmr52iadr4kyp2gw2f5l51lplfiay2pv6l9y4cf45";
        };
      };
    };
    "psr/http-server-handler" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-http-server-handler-aff2f80e33b7f026ec96bb42f63242dc50ffcae7";
        src = fetchurl {
          url = https://api.github.com/repos/php-fig/http-server-handler/zipball/aff2f80e33b7f026ec96bb42f63242dc50ffcae7;
          sha256 = "0sfz1j9lxirsld0zm0bqqmxf52krjn982w3fq9n27q7mpjd33y4x";
        };
      };
    };
    "psr/http-server-middleware" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-http-server-middleware-2296f45510945530b9dceb8bcedb5cb84d40c5f5";
        src = fetchurl {
          url = https://api.github.com/repos/php-fig/http-server-middleware/zipball/2296f45510945530b9dceb8bcedb5cb84d40c5f5;
          sha256 = "1r92xj2hybnxcnamxqklk5kivkgy0bi34hhsh00dnwn9wmf3s0gj";
        };
      };
    };
    "psr/log" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-log-0f73288fd15629204f9d42b7055f72dacbe811fc";
        src = fetchurl {
          url = https://api.github.com/repos/php-fig/log/zipball/0f73288fd15629204f9d42b7055f72dacbe811fc;
          sha256 = "1npi9ggl4qll4sdxz1xgp8779ia73gwlpjxbb1f1cpl1wn4s42r4";
        };
      };
    };
    "psr/simple-cache" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-simple-cache-408d5eafb83c57f6365a3ca330ff23aa4a5fa39b";
        src = fetchurl {
          url = https://api.github.com/repos/php-fig/simple-cache/zipball/408d5eafb83c57f6365a3ca330ff23aa4a5fa39b;
          sha256 = "1djgzclkamjxi9jy4m9ggfzgq1vqxaga2ip7l3cj88p7rwkzjxgw";
        };
      };
    };
    "robmorgan/phinx" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "robmorgan-phinx-05902f4a90790ce9db195954e608d5a43d4d6a7d";
        src = fetchurl {
          url = https://api.github.com/repos/cakephp/phinx/zipball/05902f4a90790ce9db195954e608d5a43d4d6a7d;
          sha256 = "0jva7pvqp12b0h8ph7ar9mhwcpbbr12zaflbyi0kmnm7ja5l07qw";
        };
      };
    };
    "robrichards/xmlseclibs" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "robrichards-xmlseclibs-f8f19e58f26cdb42c54b214ff8a820760292f8df";
        src = fetchurl {
          url = https://api.github.com/repos/robrichards/xmlseclibs/zipball/f8f19e58f26cdb42c54b214ff8a820760292f8df;
          sha256 = "01zlpm36rrdj310cfmiz2fnabszxd3fq80fa8x8j3f9ki7dvhh5y";
        };
      };
    };
    "simplesamlphp/saml2" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "simplesamlphp-saml2-1f0c32fca12a625ba24eb55fe3c08f6565bc6e6a";
        src = fetchurl {
          url = https://api.github.com/repos/simplesamlphp/saml2/zipball/1f0c32fca12a625ba24eb55fe3c08f6565bc6e6a;
          sha256 = "0h0qlbyrp1hy62p2xkkygd528ixjwh8m0qav1c4n91pngj9fyima";
        };
      };
    };
    "symfony/config" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-config-11baeefa4c179d6908655a7b6be728f62367c193";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/config/zipball/11baeefa4c179d6908655a7b6be728f62367c193;
          sha256 = "0xpyg7xlha1b3i7qfm9bxs5dfqdph9m4lmhfyfij1ws07avmb8d6";
        };
      };
    };
    "symfony/console" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-console-e0b2c29c0fa6a69089209bbe8fcff4df2a313d0e";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/console/zipball/e0b2c29c0fa6a69089209bbe8fcff4df2a313d0e;
          sha256 = "1fqsdl6ygprmirsgkmfqwzwz6g1qinb4glxl33sazai4z2c01zaj";
        };
      };
    };
    "symfony/deprecation-contracts" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-deprecation-contracts-5fa56b4074d1ae755beb55617ddafe6f5d78f665";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/deprecation-contracts/zipball/5fa56b4074d1ae755beb55617ddafe6f5d78f665;
          sha256 = "0ny59x0aaipqaj956wx7ak5f6d5rn90766swp5m18019v9cppg10";
        };
      };
    };
    "symfony/filesystem" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-filesystem-df08650ea7aee2d925380069c131a66124d79177";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/filesystem/zipball/df08650ea7aee2d925380069c131a66124d79177;
          sha256 = "0acwjra4rn5k0z4ziw68jnyk20ccc25lvbs07li5ifprnfxrrf8i";
        };
      };
    };
    "symfony/polyfill-ctype" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-ctype-f4ba089a5b6366e453971d3aad5fe8e897b37f41";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/polyfill-ctype/zipball/f4ba089a5b6366e453971d3aad5fe8e897b37f41;
          sha256 = "0gx3vypz6hipnma7ymqlarr66yxddjmqwkgspiriy8mqcz2y61mn";
        };
      };
    };
    "symfony/polyfill-intl-grapheme" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-intl-grapheme-c7cf3f858ec7d70b89559d6e6eb1f7c2517d479c";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/polyfill-intl-grapheme/zipball/c7cf3f858ec7d70b89559d6e6eb1f7c2517d479c;
          sha256 = "05c86w116v6n1ipvhy3xgb7hmp75wswrmqabfi5z0wd3m8is00hx";
        };
      };
    };
    "symfony/polyfill-intl-normalizer" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-intl-normalizer-727d1096295d807c309fb01a851577302394c897";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/polyfill-intl-normalizer/zipball/727d1096295d807c309fb01a851577302394c897;
          sha256 = "1w4v31l8bnvzjdfafzamwr4fsdf25w7pxmihxkb7z2y9pj9mrsag";
        };
      };
    };
    "symfony/polyfill-mbstring" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-mbstring-39d483bdf39be819deabf04ec872eb0b2410b531";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/polyfill-mbstring/zipball/39d483bdf39be819deabf04ec872eb0b2410b531;
          sha256 = "1rzll717f58biifmxsb56akm7fsjfj70wahycdsfpxdds75m267w";
        };
      };
    };
    "symfony/polyfill-php73" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-php73-8ff431c517be11c78c48a39a66d37431e26a6bed";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/polyfill-php73/zipball/8ff431c517be11c78c48a39a66d37431e26a6bed;
          sha256 = "00rrgiy04y0qfqyvgdr501i66k3sghl6z21vncg05szijp6s6sb3";
        };
      };
    };
    "symfony/polyfill-php80" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-php80-e70aa8b064c5b72d3df2abd5ab1e90464ad009de";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/polyfill-php80/zipball/e70aa8b064c5b72d3df2abd5ab1e90464ad009de;
          sha256 = "1q3gkx34fl7683dcc6w9214k5cpn3bbg7p7yhfxad1x1a1fl62ig";
        };
      };
    };
    "symfony/service-contracts" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-service-contracts-d15da7ba4957ffb8f1747218be9e1a121fd298a1";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/service-contracts/zipball/d15da7ba4957ffb8f1747218be9e1a121fd298a1;
          sha256 = "168iq1lp2r5qb5h8j0s17da09iaj2h5hrrdc9rw2p73hq8rvm1w2";
        };
      };
    };
    "symfony/string" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-string-a97573e960303db71be0dd8fda9be3bca5e0feea";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/string/zipball/a97573e960303db71be0dd8fda9be3bca5e0feea;
          sha256 = "05lhgiakx7r0xsnzqggidlg0vni7a4n2fcx3b9kyznwhs694ggzi";
        };
      };
    };
    "webmozart/assert" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "webmozart-assert-bafc69caeb4d49c39fd0779086c03a3738cbb389";
        src = fetchurl {
          url = https://api.github.com/repos/webmozart/assert/zipball/bafc69caeb4d49c39fd0779086c03a3738cbb389;
          sha256 = "0wd0si4c9r1256xj76vgk2slxpamd0wzam3dyyz0g8xgyra7201c";
        };
      };
    };
  };
  devPackages = {
    "cakephp/bake" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "cakephp-bake-f1c297c4e903a15188389011b93ce46119849d01";
        src = fetchurl {
          url = https://api.github.com/repos/cakephp/bake/zipball/f1c297c4e903a15188389011b93ce46119849d01;
          sha256 = "0f4pb4r8rp79mj9rrky8dy5ivjmi8whi6373xlhls2wrj47912f8";
        };
      };
    };
    "cakephp/cakephp-codesniffer" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "cakephp-cakephp-codesniffer-ea268e9fea27ac70b42b0051537e65feeb002511";
        src = fetchurl {
          url = https://api.github.com/repos/cakephp/cakephp-codesniffer/zipball/ea268e9fea27ac70b42b0051537e65feeb002511;
          sha256 = "09fr2khngbncy6197bx4y7p7vvmxj8vxh79awmaxiqcrz6l6hzkg";
        };
      };
    };
    "cakephp/debug_kit" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "cakephp-debug_kit-ef39d978c8421e06f6c5caee126c34edbef1d76e";
        src = fetchurl {
          url = https://api.github.com/repos/cakephp/debug_kit/zipball/ef39d978c8421e06f6c5caee126c34edbef1d76e;
          sha256 = "1mba290cb35zmyqqzm8b7an8ifbgjsblcv3bkfsl2lc4568qmlr8";
        };
      };
    };
    "cakephp/twig-view" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "cakephp-twig-view-0fdd5771c7165b9843a2c07e00b81e85d5c90860";
        src = fetchurl {
          url = https://api.github.com/repos/cakephp/twig-view/zipball/0fdd5771c7165b9843a2c07e00b81e85d5c90860;
          sha256 = "1n9sh2cql4cpx7zsmswlgr5hy7ch8vlf2zm0y30031j2xavbm4gl";
        };
      };
    };
    "composer/composer" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "composer-composer-09d42e18394d8594be24e37923031c4b7442a1cb";
        src = fetchurl {
          url = https://api.github.com/repos/composer/composer/zipball/09d42e18394d8594be24e37923031c4b7442a1cb;
          sha256 = "1vfi9nbvvw2bq6xirlgfkl4rq7579g4a179ralqsi36cgmilg9x5";
        };
      };
    };
    "composer/semver" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "composer-semver-38276325bd896f90dfcfe30029aa5db40df387a7";
        src = fetchurl {
          url = https://api.github.com/repos/composer/semver/zipball/38276325bd896f90dfcfe30029aa5db40df387a7;
          sha256 = "17a9yixy54sy3mh1mwrgkjv430ivz6gl51c6yhppqs90wdhalpx7";
        };
      };
    };
    "composer/spdx-licenses" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "composer-spdx-licenses-6946f785871e2314c60b4524851f3702ea4f2223";
        src = fetchurl {
          url = https://api.github.com/repos/composer/spdx-licenses/zipball/6946f785871e2314c60b4524851f3702ea4f2223;
          sha256 = "0raab8q0kcxngz2r9s8psgz211vmfhnbw6x87p2gfvpyrnraan56";
        };
      };
    };
    "composer/xdebug-handler" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "composer-xdebug-handler-6e076a124f7ee146f2487554a94b6a19a74887ba";
        src = fetchurl {
          url = https://api.github.com/repos/composer/xdebug-handler/zipball/6e076a124f7ee146f2487554a94b6a19a74887ba;
          sha256 = "1883lzc78hgzcacqzs0mcv034wycgiz6019p1axy8x68xxai79mf";
        };
      };
    };
    "dealerdirect/phpcodesniffer-composer-installer" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "dealerdirect-phpcodesniffer-composer-installer-e8d808670b8f882188368faaf1144448c169c0b7";
        src = fetchurl {
          url = https://api.github.com/repos/Dealerdirect/phpcodesniffer-composer-installer/zipball/e8d808670b8f882188368faaf1144448c169c0b7;
          sha256 = "0sz09ppjjxyq8h3g2lc88k3kd24kragl0fqmr72dqb5dvg3fb01k";
        };
      };
    };
    "dereuromark/cakephp-ide-helper" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "dereuromark-cakephp-ide-helper-a00317ce492b58fef87bbda02cdb047117f5aafc";
        src = fetchurl {
          url = https://api.github.com/repos/dereuromark/cakephp-ide-helper/zipball/a00317ce492b58fef87bbda02cdb047117f5aafc;
          sha256 = "195ysskxgf5bl923189vaw5in4ycb5gh4brpjg0sw4sqi5kyf0hs";
        };
      };
    };
    "dnoegel/php-xdg-base-dir" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "dnoegel-php-xdg-base-dir-8f8a6e48c5ecb0f991c2fdcf5f154a47d85f9ffd";
        src = fetchurl {
          url = https://api.github.com/repos/dnoegel/php-xdg-base-dir/zipball/8f8a6e48c5ecb0f991c2fdcf5f154a47d85f9ffd;
          sha256 = "02n4b4wkwncbqiz8mw2rq35flkkhn7h6c0bfhjhs32iay1y710fq";
        };
      };
    };
    "doctrine/instantiator" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "doctrine-instantiator-d56bf6102915de5702778fe20f2de3b2fe570b5b";
        src = fetchurl {
          url = https://api.github.com/repos/doctrine/instantiator/zipball/d56bf6102915de5702778fe20f2de3b2fe570b5b;
          sha256 = "04rihgfjv8alvvb92bnb5qpz8fvqvjwfrawcjw34pfnfx4jflcwh";
        };
      };
    };
    "jasny/twig-extensions" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "jasny-twig-extensions-a694eb02f6fc14ff8e2fceb8b80882c0c926102b";
        src = fetchurl {
          url = https://api.github.com/repos/jasny/twig-extensions/zipball/a694eb02f6fc14ff8e2fceb8b80882c0c926102b;
          sha256 = "0gwpibzrf159f839mqvpxil78bdp23sy621jf760mcnzvg6kn6hz";
        };
      };
    };
    "jdorn/sql-formatter" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "jdorn-sql-formatter-64990d96e0959dff8e059dfcdc1af130728d92bc";
        src = fetchurl {
          url = https://api.github.com/repos/jdorn/sql-formatter/zipball/64990d96e0959dff8e059dfcdc1af130728d92bc;
          sha256 = "1dnmkm8mxylvxjwi0bdkzrlklncqx92fa4fwqp5bh2ypj8gaagzi";
        };
      };
    };
    "josegonzalez/dotenv" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "josegonzalez-dotenv-f19174d9d7213a6c20e8e5e268aa7dd042d821ca";
        src = fetchurl {
          url = https://api.github.com/repos/josegonzalez/php-dotenv/zipball/f19174d9d7213a6c20e8e5e268aa7dd042d821ca;
          sha256 = "05332v80v3cwdfbf0jlw95s50yjf0qmd1x60iicpnhpjp3rfnp9p";
        };
      };
    };
    "justinrainbow/json-schema" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "justinrainbow-json-schema-2ba9c8c862ecd5510ed16c6340aa9f6eadb4f31b";
        src = fetchurl {
          url = https://api.github.com/repos/justinrainbow/json-schema/zipball/2ba9c8c862ecd5510ed16c6340aa9f6eadb4f31b;
          sha256 = "18hqybnyfcyvnkjzgq91nqgb2c05gmziliq5ck8l8cy7s75wm6xf";
        };
      };
    };
    "m1/env" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "m1-env-5c296e3e13450a207e12b343f3af1d7ab569f6f3";
        src = fetchurl {
          url = https://api.github.com/repos/m1/Env/zipball/5c296e3e13450a207e12b343f3af1d7ab569f6f3;
          sha256 = "0nd2vxgdghrym5vsj2z7fr6spc5jkdlqqd1v1y9z7m0fyrm8plfn";
        };
      };
    };
    "myclabs/deep-copy" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "myclabs-deep-copy-969b211f9a51aa1f6c01d1d2aef56d3bd91598e5";
        src = fetchurl {
          url = https://api.github.com/repos/myclabs/DeepCopy/zipball/969b211f9a51aa1f6c01d1d2aef56d3bd91598e5;
          sha256 = "0i5aswlbn7pxhgwswpqxf5wdr1v40kic4a2z06xv77wnfkhb6myh";
        };
      };
    };
    "nikic/php-parser" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "nikic-php-parser-658f1be311a230e0907f5dfe0213742aff0596de";
        src = fetchurl {
          url = https://api.github.com/repos/nikic/PHP-Parser/zipball/658f1be311a230e0907f5dfe0213742aff0596de;
          sha256 = "1y204j1h8y4wkk97lprcwgs1ynn09grscnghcc20c3f0mwckj6lr";
        };
      };
    };
    "phar-io/manifest" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phar-io-manifest-7761fcacf03b4d4f16e7ccb606d4879ca431fcf4";
        src = fetchurl {
          url = https://api.github.com/repos/phar-io/manifest/zipball/7761fcacf03b4d4f16e7ccb606d4879ca431fcf4;
          sha256 = "1n59a0gnk43ryl54bc37hlsi1spvi8280bq64zddxrpagyjyp15a";
        };
      };
    };
    "phar-io/version" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phar-io-version-45a2ec53a73c70ce41d55cedef9063630abaf1b6";
        src = fetchurl {
          url = https://api.github.com/repos/phar-io/version/zipball/45a2ec53a73c70ce41d55cedef9063630abaf1b6;
          sha256 = "0syr7v2b3lsdavfa22z55sdkg5awc3jlzpgn0qk0d3vf6x96hvzp";
        };
      };
    };
    "phpdocumentor/reflection-common" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpdocumentor-reflection-common-1d01c49d4ed62f25aa84a747ad35d5a16924662b";
        src = fetchurl {
          url = https://api.github.com/repos/phpDocumentor/ReflectionCommon/zipball/1d01c49d4ed62f25aa84a747ad35d5a16924662b;
          sha256 = "1wx720a17i24471jf8z499dnkijzb4b8xra11kvw9g9hhzfadz1r";
        };
      };
    };
    "phpdocumentor/reflection-docblock" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpdocumentor-reflection-docblock-069a785b2141f5bcf49f3e353548dc1cce6df556";
        src = fetchurl {
          url = https://api.github.com/repos/phpDocumentor/ReflectionDocBlock/zipball/069a785b2141f5bcf49f3e353548dc1cce6df556;
          sha256 = "0qid63bsfjmc3ka54f1ijl4a5zqwf7jmackjyjmbw3gxdnbi69il";
        };
      };
    };
    "phpdocumentor/type-resolver" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpdocumentor-type-resolver-6a467b8989322d92aa1c8bf2bebcc6e5c2ba55c0";
        src = fetchurl {
          url = https://api.github.com/repos/phpDocumentor/TypeResolver/zipball/6a467b8989322d92aa1c8bf2bebcc6e5c2ba55c0;
          sha256 = "01g6mihq5wd1396njjb7ibcdfgk26ix1kmbjb6dlshzav0k3983h";
        };
      };
    };
    "phpspec/prophecy" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpspec-prophecy-8ce87516be71aae9b956f81906aaf0338e0d8a2d";
        src = fetchurl {
          url = https://api.github.com/repos/phpspec/prophecy/zipball/8ce87516be71aae9b956f81906aaf0338e0d8a2d;
          sha256 = "10cfgk3bm05ikav74809l7548w892118y7ai467ncp2ijmy1gr3v";
        };
      };
    };
    "phpstan/phpdoc-parser" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpstan-phpdoc-parser-98a088b17966bdf6ee25c8a4b634df313d8aa531";
        src = fetchurl {
          url = https://api.github.com/repos/phpstan/phpdoc-parser/zipball/98a088b17966bdf6ee25c8a4b634df313d8aa531;
          sha256 = "0qk526jr6j0b84wsik0sar5vsvfy3qgg2kw1m2cmizw88x11axgm";
        };
      };
    };
    "phpunit/php-code-coverage" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpunit-php-code-coverage-f1884187926fbb755a9aaf0b3836ad3165b478bf";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/php-code-coverage/zipball/f1884187926fbb755a9aaf0b3836ad3165b478bf;
          sha256 = "1vnahnjxshyvvx1j7dsqcw1wrmwkgp5zjd2yv9bzi1lkh1lkisqm";
        };
      };
    };
    "phpunit/php-file-iterator" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpunit-php-file-iterator-050bedf145a257b1ff02746c31894800e5122946";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/php-file-iterator/zipball/050bedf145a257b1ff02746c31894800e5122946;
          sha256 = "0b5y1dmksnzqps694h1bhw6r6w1cqrf3vhw2k00adjdawjzaa00j";
        };
      };
    };
    "phpunit/php-text-template" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpunit-php-text-template-31f8b717e51d9a2afca6c9f046f5d69fc27c8686";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/php-text-template/zipball/31f8b717e51d9a2afca6c9f046f5d69fc27c8686;
          sha256 = "1y03m38qqvsbvyakd72v4dram81dw3swyn5jpss153i5nmqr4p76";
        };
      };
    };
    "phpunit/php-timer" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpunit-php-timer-1038454804406b0b5f5f520358e78c1c2f71501e";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/php-timer/zipball/1038454804406b0b5f5f520358e78c1c2f71501e;
          sha256 = "0vmaca44sz6n9avd8awzk28wq5w4qnvjfl24q89611pdnkl4j8d8";
        };
      };
    };
    "phpunit/php-token-stream" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpunit-php-token-stream-995192df77f63a59e47f025390d2d1fdf8f425ff";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/php-token-stream/zipball/995192df77f63a59e47f025390d2d1fdf8f425ff;
          sha256 = "1hl3n6kad0n4vls1sy0qgrqw3caxm2z50adi3nhzx0asdsx85nfn";
        };
      };
    };
    "phpunit/phpunit" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpunit-phpunit-f5c8a5dd5e7e8d68d7562bfb48d47287d33937d6";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/phpunit/zipball/f5c8a5dd5e7e8d68d7562bfb48d47287d33937d6;
          sha256 = "1grsddcf7ba53wv9k2yzshdx4a8nsb66xdd200zcs718fidyydcv";
        };
      };
    };
    "psy/psysh" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psy-psysh-a8aec1b2981ab66882a01cce36a49b6317dc3560";
        src = fetchurl {
          url = https://api.github.com/repos/bobthecow/psysh/zipball/a8aec1b2981ab66882a01cce36a49b6317dc3560;
          sha256 = "1bc58x39hyb2r2h54dmm4d7k29iwkawj3jk7v6xbz7zc3ghnh5vd";
        };
      };
    };
    "sebastian/code-unit-reverse-lookup" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-code-unit-reverse-lookup-4419fcdb5eabb9caa61a27c7a1db532a6b55dd18";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/code-unit-reverse-lookup/zipball/4419fcdb5eabb9caa61a27c7a1db532a6b55dd18;
          sha256 = "0n0bygv2vx1l7af8szbcbn5bpr4axrgvkzd0m348m8ckmk8akvs8";
        };
      };
    };
    "sebastian/comparator" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-comparator-5de4fc177adf9bce8df98d8d141a7559d7ccf6da";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/comparator/zipball/5de4fc177adf9bce8df98d8d141a7559d7ccf6da;
          sha256 = "1kf0w51kj4whak8cdmplhj3vsvpj71bl0k3dyz197vvh83ghvl2i";
        };
      };
    };
    "sebastian/diff" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-diff-720fcc7e9b5cf384ea68d9d930d480907a0c1a29";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/diff/zipball/720fcc7e9b5cf384ea68d9d930d480907a0c1a29;
          sha256 = "0i81kz91grz5vzifw114kg6dcfh150019zid7j99j2y5w7s1fqq2";
        };
      };
    };
    "sebastian/environment" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-environment-464c90d7bdf5ad4e8a6aea15c091fec0603d4368";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/environment/zipball/464c90d7bdf5ad4e8a6aea15c091fec0603d4368;
          sha256 = "1dpd2x9yr02c4wf5icvgaw70i8bzxcmqab9plxjv00d712h73z08";
        };
      };
    };
    "sebastian/exporter" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-exporter-68609e1261d215ea5b21b7987539cbfbe156ec3e";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/exporter/zipball/68609e1261d215ea5b21b7987539cbfbe156ec3e;
          sha256 = "0i8a502xqf2ripwbr5rgw9z49z9as7fjibh7sr171q0h4yrrr02j";
        };
      };
    };
    "sebastian/global-state" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-global-state-edf8a461cf1d4005f19fb0b6b8b95a9f7fa0adc4";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/global-state/zipball/edf8a461cf1d4005f19fb0b6b8b95a9f7fa0adc4;
          sha256 = "01wba1xd5qvcx1j0vldlyixjlbyvnxnm2vx1i2y1wqaldn8d1wy2";
        };
      };
    };
    "sebastian/object-enumerator" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-object-enumerator-7cfd9e65d11ffb5af41198476395774d4c8a84c5";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/object-enumerator/zipball/7cfd9e65d11ffb5af41198476395774d4c8a84c5;
          sha256 = "00z5wzh19z1drnh52d27gflqm7dyisp96c29zyxrgsdccv1wss3m";
        };
      };
    };
    "sebastian/object-reflector" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-object-reflector-773f97c67f28de00d397be301821b06708fca0be";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/object-reflector/zipball/773f97c67f28de00d397be301821b06708fca0be;
          sha256 = "1rq5wwf7smdbbz3mj46hmjc643bbsm2b6cnnggmawyls479qmxlk";
        };
      };
    };
    "sebastian/recursion-context" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-recursion-context-5b0cd723502bac3b006cbf3dbf7a1e3fcefe4fa8";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/recursion-context/zipball/5b0cd723502bac3b006cbf3dbf7a1e3fcefe4fa8;
          sha256 = "0p4j54bxriciw67g7l8zy1wa472di0b8f8mxs4fdvm37asz2s6vd";
        };
      };
    };
    "sebastian/resource-operations" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-resource-operations-4d7a795d35b889bf80a0cc04e08d77cedfa917a9";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/resource-operations/zipball/4d7a795d35b889bf80a0cc04e08d77cedfa917a9;
          sha256 = "0prnq9hvg1bi3nkms21wl0fr0f28p0mhp5w802sqb05v9k0qnb41";
        };
      };
    };
    "sebastian/type" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-type-3aaaa15fa71d27650d62a948be022fe3b48541a3";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/type/zipball/3aaaa15fa71d27650d62a948be022fe3b48541a3;
          sha256 = "034sc9qiag074lsi990nfwzm9jnw9fysdwsd906146snqrxcqsk6";
        };
      };
    };
    "sebastian/version" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-version-99732be0ddb3361e16ad77b68ba41efc8e979019";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/version/zipball/99732be0ddb3361e16ad77b68ba41efc8e979019;
          sha256 = "0wrw5hskz2hg5aph9r1fhnngfrcvhws1pgs0lfrwindy066z6fj7";
        };
      };
    };
    "seld/jsonlint" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "seld-jsonlint-9ad6ce79c342fbd44df10ea95511a1b24dee5b57";
        src = fetchurl {
          url = https://api.github.com/repos/Seldaek/jsonlint/zipball/9ad6ce79c342fbd44df10ea95511a1b24dee5b57;
          sha256 = "1ywni3i7zi2bsh7qpbf710qixd3jhpvz4l1bavrw9vnkxl38qj8p";
        };
      };
    };
    "seld/phar-utils" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "seld-phar-utils-8674b1d84ffb47cc59a101f5d5a3b61e87d23796";
        src = fetchurl {
          url = https://api.github.com/repos/Seldaek/phar-utils/zipball/8674b1d84ffb47cc59a101f5d5a3b61e87d23796;
          sha256 = "14q8b6c7k1172nml5v88z244xy0vqbk6dhc68j2iv0l9yww2722d";
        };
      };
    };
    "slevomat/coding-standard" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "slevomat-coding-standard-696dcca217d0c9da2c40d02731526c1e25b65346";
        src = fetchurl {
          url = https://api.github.com/repos/slevomat/coding-standard/zipball/696dcca217d0c9da2c40d02731526c1e25b65346;
          sha256 = "017mb08j9c6657nv9mkgy09qpy9540dxsvximgm1j1r1dzxnyj3j";
        };
      };
    };
    "squizlabs/php_codesniffer" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "squizlabs-php_codesniffer-9d583721a7157ee997f235f327de038e7ea6dac4";
        src = fetchurl {
          url = https://api.github.com/repos/squizlabs/PHP_CodeSniffer/zipball/9d583721a7157ee997f235f327de038e7ea6dac4;
          sha256 = "06nmavz27qbnrbhkzbzbm0dc7iir7qwbp7i1dsv3s9490wxxqszm";
        };
      };
    };
    "symfony/finder" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-finder-e70eb5a69c2ff61ea135a13d2266e8914a67b3a0";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/finder/zipball/e70eb5a69c2ff61ea135a13d2266e8914a67b3a0;
          sha256 = "05ksivgwyzynq6kyq96nxz3bpwsf87w7lgyj3c24ffkgqhnbr9vi";
        };
      };
    };
    "symfony/process" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-process-f00872c3f6804150d6a0f73b4151daab96248101";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/process/zipball/f00872c3f6804150d6a0f73b4151daab96248101;
          sha256 = "0vj79sqwydx6jdxwlf06jrz9ydqh69hl3x0gv9ni14z2izvf3fl9";
        };
      };
    };
    "symfony/var-dumper" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-var-dumper-4e13f3fcefb1fcaaa5efb5403581406f4e840b9a";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/var-dumper/zipball/4e13f3fcefb1fcaaa5efb5403581406f4e840b9a;
          sha256 = "130ixypl8ckswj2il8qdvqv42mywzb3yd9ara4p29spwvn5ip4ih";
        };
      };
    };
    "theseer/tokenizer" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "theseer-tokenizer-75a63c33a8577608444246075ea0af0d052e452a";
        src = fetchurl {
          url = https://api.github.com/repos/theseer/tokenizer/zipball/75a63c33a8577608444246075ea0af0d052e452a;
          sha256 = "1cj1lb99hccsnwkq0i01mlcldmy1kxwcksfvgq6vfx8mgz3iicij";
        };
      };
    };
    "twig/markdown-extra" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "twig-markdown-extra-1fe798d559665b64bda4b08eda10793427d7e3bc";
        src = fetchurl {
          url = https://api.github.com/repos/twigphp/markdown-extra/zipball/1fe798d559665b64bda4b08eda10793427d7e3bc;
          sha256 = "080r9jc1ra5n9xhmlmkpqf8mcq3jkmfz7fhf71pdjxai03r6m3sw";
        };
      };
    };
    "twig/twig" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "twig-twig-b02fa41f3783a2616eccef7b92fbc2343ffed737";
        src = fetchurl {
          url = https://api.github.com/repos/twigphp/Twig/zipball/b02fa41f3783a2616eccef7b92fbc2343ffed737;
          sha256 = "07h489lp851rdc8lacijv6j8z1vhdq7rsqqsyndsp1r07ghw8aj8";
        };
      };
    };
  };
in
composerEnv.buildPackage {
  inherit packages devPackages noDev;
  name = "cakephp-app";
  src = ./.;
  executable = false;
  symlinkDependencies = false;
  meta = {
    homepage = https://cakephp.org;
    license = "MIT";
  };
}