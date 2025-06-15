#!/bin/bash
# Check the disk usage, show the big old files

DAYS=1825
SIZE="100M"
PTH="/"

while getopts ":d:s:p:" opt; do
    case $opt in
        d)  DAYS=$OPTARG
            echo "-d $OPTARG"
            ;;
        s)  SIZE=$OPTARG
            echo "-s $OPTARG"
            ;;
        p)  PTH=$OPTARG
            echo "-p $OPTARG"
            ;;
        \?) echo "Invalid $OPTARG Usage: $0 [-p path][-d days][-s size]"
            exit 1
            ;;
    esac
done
shift `expr $OPTIND - 1`

echo "Finding big(>${SIZE} old(>${DAYS}) files in $PTH >>>"
sudo find "$PTH" \
 \( -path /proc -o -path /run/user -o -path /run/user/*/gvfs \) -prune -o \
 -type f -mtime +"$DAYS" -size +"$SIZE" -exec ls -lh {} \;
