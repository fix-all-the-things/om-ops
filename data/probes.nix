let
  domains = import ./domains.nix;
in
{
  # icmp probes
  hosts = [
    domains.om
  ];

  # http v4/v6 ssl/nossl probes
  websites = [
    domains.cv

    domains.om
    # "booked.${domains.om}" # broken
    "dsw2.${domains.om}"
    "forum.${domains.om}"
    "iot.${domains.om}"
    "kmd.${domains.om}"
    "lists.${domains.om}"
    "navstevnost.${domains.om}"
    "nia.${domains.om}"
    "pg.${domains.om}"
    "projekty.${domains.om}"
    "soubory.${domains.om}"
    "status.${domains.om}"
    "ukoly.${domains.om}"
    "ucto.${domains.om}"
    "virtuoso.${domains.om}"
    # "webmail.${domains.om}" # off
    "wiki.${domains.om}"

    domains.vesp
    "www.${domains.vesp}"
    "forum.${domains.vesp}"
    "element.${domains.vesp}"
    "riot.${domains.vesp}" # old name, delete at some point
  ];

  # tcp v4/v6 tls probes
  tcpTls = [
    "mx.${domains.om}:465" # mail Message Submission, SSL
    "mx.${domains.om}:993" # mail IMAPS, SSL
    "mx.${domains.om}:995" # mail POP3S, SSL
  ];

  # tcp v4/v6 probes
  tcp = [
    "mx.${domains.om}:25"  # SMTP
    "mx.${domains.om}:143" # IMAP
    "mx.${domains.om}:587" # Message Submission
  ];
}
