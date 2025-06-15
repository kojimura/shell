#!/bin/bash

if [ $# -ne 1 ]; then
  echo "convert date format to epoch time"
  echo "Usage: $0 datetime i.e. $0 20231231000000"
  exit 1
fi
dat=$1
y=${dat:0:4}
m=${dat:4:2}
d=${dat:6:2}
H=${dat:8:2}
M=${dat:10:2}
S=${dat:12:2}

e=$(date -d "$y-$m-$d $H:$M:$S" +%s)
echo "$e"
