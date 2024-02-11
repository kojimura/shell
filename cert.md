# SSL/TLS Certificate 

- show the certificate text
```
openssl x509 -noout -text -in foo.cert
```
- show the certificate issuer and dates
```
openssl x509 -noout -issuer -dates -in bar.cert
```
- connect from client
```
openssl s_client -connect example.com:443 < /dev/null 2> /dev/null | openssl x509 -noout -subject -dates
```
- http response
```
curl -kv https://google.com 2>&1|egrep 'subject|start date|expire date'
```
