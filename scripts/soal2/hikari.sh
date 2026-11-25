#!/bin/sh
# /root/hikari.sh  --  Router Hikari  (K-41, Operation Geofront)
# Skrip kumulatif: soal 2 sekarang, bagian soal 3 dst. ditambah di bawah.
# Pengkabelan GNS3 (adapter -> tujuan):
#   eth0: link ke Gendou
#   eth1: link ke Kaworu
#   eth2: Switch-Comm

[ "$(id -u)" = 0 ] || { echo "Harus root"; exit 1; }

if [ "$1" = cek ]; then   # sh /root/hikari.sh cek  -> ping ujung seberang tiap link
  echo "== link ke Gendou (10.84.4.113)"; ping -c 2 -W 1 10.84.4.113
  echo "== link ke Kaworu (10.84.4.130)"; ping -c 2 -W 1 10.84.4.130
  exit 0
fi

### SOAL 2: alamat interface + IP forwarding
ip link set eth0 up
ip -4 addr flush dev eth0
ip addr add 10.84.4.114/30 dev eth0
ip link set eth2 up
ip -4 addr flush dev eth2
ip addr add 10.84.2.1/24 dev eth2
ip link set eth1 up
ip -4 addr flush dev eth1
ip addr add 10.84.4.129/30 dev eth1
sysctl -w net.ipv4.ip_forward=1 >/dev/null 2>&1 || echo 1 > /proc/sys/net/ipv4/ip_forward
ip -br a
cat /proc/sys/net/ipv4/ip_forward

### SOAL 3: routing statis  (diisi nanti)
### SOAL 4+: NAT/firewall (khusus Gendou)  (diisi nanti)
