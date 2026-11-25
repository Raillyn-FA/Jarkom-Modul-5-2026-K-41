#!/bin/sh
# /root/yui.sh  --  Router Yui  (K-41, Operation Geofront)
# Skrip kumulatif: soal 2 sekarang, bagian soal 3 dst. ditambah di bawah.
# Pengkabelan GNS3 (adapter -> tujuan):
#   eth0: link ke Gendou
#   eth1: link ke Shinji
#   eth2: link ke Rei
#   eth3: link ke Mari
#   eth4: Switch-Hangar

[ "$(id -u)" = 0 ] || { echo "Harus root"; exit 1; }

if [ "$1" = cek ]; then   # sh /root/yui.sh cek  -> ping ujung seberang tiap link
  echo "== link ke Gendou (10.84.4.117)"; ping -c 2 -W 1 10.84.4.117
  echo "== link ke Rei (10.84.4.110)"; ping -c 2 -W 1 10.84.4.110
  echo "== link ke Shinji (10.84.4.134)"; ping -c 2 -W 1 10.84.4.134
  echo "== link ke Mari (10.84.4.138)"; ping -c 2 -W 1 10.84.4.138
  exit 0
fi

### SOAL 2: alamat interface + IP forwarding
ip link set eth0 up
ip -4 addr flush dev eth0
ip addr add 10.84.4.118/30 dev eth0
ip link set eth4 up
ip -4 addr flush dev eth4
ip addr add 10.84.3.1/25 dev eth4
ip link set eth2 up
ip -4 addr flush dev eth2
ip addr add 10.84.4.109/30 dev eth2
ip link set eth1 up
ip -4 addr flush dev eth1
ip addr add 10.84.4.133/30 dev eth1
ip link set eth3 up
ip -4 addr flush dev eth3
ip addr add 10.84.4.137/30 dev eth3
sysctl -w net.ipv4.ip_forward=1 >/dev/null 2>&1 || echo 1 > /proc/sys/net/ipv4/ip_forward
ip -br a
cat /proc/sys/net/ipv4/ip_forward

### SOAL 3: routing statis  (diisi nanti)
### SOAL 4+: NAT/firewall (khusus Gendou)  (diisi nanti)
