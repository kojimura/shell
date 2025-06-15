#!/bin/bash
HST=$(uname -n)
NOW=$(date +%Y%m%d%M)
OUT="${HST}_${NOW}.log"
echo "check $(uname -n) status >>>"

date |tee "$OUT"
{
  uptime
  free -h
  vmstat
  sar
  netstat -antup
  iostat
  df -hP
  mount
  ps -er
} 2>&1 | tee -a "$OUT" &
top -b -d 1 2>&1 | tee -a "$OUT" &
top_pid=$!
sleep 3
kill $top_pid
tail "$OUT"
ls -ltr "$OUT"
