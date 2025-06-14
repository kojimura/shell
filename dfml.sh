#!/bin/bash
# alart mail for disk usage
export LANG=C

# Thresholds LOW MIDDLE HIGH (%)
TL=70
TM=80
TH=90

# Log Drectory, Filename and Number of rotation
LOGD="/opt/tools/log"
LOGF="${LOGD}/dfml1.log"
ROT=5

# Mail destination address
ADDR="your_account@your.domain.com"

# Rotate logs
for ((i=${ROT}; i > 1; i--)); do
    TRG="${LOGD}/dfml${i}.log"
    SRC="${LOGD}/dfml$((i - 1)).log"
    if [ -e "${SRC}" ]; then
        cp -p "${SRC}" "${TRG}"
    fi
done

# Header
echo "$(uname -n) $(date '+%Y-%m-%d %H:%M:%S') Usage file systems (Sev1>${TH}%, Sev2>${TM}%, Sev3>${TL}%)" > "${LOGF}"

# Check Disk usage, except specified directories, output log
maxlv=$(df -hP | awk -v logfile="${LOGF}" -v tl=$TL -v tm=$TM -v th=$TH '
$6 !~ "^/$" &&
$6 !~ "^/boot" &&
$6 !~ "^/opt/except/dir" {
  us = substr($5, 1, length($5) - 1) + 0;
  if (us > tl) {
    print >> logfile;
    lv = 1;
    if (us > tm) { lv = 2 }
    if (us > th) { lv = 3 }
    if (lv > mx) { mx = lv }
  }
}
END { print (mx > 0 ? mx : 0) }
')

# mail Subject line
SBJ="Warning! disk overused [Sev$((4 - maxlv))]"

# Output log
cat "${LOGF}"

# Send mail if needed
if [ "$(wc -l < "${LOGF}")" -gt 1 ]; then
    echo "Sending email to ${ADDR}..."
    sudo mail -r "senderName" -s "${SBJ}" "${ADDR}" < "${LOGF}"
    echo "----" >> "${LOGF}"
    df -hP >> "${LOGF}"
fi
