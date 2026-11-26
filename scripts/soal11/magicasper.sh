#!/bin/sh
# /root/soal11_magicasper.sh  --  SOAL 11: Casper menjadi "hantu" (tidak boleh di-ping siapa pun)
[ "$(id -u)" = 0 ] || { echo "Harus root"; exit 1; }

if [ "$1" = cek ]; then
  hostname
  iptables -S INPUT
  iptables -L INPUT -n -v
  exit 0
fi

command -v iptables >/dev/null 2>&1 || { echo "iptables belum terpasang (jalankan soal 7)"; exit 1; }

# Buang (DROP) setiap echo-request yang masuk, dari siapa pun, termasuk satu switch.
# DROP, bukan REJECT: REJECT membalas dengan pesan error sehingga keberadaan Casper ketahuan.
# Hanya echo-request: echo-reply untuk ping yang dikirim Casper sendiri tetap diterima,
# dan TCP 5000 tidak tersentuh. Disisipkan di posisi 1 supaya selalu dievaluasi paling awal.
iptables -C INPUT -p icmp --icmp-type echo-request -j DROP 2>/dev/null || \
  iptables -I INPUT 1 -p icmp --icmp-type echo-request -j DROP

iptables -S INPUT
