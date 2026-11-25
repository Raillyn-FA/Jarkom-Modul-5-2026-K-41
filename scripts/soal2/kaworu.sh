#!/bin/sh
# /root/kaworu.sh  --  Router Kaworu  (K-41, Operation Geofront)
# Skrip kumulatif: soal 2 sekarang, bagian soal 3 dst. ditambah di bawah.
# Pengkabelan GNS3 (adapter -> tujuan):
#   eth0: link ke Hikari
#   eth1: Switch-Relay

[ "$(id -u)" = 0 ] || { echo "Harus root"; exit 1; }

if [ "$1" = cek ]; then   # sh /root/kaworu.sh cek  -> ping ujung seberang tiap link
  echo "== link ke Hikari (10.84.4.129)"; ping -c 2 -W 1 10.84.4.129
  exit 0
fi

### SOAL 2: alamat interface + IP forwarding
ip link set eth0 up
ip -4 addr flush dev eth0
ip addr add 10.84.4.130/30 dev eth0
ip link set eth1 up
ip -4 addr flush dev eth1
ip addr add 10.84.3.225/27 dev eth1
sysctl -w net.ipv4.ip_forward=1 >/dev/null 2>&1 || echo 1 > /proc/sys/net/ipv4/ip_forward
ip -br a
cat /proc/sys/net/ipv4/ip_forward

### SOAL 3: routing statis  (diisi nanti)
### SOAL 4+: NAT/firewall (khusus Gendou)  (diisi nanti)
