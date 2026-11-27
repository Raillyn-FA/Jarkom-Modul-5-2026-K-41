#!/bin/sh
# SOAL 10: perbaiki sabotase NAT di Misato
if [ "$1" = cek ]; then iptables -t nat -L POSTROUTING -n -v --line-numbers; exit 0; fi
while iptables -t nat -D POSTROUTING -s 10.84.4.64/29 ! -d 10.84.0.0/16 -o eth0 -j SNAT --to-source 172.31.99.1 2>/dev/null; do :; done
iptables -t nat -L POSTROUTING -n -v --line-numbers
