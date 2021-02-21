# External Certificates

This illustrates usage of externally provided certificates
instead of using ACME support.

## Apache

```
services.httpd.virtualHosts.<name>.sslServerCert = "/path"
services.httpd.virtualHosts.<name>.sslServerKey = "/path"
```

Nginx
-----

```
services.nginx.virtualHosts.<name>.sslCertificate = "/path"
services.nginx.virtualHosts.<name>.sslCertificateKey = "/path"
```
