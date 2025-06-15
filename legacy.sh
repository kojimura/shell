#!/bin/bash

# usage message
usage() {
  echo "List big old files"
  echo "Usage: $0 [dir] [num]"
  echo "       e.g. $0 /your/directory/ 10"
  exit 1
}

# argument
if [ $# -eq 0 ]; then
  DIR="/"
  NUM=10
elif [ $# -eq 1 ]; then
  DIR="$1"
  NUM=10
elif [ $# -eq 2 ]; then
  DIR="$1"
  NUM="$2"
else
  usage
fi

echo "Top $NUM of big old files in $DIR"

sudo find "$DIR" \
  \( -path /proc -o -path /run/user -o -path /run/user/*/gvfs \) -prune -o \
  -type f -printf '%s %T@ %p\n' 2>/dev/null | \
  sort -nr | head -n "$NUM" | sort -k2 | \
  awk '
    {
      s += $1;
      m = $1 / (10 * 1024 * 1024);
      c = "date -d @" $2 " +%Y-%m-%d";
      c | getline date;
      close(c);
      printf "%.1fM\t%s\t%s\n", m, date, $3;
    }
    END {
      printf "%.1fMB\n", s / (1024 * 1024);
    }
  '
