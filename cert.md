# SSL/TLS Certificate 

- show the certificate text
```
openssl x509 -noout -text -in foo.cert
```
- show the certificate issuer and dates
```
openssl x509 -noout -issuer -dates -in bar.cert
```

