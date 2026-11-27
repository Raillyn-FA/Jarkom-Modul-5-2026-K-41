#!/bin/sh
# SOAL 9: perbaiki sabotase routing di Shigeru
IF_UP=eth0; IF_LAN=eth1; GW_UP=10.84.4.157; DOGMA=10.84.4.72/29

if [ "$1" = cek ]; then
  hostname; ip -br a
  sysctl net.ipv4.ip_forward
  ip route; ip rule; ip route show table 100
  exit 0
fi

sysctl -w net.ipv4.ip_forward=1                              # 1) forwarding dimatikan
ip route replace default via $GW_UP dev $IF_UP               # 2) default route dibelokkan ke Makoto
ip route del blackhole $DOGMA 2>/dev/null                    # 3) subnet Dogma (Lilith) di-blackhole
ip rule del iif $IF_LAN lookup 100 priority 90 2>/dev/null   # 4) paket dari LAN dilempar ke tabel 100
ip route flush table 100 2>/dev/null                         #    tabel 100 berisi "unreachable default"
sh /root/soal9_shigeru_fix.sh cek 2>/dev/null || true
