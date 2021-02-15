{composerEnv, fetchurl, fetchgit ? null, fetchhg ? null, fetchsvn ? null, noDev ? false}:

let
  packages = {
    "admad/cakephp-i18n" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "admad-cakephp-i18n-31946f864ae0523f0879db0a5e5d5fe194d0b1f2";
        src = fetchurl {
          url = https://api.github.com/repos/ADmad/cakephp-i18n/zipball/31946f864ae0523f0879db0a5e5d5fe194d0b1f2;
          sha256 = "178r7h7vg92qj6w1cxmalwzkl3pgn4sqx1gv6xcc5mwagxlz0mgf";
        };
      };
    };
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
    "composer/xdebug-handler" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "composer-xdebug-handler-f28d44c286812c714741478d968104c5e604a1d4";
        src = fetchurl {
          url = https://api.github.com/repos/composer/xdebug-handler/zipball/f28d44c286812c714741478d968104c5e604a1d4;
          sha256 = "05xayl7hfx69j8cmhs8qy6j18wcv1ay5676dkxj6fs5nrajk3k90";
        };
      };
    };
    "doctrine/annotations" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "doctrine-annotations-ce77a7ba1770462cd705a91a151b6c3746f9c6ad";
        src = fetchurl {
          url = https://api.github.com/repos/doctrine/annotations/zipball/ce77a7ba1770462cd705a91a151b6c3746f9c6ad;
          sha256 = "1gyiq27jg7n0p4wyx7qbcv8kfwacx25jpsnlqiyi3zbrqcb8ajn4";
        };
      };
    };
    "doctrine/lexer" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "doctrine-lexer-e864bbf5904cb8f5bb334f99209b48018522f042";
        src = fetchurl {
          url = https://api.github.com/repos/doctrine/lexer/zipball/e864bbf5904cb8f5bb334f99209b48018522f042;
          sha256 = "11lg9fcy0crb8inklajhx3kyffdbx7xzdj8kwl21xsgq9nm9iwvv";
        };
      };
    };
    "ebrigham1/cakephp-error-email" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "ebrigham1-cakephp-error-email-d82b4a3fd0256549d800eba7647341ba7b835e1e";
        src = fetchurl {
          url = https://api.github.com/repos/ebrigham1/cakephp-error-email/zipball/d82b4a3fd0256549d800eba7647341ba7b835e1e;
          sha256 = "0f08qqnkr3pi39lihvjm5zxxkqvhmbgn1k7s532xk3cxcx58v0dy";
        };
      };
    };
    "friendsofcake/cakepdf" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "friendsofcake-cakepdf-9184b6f6213446b2c1ac355410e7ea2867c7057d";
        src = fetchurl {
          url = https://api.github.com/repos/FriendsOfCake/CakePdf/zipball/9184b6f6213446b2c1ac355410e7ea2867c7057d;
          sha256 = "0mvcs4qjpgpdk7ka3jjlqn2rkj159zwzkq84jj09kf0mwcrk61mr";
        };
      };
    };
    "friendsofphp/php-cs-fixer" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "friendsofphp-php-cs-fixer-c68ff6231adb276857761e43b7ed082f164dce0b";
        src = fetchurl {
          url = https://api.github.com/repos/FriendsOfPHP/PHP-CS-Fixer/zipball/c68ff6231adb276857761e43b7ed082f164dce0b;
          sha256 = "1p6mccdajy8fw5xf9a1wz91fm7jxvv0kv0fn4ppihwl698h4pd7d";
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
    "php-cs-fixer/diff" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "php-cs-fixer-diff-dbd31aeb251639ac0b9e7e29405c1441907f5759";
        src = fetchurl {
          url = https://api.github.com/repos/PHP-CS-Fixer/diff/zipball/dbd31aeb251639ac0b9e7e29405c1441907f5759;
          sha256 = "0wz8m2knrr8jhqbvkqayzykmxhgixxjivlkxmh5n8291sfgc2win";
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
    "psr/event-dispatcher" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-event-dispatcher-dbefd12671e8a14ec7f180cab83036ed26714bb0";
        src = fetchurl {
          url = https://api.github.com/repos/php-fig/event-dispatcher/zipball/dbefd12671e8a14ec7f180cab83036ed26714bb0;
          sha256 = "05nicsd9lwl467bsv4sn44fjnnvqvzj1xqw2mmz9bac9zm66fsjd";
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
    "symfony/config" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-config-d0a82d965296083fe463d655a3644cbe49cbaa80";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/config/zipball/d0a82d965296083fe463d655a3644cbe49cbaa80;
          sha256 = "119iyq8x974vcrmbcqc8hbprdxcpq7dc5150s1a236w8hrqzqv43";
        };
      };
    };
    "symfony/console" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-console-47c02526c532fb381374dab26df05e7313978976";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/console/zipball/47c02526c532fb381374dab26df05e7313978976;
          sha256 = "13539ny0v4s69dqxql01za5lb86dswxml5iv0kz1bqy05cpma6qj";
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
    "symfony/event-dispatcher" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-event-dispatcher-1c93f7a1dff592c252574c79a8635a8a80856042";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/event-dispatcher/zipball/1c93f7a1dff592c252574c79a8635a8a80856042;
          sha256 = "0lcn5bzanbmm8fvixm5wqpzhiaclqdgicm11wmvcxbzz60ncvksk";
        };
      };
    };
    "symfony/event-dispatcher-contracts" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-event-dispatcher-contracts-0ba7d54483095a198fa51781bc608d17e84dffa2";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/event-dispatcher-contracts/zipball/0ba7d54483095a198fa51781bc608d17e84dffa2;
          sha256 = "0z9zqkf340xij833xb7lv1d2ilrw26cbng6xz4lm71r3hpc8hx45";
        };
      };
    };
    "symfony/filesystem" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-filesystem-fa8f8cab6b65e2d99a118e082935344c5ba8c60d";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/filesystem/zipball/fa8f8cab6b65e2d99a118e082935344c5ba8c60d;
          sha256 = "0qm8vbssgcgc9rh337g4rcbv5c0vchwdfpnfhwsavmjdvljmr0lc";
        };
      };
    };
    "symfony/finder" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-finder-0b9231a5922fd7287ba5b411893c0ecd2733e5ba";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/finder/zipball/0b9231a5922fd7287ba5b411893c0ecd2733e5ba;
          sha256 = "1gi29d83ks7ynpjsvh2zhmhaf5y57rq1wgrmah5whpcpj913q70r";
        };
      };
    };
    "symfony/options-resolver" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-options-resolver-87a2a4a766244e796dd9cb9d6f58c123358cd986";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/options-resolver/zipball/87a2a4a766244e796dd9cb9d6f58c123358cd986;
          sha256 = "1wrq9skwfa6m2r548lbczv4wdlm6xwns6cmqd606fwq4pwyrpwnj";
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
        name = "symfony-polyfill-intl-grapheme-267a9adeb8ecb8071040a740930e077cdfb987af";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/polyfill-intl-grapheme/zipball/267a9adeb8ecb8071040a740930e077cdfb987af;
          sha256 = "094nqq6ly9b4rw8dpz7y0knr0dppcbf7w470iqqz9rgkr84gp9r0";
        };
      };
    };
    "symfony/polyfill-intl-normalizer" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-intl-normalizer-6e971c891537eb617a00bb07a43d182a6915faba";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/polyfill-intl-normalizer/zipball/6e971c891537eb617a00bb07a43d182a6915faba;
          sha256 = "05bjbrbl98ap8qrmn22za8303yrpqvnmnk0cr8c4v0jh4kdvck5g";
        };
      };
    };
    "symfony/polyfill-mbstring" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-mbstring-f377a3dd1fde44d37b9831d68dc8dea3ffd28e13";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/polyfill-mbstring/zipball/f377a3dd1fde44d37b9831d68dc8dea3ffd28e13;
          sha256 = "0l2adplbn6fw2dj3nm1s2274q25njii18fzvid5lry4bykqxv34k";
        };
      };
    };
    "symfony/polyfill-php70" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-php70-5f03a781d984aae42cebd18e7912fa80f02ee644";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/polyfill-php70/zipball/5f03a781d984aae42cebd18e7912fa80f02ee644;
          sha256 = "0yzw1gp2q46pk8fmgvz4nyiz34m6d4kiardyr9ajdmfrlqsiy202";
        };
      };
    };
    "symfony/polyfill-php72" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-php72-cc6e6f9b39fe8075b3dabfbaf5b5f645ae1340c9";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/polyfill-php72/zipball/cc6e6f9b39fe8075b3dabfbaf5b5f645ae1340c9;
          sha256 = "12dmz2n1b9pqqd758ja0c8h8h5dxdai5ik74iwvaxc5xn86a026b";
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
    "symfony/process" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-process-bd8815b8b6705298beaa384f04fabd459c10bedd";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/process/zipball/bd8815b8b6705298beaa384f04fabd459c10bedd;
          sha256 = "19znmxq8scqh1kx2bjqkv1wbqablv0cpp5yld460asdixksvcjn5";
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
    "symfony/stopwatch" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-stopwatch-2b105c0354f39a63038a1d8bf776ee92852813af";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/stopwatch/zipball/2b105c0354f39a63038a1d8bf776ee92852813af;
          sha256 = "13w9hgyjldb7g7w12gjqfmgg8am9s4c3k7knzsliqy0qxs18ydcl";
        };
      };
    };
    "symfony/string" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-string-5bd67751d2e3f7d6f770c9154b8fbcb2aa05f7ed";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/string/zipball/5bd67751d2e3f7d6f770c9154b8fbcb2aa05f7ed;
          sha256 = "1ny6bi2sflsdr68fjr2jww3nph0znji6b9pypib426gjv0rf282h";
        };
      };
    };
    "symfony/yaml" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-yaml-290ea5e03b8cf9b42c783163123f54441fb06939";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/yaml/zipball/290ea5e03b8cf9b42c783163123f54441fb06939;
          sha256 = "0v4kzpy88vj7wmgaccb2hvf8rgi2a3wzc663vb0f8mgixr1ljw89";
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
        name = "ajgl-breakpoint-twig-extension-13ee39406dc3d959c5704b462a3dbc3cbf088f16";
        src = fetchurl {
          url = https://api.github.com/repos/ajgarlag/AjglBreakpointTwigExtension/zipball/13ee39406dc3d959c5704b462a3dbc3cbf088f16;
          sha256 = "15rw0yqh8rzgski17h1pq0fpnl0bxm7gf947cwgfi7nl93y2j5hh";
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
        name = "composer-composer-196601d50c08c3fae389a417a7689367fcf37cef";
        src = fetchurl {
          url = https://api.github.com/repos/composer/composer/zipball/196601d50c08c3fae389a417a7689367fcf37cef;
          sha256 = "19ncg4f8an2hr5srs57m596dl77vfdc70dlc1zy9rzhbapdy82jz";
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
    "phpstan/phpstan" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpstan-phpstan-8f436ea35241da33487fd0d38b4bc3e6dfe30ea8";
        src = fetchurl {
          url = https://api.github.com/repos/phpstan/phpstan/zipball/8f436ea35241da33487fd0d38b4bc3e6dfe30ea8;
          sha256 = "1k3rrvswk4fxqbkyynb8msj3b7y1p1qd11zhhy3ag5sgfyqalhk6";
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
        name = "psy-psysh-6f990c19f91729de8b31e639d6e204ea59f19cf3";
        src = fetchurl {
          url = https://api.github.com/repos/bobthecow/psysh/zipball/6f990c19f91729de8b31e639d6e204ea59f19cf3;
          sha256 = "17ybdc14w7zqhzy90nnzl0scazjd6bp58na12lj3czdpjg4zf901";
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
        name = "squizlabs-php_codesniffer-9d583721a7157ee997f235f327de038e7ea6dac4";
        src = fetchurl {
          url = https://api.github.com/repos/squizlabs/PHP_CodeSniffer/zipball/9d583721a7157ee997f235f327de038e7ea6dac4;
          sha256 = "06nmavz27qbnrbhkzbzbm0dc7iir7qwbp7i1dsv3s9490wxxqszm";
        };
      };
    };
    "symfony/var-dumper" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-var-dumper-13e7e882eaa55863faa7c4ad7c60f12f1a8b5089";
        src = fetchurl {
          url = https://api.github.com/repos/symfony/var-dumper/zipball/13e7e882eaa55863faa7c4ad7c60f12f1a8b5089;
          sha256 = "011406xksrpgd78gkakg27fgqsajdyzf3hkqx1xf6l8vxfw4z7a9";
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
    "webmozart/assert" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "webmozart-assert-bafc69caeb4d49c39fd0779086c03a3738cbb389";
        src = fetchurl {
          url = https://api.github.com/repos/webmozarts/assert/zipball/bafc69caeb4d49c39fd0779086c03a3738cbb389;
          sha256 = "0wd0si4c9r1256xj76vgk2slxpamd0wzam3dyyz0g8xgyra7201c";
        };
      };
    };
    "wyrihaximus/twig-view" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "wyrihaximus-twig-view-a5ec66690aa045d6eda17ab1c8a5baf0efdcfa45";
        src = fetchurl {
          url = https://api.github.com/repos/cakephp/legacy-twig-view/zipball/a5ec66690aa045d6eda17ab1c8a5baf0efdcfa45;
          sha256 = "0bq9mc0wsk8yj1hw54gqk8y43bq1j9nmimy7q5616zvqbdgzqrcb";
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