#!/bin/sh
# SOAL 10: perbaiki sabotase NAT di Gendou
if [ "$1" = cek ]; then iptables -t nat -L POSTROUTING -n -v --line-numbers; exit 0; fi
while iptables -t nat -D POSTROUTING -s 10.84.4.64/29 -o eth0 -j RETURN 2>/dev/null; do :; done
iptables -t nat -L POSTROUTING -n -v --line-numbers
