#!/bin/sh
# SOAL 16: catat dan tolak koneksi Dummy-Plug ke port sensitif
if [ "$1" = cek ]; then
  iptables -L SCANNERV -n -v --line-numbers
  iptables -L INPUT -n -v --line-numbers | head -6
  exit 0
fi
command -v iptables >/dev/null 2>&1 || apt-get install -y iptables >/dev/null 2>&1
iptables -N SCANNERV 2>/dev/null
iptables -F SCANNERV
iptables -A SCANNERV -j LOG --log-prefix "SCAN-NERV: " --log-level 4   # 1) catat (counter = jumlah percobaan)
iptables -A SCANNERV -p tcp -j REJECT --reject-with tcp-reset          # 2) tolak seketika
iptables -C INPUT -s 10.84.4.51 -p tcp -m multiport --dports 22,23,3306 -j SCANNERV 2>/dev/null || \
  iptables -I INPUT 1 -s 10.84.4.51 -p tcp -m multiport --dports 22,23,3306 -j SCANNERV
iptables -L SCANNERV -n -v --line-numbers
