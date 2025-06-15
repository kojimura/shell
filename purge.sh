#!/bin/bash -eux
if [ $# -lt 1 ]; then
  echo "purge old files"
  echo "Usage: $0 path i.e. $0 ."
  exit 1
fi

PTH=$1
DYS=30

ls -ld "$PTH"
find "$PTH" -type f -atime +"$DYS" -exec rm -i {} \;
