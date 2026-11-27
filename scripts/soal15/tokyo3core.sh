#!/bin/sh
# SOAL 15: batasi balasan ping Tokyo3-Core maks 5/detik
if [ "$1" = cek ]; then
  iptables -L PINGLIMIT -n -v --line-numbers
  iptables -L INPUT -n -v --line-numbers | head -5
  exit 0
fi
command -v iptables >/dev/null 2>&1 || apt-get install -y iptables >/dev/null 2>&1
iptables -N PINGLIMIT 2>/dev/null
iptables -F PINGLIMIT
# hanya paket echo-request yang MASUK (ping ke Tokyo3-Core); echo-reply dan ping keluar tidak tersentuh
iptables -A PINGLIMIT -m limit --limit 5/second --limit-burst 5 -j ACCEPT
iptables -A PINGLIMIT -j DROP
iptables -C INPUT -p icmp --icmp-type echo-request -j PINGLIMIT 2>/dev/null || \
  iptables -I INPUT 1 -p icmp --icmp-type echo-request -j PINGLIMIT
iptables -L PINGLIMIT -n -v --line-numbers
