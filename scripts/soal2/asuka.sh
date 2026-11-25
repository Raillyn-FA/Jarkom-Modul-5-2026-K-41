#!/bin/sh
# /root/asuka.sh  --  Router Asuka  (K-41, Operation Geofront)
# Skrip kumulatif: soal 2 sekarang, bagian soal 3 dst. ditambah di bawah.
# Pengkabelan GNS3 (adapter -> tujuan):
#   eth0: link ke Gendou
#   eth1: Switch-Archive
#   eth2: link ke Ritsuko
#   eth3: link ke Kensuke

[ "$(id -u)" = 0 ] || { echo "Harus root"; exit 1; }

if [ "$1" = cek ]; then   # sh /root/asuka.sh cek  -> ping ujung seberang tiap link
  echo "== link ke Gendou (10.84.4.165)"; ping -c 2 -W 1 10.84.4.165
  echo "== link ke Kensuke (10.84.4.122)"; ping -c 2 -W 1 10.84.4.122
  echo "== link ke Ritsuko (10.84.4.142)"; ping -c 2 -W 1 10.84.4.142
  exit 0
fi

### SOAL 2: alamat interface + IP forwarding
ip link set eth0 up
ip -4 addr flush dev eth0
ip addr add 10.84.4.166/30 dev eth0
ip link set eth1 up
ip -4 addr flush dev eth1
ip addr add 10.84.4.97/30 dev eth1
ip link set eth3 up
ip -4 addr flush dev eth3
ip addr add 10.84.4.121/30 dev eth3
ip link set eth2 up
ip -4 addr flush dev eth2
ip addr add 10.84.4.141/30 dev eth2
sysctl -w net.ipv4.ip_forward=1 >/dev/null 2>&1 || echo 1 > /proc/sys/net/ipv4/ip_forward
ip -br a
cat /proc/sys/net/ipv4/ip_forward

### SOAL 3: routing statis  (diisi nanti)
### SOAL 4+: NAT/firewall (khusus Gendou)  (diisi nanti)
