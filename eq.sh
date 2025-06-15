#!/bin/bash
if [ $# -ne 1 ]; then
  echo "find euibalent files under the directory"
  echo "Usage: $0 directory i.e. $0 ."
  exit 1
fi
DIR=$1
echo "Checking equibalent files in $DIR >>>"
sudo find $DIE -type f|sudo xargs md5sum|awk '{a[$1]=a[$1]" "$2}END{for(k in a){print k,a[k]}}'|awk 'NF>2'
