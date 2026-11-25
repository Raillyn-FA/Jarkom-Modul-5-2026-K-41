#!/bin/sh
# /root/shigeru.sh  --  Router Shigeru  (K-41, Operation Geofront)
# Skrip kumulatif: soal 2 sekarang, bagian soal 3 dst. ditambah di bawah.
# Pengkabelan GNS3 (adapter -> tujuan):
#   eth0: link ke Gendou
#   eth1: Switch-Monolith
#   eth2: link ke Makoto

[ "$(id -u)" = 0 ] || { echo "Harus root"; exit 1; }

if [ "$1" = cek ]; then   # sh /root/shigeru.sh cek  -> ping ujung seberang tiap link
  echo "== link ke Gendou (10.84.4.157)"; ping -c 2 -W 1 10.84.4.157
  echo "== link ke Makoto (10.84.4.162)"; ping -c 2 -W 1 10.84.4.162
  exit 0
fi

### SOAL 2: alamat interface + IP forwarding
ip link set eth0 up
ip -4 addr flush dev eth0
ip addr add 10.84.4.158/30 dev eth0
ip link set eth1 up
ip -4 addr flush dev eth1
ip addr add 10.84.4.81/29 dev eth1
ip link set eth2 up
ip -4 addr flush dev eth2
ip addr add 10.84.4.161/30 dev eth2
sysctl -w net.ipv4.ip_forward=1 >/dev/null 2>&1 || echo 1 > /proc/sys/net/ipv4/ip_forward
ip -br a
cat /proc/sys/net/ipv4/ip_forward

### SOAL 3: routing statis  (diisi nanti)
### SOAL 4+: NAT/firewall (khusus Gendou)  (diisi nanti)
