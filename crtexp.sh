#!/bin/bash
# get expiry date from remote host list

HOSTS="hosts.lst"

#HOSTS=(
#  www.google.com
#  your.domain.com
#  example.com
#)

if [ ! -f "$HOSTS" ]; then
  echo "Error: $HOSTS not found"
  exit 1
fi

echo -e "expire\tdomain\tissuer"
while IFS= read -r host;do
  [[ -z "$host" || "$host" =~ ^# ]] && continue
  cert=$(echo | openssl s_client -servername "$host" -connect "$host:443" -showcerts 2>/dev/null \
        | openssl x509 -noout -issuer -enddate 2>/dev/null)
  if [ -z "$cert" ]; then
    echo -e "-\t$host\tFailed"
  else
    issuer=$(echo "$cert" | grep issuer= | sed 's/issuer= //')
    enddate=$(echo "$cert" | grep notAfter= | cut -d= -f2)
    formdate=$(date -d "$enddate" "+%Y-%m-%d %H:%M:%S")
    echo -e "$formdate\t$host\t$issuer"
  fi
done < "$HOSTS"| sort
