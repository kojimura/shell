#!/bin/bash -eux
# remove empty directories recursive
isempty() {
    local DIR=$1
    local CNT=$(ls -A "$DIR" 2>/dev/null | wc -l)
    return $CNT
}
ckdir_r() {
    local CDR="$1"
    for ENT in "${CDR}"/* ; do
        if [ -d "$ENT" ]; then
            ckdir_r "$ENT"
        fi
    done
    if isempty "$CDR"; then
        read -p "$CDR is going to be removed! OK ? (y/n) " ANS
        if [ "$ANS" == "y" ]; then
            rmdir "$CDR"
        fi
    fi
}
if [ $# -lt 1 ]; then
  echo "remove empty directories recursively"
  echo "Usage: $0 dir i.e. $0 ."
  exit 1
fi
PTH=$1
ckdir_r "$PTH"
ls -l "$PTH"
echo "$0 completed"
