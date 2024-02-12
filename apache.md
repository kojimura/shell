### apache log

- Total size of response from clients excluding headers.
```
cat access_log|awk '{S+=$10} END {printf("%d MB\n",S/1024/1024)}'
```
- How many times accessed from each remote_host
```
cat access_log|awk '{print $1}'|sort|uniq -c|sort -nr
```
- Hourly number of accesses
```
cat access_log|awk '{print $4}'|cut -b 2-15|sort|uniq -c
```

(https://trinitas.jp/column/1758/)

### apache benchmark

```
ab -n 500 -c 100 https://example.com/
```

