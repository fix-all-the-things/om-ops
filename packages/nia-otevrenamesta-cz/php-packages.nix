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
    "cakephp/cakephp" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "cakephp-cakephp-1915d78f659d374224b2be0a5ad7822d96fb8366";
        src = fetchurl {
          url = https://api.github.com/repos/cakephp/cakephp/zipball/1915d78f659d374224b2be0a5ad7822d96fb8366;
          sha256 = "1s0nvz9qajcpbx5apb1bzcz4zj624cvpfszxjiw0fc3a5j4j89wf";
        };
      };
    };
    "cakephp/chronos" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "cakephp-chronos-ba2bab98849e7bf29b02dd634ada49ab36472959";
        src = fetchurl {
          url = https://api.github.com/repos/cakephp/chronos/zipball/ba2bab98849e7bf29b02dd634ada49ab36472959;
          sha256 = "0l0jqw5j6c8k89cysfgcnl3vi7n2aag9lq9sm52cqszwfkihbj22";
        };
      };
    };
    "cakephp/migrations" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "cakephp-migrations-7fa4f1f8a4cd90df59cd8e3a46958c822abe457e";
        src = fetchurl {
          url = https://api.github.com/repos/cakephp/migrations/zipball/7fa4f1f8a4cd90df59cd8e3a46958c822abe457e;
          sha256 = "0izc90vki9gdhgwmszvwkknkdc4sjywvz4gsdvgf69ric24cfm1g";
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
    "mobiledetect/mobiledetectlib" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "mobiledetect-mobiledetectlib-9841e3c46f5bd0739b53aed8ac677fa712943df7";
        src = fetchurl {
          url = https://api.github.com/repos/serbanghita/Mobile-Detect/zipball/9841e3c46f5bd0739b53aed8ac677fa712943df7;
          sha256 = "02r9n3kj5rzkakj1fkrkhgpram9xyq2vl9paxza4k117fj51azcw";
        };
      };
    };
    "psr/container" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-container-8622567409010282b7aeebe4bb841fe98b58dcaf";
        src = fetchurl {
          url = https://api.github.com/repos/php-fig/container/zipball/8622567409010282b7aeebe4bb841fe98b58dcaf;
          sha256 = "0qfvyfp3mli776kb9zda5cpc8cazj3prk0bg0gm254kwxyfkfrwn";
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
        name = "robmorgan-phinx-3cdde73e0c33c410e076108b3e1603fabb5b330d";
        src = fetchurl {
          url = https://api.github.com/repos/cakephp/phinx/zipball/3cdde73e0c33c410e076108b3e1603fabb5b330d;
          sha256 = "18gz724yfhvj4c1124mcrrmgjz2srsf66zdk1pzxx8rsg8c36635";
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
        name = "simplesamlphp-saml2-3bc980feb96ecf57898014c1bb5b26f0859f1316";
        src = fetchurl {
          url = https://api.github.com/repos/simplesamlphp/saml2/zipball/3bc980feb96ecf57898014c1bb5b26f0859f1316;
          sha256 = "1h2s9rvfbkdkiphjhp1ds5zvapzg7amhhjswka8l13xxnranzsdl";
        };
      };
    };
    "symfony/config" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-config-212d54675bf203ff8aef7d8cee8eecfb72f4a263";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/config/zipball/212d54675bf203ff8aef7d8cee8eecfb72f4a263;
          sha256 = "16n57k8x3cdv84vlw1njlbhc8g6f24j976aic7nyxaf87c8rgwx3";
        };
      };
    };
    "symfony/console" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-console-35f039df40a3b335ebf310f244cb242b3a83ac8d";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/console/zipball/35f039df40a3b335ebf310f244cb242b3a83ac8d;
          sha256 = "11raz6qv3b88h4i37z7i37rc3fxxmchy7n2fm7j4dk65kva07m5s";
        };
      };
    };
    "symfony/deprecation-contracts" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-deprecation-contracts-5f38c8804a9e97d23e0c8d63341088cd8a22d627";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/deprecation-contracts/zipball/5f38c8804a9e97d23e0c8d63341088cd8a22d627;
          sha256 = "11k6a8v9b6p0j788fgykq6s55baba29lg37fwvmn4igxxkfwmbp3";
        };
      };
    };
    "symfony/filesystem" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-filesystem-8c86a82f51658188119e62cff0a050a12d09836f";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/filesystem/zipball/8c86a82f51658188119e62cff0a050a12d09836f;
          sha256 = "1xghwc7zz6659p572anx68f7n8x9lhair0c4fh5a3rf748arlby4";
        };
      };
    };
    "symfony/polyfill-ctype" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-ctype-c6c942b1ac76c82448322025e084cadc56048b4e";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/polyfill-ctype/zipball/c6c942b1ac76c82448322025e084cadc56048b4e;
          sha256 = "0jpk859wx74vm03q5s9z25f4ak2138p2x5q3b587wvy8rq2m4pbd";
        };
      };
    };
    "symfony/polyfill-intl-grapheme" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-intl-grapheme-5601e09b69f26c1828b13b6bb87cb07cddba3170";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/polyfill-intl-grapheme/zipball/5601e09b69f26c1828b13b6bb87cb07cddba3170;
          sha256 = "1k3xk8iknyjaslzvhdl1am3jlyndvb6pw0509znmwgvc2jhkb4jr";
        };
      };
    };
    "symfony/polyfill-intl-normalizer" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-intl-normalizer-43a0283138253ed1d48d352ab6d0bdb3f809f248";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/polyfill-intl-normalizer/zipball/43a0283138253ed1d48d352ab6d0bdb3f809f248;
          sha256 = "04irkl6aks8zyfy17ni164060liihfyraqm1fmpjbs5hq0b14sc9";
        };
      };
    };
    "symfony/polyfill-mbstring" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-mbstring-5232de97ee3b75b0360528dae24e73db49566ab1";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/polyfill-mbstring/zipball/5232de97ee3b75b0360528dae24e73db49566ab1;
          sha256 = "1mm670fxj2x72a9mbkyzs3yifpp6glravq2ss438bags1xf6psz8";
        };
      };
    };
    "symfony/polyfill-php73" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-php73-a678b42e92f86eca04b7fa4c0f6f19d097fb69e2";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/polyfill-php73/zipball/a678b42e92f86eca04b7fa4c0f6f19d097fb69e2;
          sha256 = "10rq2x2q9hsdzskrz0aml5qcji27ypxam324044fi24nl60fyzg0";
        };
      };
    };
    "symfony/polyfill-php80" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-php80-dc3063ba22c2a1fd2f45ed856374d79114998f91";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/polyfill-php80/zipball/dc3063ba22c2a1fd2f45ed856374d79114998f91;
          sha256 = "1mhfjibk7mqyzlqpz6jjpxpd93fnfw0nik140x3mq1d2blg5cbvd";
        };
      };
    };
    "symfony/service-contracts" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-service-contracts-f040a30e04b57fbcc9c6cbcf4dbaa96bd318b9bb";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/service-contracts/zipball/f040a30e04b57fbcc9c6cbcf4dbaa96bd318b9bb;
          sha256 = "1i573rmajc33a9nrgwgc4k3svg29yp9xv17gp133rd1i705hwv1y";
        };
      };
    };
    "symfony/string" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-string-ad0bd91bce2054103f5eaa18ebeba8d3bc2a0572";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/string/zipball/ad0bd91bce2054103f5eaa18ebeba8d3bc2a0572;
          sha256 = "03snf86rk31jrcvaz9s1792w260iyvjchpl6ky6wshy3jkj7lqcs";
        };
      };
    };
    "symfony/yaml" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-yaml-298a08ddda623485208506fcee08817807a251dd";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/yaml/zipball/298a08ddda623485208506fcee08817807a251dd;
          sha256 = "11mm7aj5k0d54g7b0maqri2rjhil06ih50yfxplm9p4cj5lz4ny7";
        };
      };
    };
    "webmozart/assert" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "webmozart-assert-6964c76c7804814a842473e0c8fd15bab0f18e25";
        src = fetchurl {
          url = https://api.github.com/repos/webmozarts/assert/zipball/6964c76c7804814a842473e0c8fd15bab0f18e25;
          sha256 = "17xqhb2wkwr7cgbl4xdjf7g1vkal17y79rpp6xjpf1xgl5vypc64";
        };
      };
    };
    "zendframework/zend-diactoros" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "zendframework-zend-diactoros-a85e67b86e9b8520d07e6415fcbcb8391b44a75b";
        src = fetchurl {
          url = https://api.github.com/repos/zendframework/zend-diactoros/zipball/a85e67b86e9b8520d07e6415fcbcb8391b44a75b;
          sha256 = "0y9syp9zmb5awjiqmdvvyz5yh743mcqn9bgy1ix2x2lasr730pm8";
        };
      };
    };
  };
  devPackages = {
    "ajgl/breakpoint-twig-extension" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "ajgl-breakpoint-twig-extension-9875feea0ac4bc3c9f308c62bae4727669d6052a";
        src = fetchurl {
          url = https://api.github.com/repos/ajgarlag/AjglBreakpointTwigExtension/zipball/9875feea0ac4bc3c9f308c62bae4727669d6052a;
          sha256 = "0q2fmyy5hppsqr5gd9cw5kjc3rcpvg6zq4nkw11s8gw7m0w2cccl";
        };
      };
    };
    "aptoma/twig-markdown" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "aptoma-twig-markdown-64a9c5c7418c08faf91c4410b34bdb65fb25c23d";
        src = fetchurl {
          url = https://api.github.com/repos/aptoma/twig-markdown/zipball/64a9c5c7418c08faf91c4410b34bdb65fb25c23d;
          sha256 = "02pwl81nfinlaq8ijyd1jd9wxisy0sjb2dldd1cwxgqhg24wiqa4";
        };
      };
    };
    "asm89/twig-cache-extension" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "asm89-twig-cache-extension-13787226956ec766f4770722082288097aebaaf3";
        src = fetchurl {
          url = https://api.github.com/repos/asm89/twig-cache-extension/zipball/13787226956ec766f4770722082288097aebaaf3;
          sha256 = "1xgvr9hsi3w07h5flh5brzlv4807annp4xhldyxc58q20xl0k9m1";
        };
      };
    };
    "cakephp/bake" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "cakephp-bake-33e8ee8419ba36c13fa4074c208c93352b5530cf";
        src = fetchurl {
          url = https://api.github.com/repos/cakephp/bake/zipball/33e8ee8419ba36c13fa4074c208c93352b5530cf;
          sha256 = "133i9nmi5xh71rdxnvfqkpfq4pmrgqaa3s4ks285s8dg14qkg96m";
        };
      };
    };
    "cakephp/cakephp-codesniffer" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "cakephp-cakephp-codesniffer-7998a191e787fd5b68cb635d7050cb0d7b55e1a1";
        src = fetchurl {
          url = https://api.github.com/repos/cakephp/cakephp-codesniffer/zipball/7998a191e787fd5b68cb635d7050cb0d7b55e1a1;
          sha256 = "18f708659xnkw0xjl2msx91m2pf9i80fkga9cwg17p7b863bym90";
        };
      };
    };
    "cakephp/debug_kit" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "cakephp-debug_kit-5bec3c49a2b8d9bd12655f2ec35e52ec90befe17";
        src = fetchurl {
          url = https://api.github.com/repos/cakephp/debug_kit/zipball/5bec3c49a2b8d9bd12655f2ec35e52ec90befe17;
          sha256 = "1kzxxhy6cc6kmcw57my77sgkja2p86xaqjb1m8lvxcz5k8bfh9nn";
        };
      };
    };
    "composer/ca-bundle" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "composer-ca-bundle-78a0e288fdcebf92aa2318a8d3656168da6ac1a5";
        src = fetchurl {
          url = https://api.github.com/repos/composer/ca-bundle/zipball/78a0e288fdcebf92aa2318a8d3656168da6ac1a5;
          sha256 = "0fqx8cn7b0mrc7mvp8mdrl4g0y65br6wrbhizp4mk1qc7rf0xrvk";
        };
      };
    };
    "composer/composer" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "composer-composer-28c9dfbe2351635961f670773e8d7b17bc5eda25";
        src = fetchurl {
          url = https://api.github.com/repos/composer/composer/zipball/28c9dfbe2351635961f670773e8d7b17bc5eda25;
          sha256 = "15l6xzl1mis5a29j9rsqvmgx3j9cwkg737kk5vbhxhlpy9ir5nrm";
        };
      };
    };
    "composer/semver" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "composer-semver-647490bbcaf7fc4891c58f47b825eb99d19c377a";
        src = fetchurl {
          url = https://api.github.com/repos/composer/semver/zipball/647490bbcaf7fc4891c58f47b825eb99d19c377a;
          sha256 = "16dx37b0b3qnla05h8l49hyg6khibd52i42lwqfyd91iysdpgz5r";
        };
      };
    };
    "composer/spdx-licenses" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "composer-spdx-licenses-de30328a7af8680efdc03e396aad24befd513200";
        src = fetchurl {
          url = https://api.github.com/repos/composer/spdx-licenses/zipball/de30328a7af8680efdc03e396aad24befd513200;
          sha256 = "0yamrbw2br8v3775pmlmvlqaylgvrd51ar274963cpkhxv1a7xfg";
        };
      };
    };
    "composer/xdebug-handler" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "composer-xdebug-handler-f27e06cd9675801df441b3656569b328e04aa37c";
        src = fetchurl {
          url = https://api.github.com/repos/composer/xdebug-handler/zipball/f27e06cd9675801df441b3656569b328e04aa37c;
          sha256 = "0db49yf7zcf4q57ba48n10cyrdjf7s598321m69dkb4dph0yc5qh";
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
        name = "jasny-twig-extensions-30bdf3a3903c021544f36332c9d5d4d563527da4";
        src = fetchurl {
          url = https://api.github.com/repos/jasny/twig-extensions/zipball/30bdf3a3903c021544f36332c9d5d4d563527da4;
          sha256 = "067lkrgbgdsj92b2i1snbqlr5gwk7c024n95ydhmyx19w62lxkn0";
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
        name = "myclabs-deep-copy-776f831124e9c62e1a2c601ecc52e776d8bb7220";
        src = fetchurl {
          url = https://api.github.com/repos/myclabs/DeepCopy/zipball/776f831124e9c62e1a2c601ecc52e776d8bb7220;
          sha256 = "181f3fsxs6s2wyy4y7qfk08qmlbvz1wn3mn3lqy42grsb8g8ym0k";
        };
      };
    };
    "nikic/php-parser" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "nikic-php-parser-c6d052fc58cb876152f89f532b95a8d7907e7f0e";
        src = fetchurl {
          url = https://api.github.com/repos/nikic/PHP-Parser/zipball/c6d052fc58cb876152f89f532b95a8d7907e7f0e;
          sha256 = "1392bj45myazpphic05jxqwlyify72s3qf5vspd991rk5a2p60pw";
        };
      };
    };
    "phar-io/manifest" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phar-io-manifest-2df402786ab5368a0169091f61a7c1e0eb6852d0";
        src = fetchurl {
          url = https://api.github.com/repos/phar-io/manifest/zipball/2df402786ab5368a0169091f61a7c1e0eb6852d0;
          sha256 = "0l6n4z4mx84xbc0bjjyf0gxn3c1x2vq9aals46yj98wywp4sj7hx";
        };
      };
    };
    "phar-io/version" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phar-io-version-a70c0ced4be299a63d32fa96d9281d03e94041df";
        src = fetchurl {
          url = https://api.github.com/repos/phar-io/version/zipball/a70c0ced4be299a63d32fa96d9281d03e94041df;
          sha256 = "07arsyb38pczdzvmnz785yf34rza6znv3z6db6y9d1yfyfrx6dix";
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
        name = "phpspec-prophecy-451c3cd1418cf640de218914901e51b064abb093";
        src = fetchurl {
          url = https://api.github.com/repos/phpspec/prophecy/zipball/451c3cd1418cf640de218914901e51b064abb093;
          sha256 = "0z6wh1lygafcfw36r9abrg7fgq9r3v1233v38g4wbqy3jf7xfrzb";
        };
      };
    };
    "phpunit/php-code-coverage" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpunit-php-code-coverage-c89677919c5dd6d3b3852f230a663118762218ac";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/php-code-coverage/zipball/c89677919c5dd6d3b3852f230a663118762218ac;
          sha256 = "1rcph2077zgnsib7bgb9d7ik64xyzrddzrx23im8829qdfk51s4a";
        };
      };
    };
    "phpunit/php-file-iterator" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpunit-php-file-iterator-730b01bc3e867237eaac355e06a36b85dd93a8b4";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/php-file-iterator/zipball/730b01bc3e867237eaac355e06a36b85dd93a8b4;
          sha256 = "0kbg907g9hrx7pv8v0wnf4ifqywdgvigq6y6z00lyhgd0b8is060";
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
        name = "phpunit-php-timer-3dcf38ca72b158baf0bc245e9184d3fdffa9c46f";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/php-timer/zipball/3dcf38ca72b158baf0bc245e9184d3fdffa9c46f;
          sha256 = "1j04r0hqzrv6m1jk5nb92k2nnana72nscqpfk3rgv3fzrrv69ljr";
        };
      };
    };
    "phpunit/php-token-stream" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpunit-php-token-stream-791198a2c6254db10131eecfe8c06670700904db";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/php-token-stream/zipball/791198a2c6254db10131eecfe8c06670700904db;
          sha256 = "03i9259r9mjib2ipdkavkq6di66mrsga6kzc7rq5pglrhfiiil4s";
        };
      };
    };
    "phpunit/phpunit" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpunit-phpunit-bac23fe7ff13dbdb461481f706f0e9fe746334b7";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/phpunit/zipball/bac23fe7ff13dbdb461481f706f0e9fe746334b7;
          sha256 = "1vhjfsh9jyk6dvihxzzh2vg2lw54ja1g4649vgd7fp9q4jwh1czq";
        };
      };
    };
    "phpunit/phpunit-mock-objects" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpunit-phpunit-mock-objects-cd1cf05c553ecfec36b170070573e540b67d3f1f";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/phpunit-mock-objects/zipball/cd1cf05c553ecfec36b170070573e540b67d3f1f;
          sha256 = "0b987ra0ayz2pk78c9w2dpg4kzy2yys065p6ha6gxq2sq7s84yhk";
        };
      };
    };
    "psy/psysh" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psy-psysh-e4573f47750dd6c92dca5aee543fa77513cbd8d3";
        src = fetchurl {
          url = https://api.github.com/repos/bobthecow/psysh/zipball/e4573f47750dd6c92dca5aee543fa77513cbd8d3;
          sha256 = "1pzw57gild4h66nfkvlcbz43ralypcjr9dgvwj6rs2gl72rfiwnk";
        };
      };
    };
    "sebastian/code-unit-reverse-lookup" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-code-unit-reverse-lookup-1de8cd5c010cb153fcd68b8d0f64606f523f7619";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/code-unit-reverse-lookup/zipball/1de8cd5c010cb153fcd68b8d0f64606f523f7619;
          sha256 = "17690sqmhdabhvgalrf2ypbx4nll4g4cwdbi51w5p6w9n8cxch1a";
        };
      };
    };
    "sebastian/comparator" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-comparator-34369daee48eafb2651bea869b4b15d75ccc35f9";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/comparator/zipball/34369daee48eafb2651bea869b4b15d75ccc35f9;
          sha256 = "1l4kyl916gjqg2dj5xyqh951khx5zgi14bslw0319pmk1a2mzlx8";
        };
      };
    };
    "sebastian/diff" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-diff-347c1d8b49c5c3ee30c7040ea6fc446790e6bddd";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/diff/zipball/347c1d8b49c5c3ee30c7040ea6fc446790e6bddd;
          sha256 = "0bca0q624zjwm555irbb2vv0y6dy0plbh01nlp74bxzmd3lra88a";
        };
      };
    };
    "sebastian/environment" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-environment-cd0871b3975fb7fc44d11314fd1ee20925fce4f5";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/environment/zipball/cd0871b3975fb7fc44d11314fd1ee20925fce4f5;
          sha256 = "1b2jgfi67xmspijyzrgn23cycdw0rkfx5q3llhvz6gkwyxgmqxnm";
        };
      };
    };
    "sebastian/exporter" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-exporter-6b853149eab67d4da22291d36f5b0631c0fd856e";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/exporter/zipball/6b853149eab67d4da22291d36f5b0631c0fd856e;
          sha256 = "1s0n1vbds3yj8mg98vmykxz61mgsbqd28bv63cw8fkvnmgb0s5x7";
        };
      };
    };
    "sebastian/global-state" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-global-state-e8ba02eed7bbbb9e59e43dedd3dddeff4a56b0c4";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/global-state/zipball/e8ba02eed7bbbb9e59e43dedd3dddeff4a56b0c4;
          sha256 = "1489kfvz0gg6jprakr43mjkminlhpsimcdrrxkmsm6mmhahbgjnf";
        };
      };
    };
    "sebastian/object-enumerator" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-object-enumerator-e67f6d32ebd0c749cf9d1dbd9f226c727043cdf2";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/object-enumerator/zipball/e67f6d32ebd0c749cf9d1dbd9f226c727043cdf2;
          sha256 = "10g778j02h3kywvz4ldhin64zbypxpl0l39rm2ycsr7iin8q904w";
        };
      };
    };
    "sebastian/object-reflector" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-object-reflector-9b8772b9cbd456ab45d4a598d2dd1a1bced6363d";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/object-reflector/zipball/9b8772b9cbd456ab45d4a598d2dd1a1bced6363d;
          sha256 = "010g9mkf3s1hcbwn1wvd9s72xcyjzrb6csx472xs69yln1mr11z8";
        };
      };
    };
    "sebastian/recursion-context" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-recursion-context-367dcba38d6e1977be014dc4b22f47a484dac7fb";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/recursion-context/zipball/367dcba38d6e1977be014dc4b22f47a484dac7fb;
          sha256 = "1zpq0qk2mgwnbyhjnj05dz2n2v8hvj2g4jy68fd5klxxkdr92ps7";
        };
      };
    };
    "sebastian/resource-operations" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-resource-operations-ce990bb21759f94aeafd30209e8cfcdfa8bc3f52";
        src = fetchurl {
          url = https://api.github.com/repos/sebastianbergmann/resource-operations/zipball/ce990bb21759f94aeafd30209e8cfcdfa8bc3f52;
          sha256 = "19jfc8xzkyycglrcz85sv3ajmxvxwkw4sid5l4i8g6wmz9npbsxl";
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
    "squizlabs/php_codesniffer" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "squizlabs-php_codesniffer-ffced0d2c8fa8e6cdc4d695a743271fab6c38625";
        src = fetchurl {
          url = https://api.github.com/repos/squizlabs/PHP_CodeSniffer/zipball/ffced0d2c8fa8e6cdc4d695a743271fab6c38625;
          sha256 = "1cndvz85ii2cl47lbfkmxr4xw03n7y70l6jc8sdh6bhz4axvk03z";
        };
      };
    };
    "symfony/finder" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-finder-0d639a0943822626290d169965804f79400e6a04";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/finder/zipball/0d639a0943822626290d169965804f79400e6a04;
          sha256 = "17v5pnl95di1ks4gm04yr7p2jjzbisiabv3yilhw7wsd45a9rz7q";
        };
      };
    };
    "symfony/process" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-process-313a38f09c77fbcdc1d223e57d368cea76a2fd2f";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/process/zipball/313a38f09c77fbcdc1d223e57d368cea76a2fd2f;
          sha256 = "101q7k39cyhpk8i5mrf62k62wk5sm1057s3pwzf2awgyj7nk7hm8";
        };
      };
    };
    "symfony/var-dumper" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-var-dumper-89412a68ea2e675b4e44f260a5666729f77f668e";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/var-dumper/zipball/89412a68ea2e675b4e44f260a5666729f77f668e;
          sha256 = "1x9qlv96rzz2xvk0rsrvra3hwls3nwg366l8l8swahnww9nwym70";
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
    "twig/twig" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "twig-twig-138c493c5b8ee7cff3821f80b8896d371366b5fe";
        src = fetchurl {
          url = https://api.github.com/repos/twigphp/Twig/zipball/138c493c5b8ee7cff3821f80b8896d371366b5fe;
          sha256 = "0p7r8mc3grwi6lmywpfymnja6m5abjk4vpcs56bg8r5mcizc1c87";
        };
      };
    };
    "umpirsky/twig-php-function" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "umpirsky-twig-php-function-53b4b1eb0c5eacbd7d66c504b7d809c79b4bedbc";
        src = fetchurl {
          url = https://api.github.com/repos/umpirsky/twig-php-function/zipball/53b4b1eb0c5eacbd7d66c504b7d809c79b4bedbc;
          sha256 = "1g67xb8ci20wy023wi2q87sr9msv2jvkfpliqvv0ikjgjy315gzy";
        };
      };
    };
    "wyrihaximus/twig-view" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "wyrihaximus-twig-view-463e1a6ed493d4fe99eaeaaf39d80172b51fc0fb";
        src = fetchurl {
          url = https://api.github.com/repos/cakephp/legacy-twig-view/zipball/463e1a6ed493d4fe99eaeaaf39d80172b51fc0fb;
          sha256 = "0z7rxkkqcz27b6wk1l874fcy8gk24kjjmzhpzjagcfrm9c1f7az7";
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