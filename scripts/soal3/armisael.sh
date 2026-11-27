#!/bin/sh
# SOAL 3: IP SEMENTARA node uji Armisael (permanen di soal 6)
if [ "$1" = cek ]; then hostname; ip -br a; ip route; echo "== ping Lilith (10.84.4.74)"; ping -c 3 -W 1 10.84.4.74; echo "== ping Sachiel (10.84.3.130)"; ping -c 3 -W 1 10.84.3.130; echo "== ping Comm-Net (10.84.2.2)"; ping -c 3 -W 1 10.84.2.2; exit 0; fi

ip link set eth0 up
ip -4 addr flush dev eth0
ip addr add 10.84.4.83/29 dev eth0
ip route del default 2>/dev/null
ip route add default via 10.84.4.81
ip -br a
ip route
