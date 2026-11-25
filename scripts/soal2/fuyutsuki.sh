#!/bin/sh
# /root/fuyutsuki.sh  --  Router Fuyutsuki  (K-41, Operation Geofront)
# Skrip kumulatif: soal 2 sekarang, bagian soal 3 dst. ditambah di bawah.
# Pengkabelan GNS3 (adapter -> tujuan):
#   eth0: link ke Gendou
#   eth1: Switch-Terminal
#   eth2: link ke Maya
#   eth3: link ke Toji

[ "$(id -u)" = 0 ] || { echo "Harus root"; exit 1; }

if [ "$1" = cek ]; then   # sh /root/fuyutsuki.sh cek  -> ping ujung seberang tiap link
  echo "== link ke Gendou (10.84.4.145)"; ping -c 2 -W 1 10.84.4.145
  echo "== link ke Maya (10.84.4.126)"; ping -c 2 -W 1 10.84.4.126
  echo "== link ke Toji (10.84.4.154)"; ping -c 2 -W 1 10.84.4.154
  exit 0
fi

### SOAL 2: alamat interface + IP forwarding
ip link set eth0 up
ip -4 addr flush dev eth0
ip addr add 10.84.4.146/30 dev eth0
ip link set eth1 up
ip -4 addr flush dev eth1
ip addr add 10.84.4.57/29 dev eth1
ip link set eth2 up
ip -4 addr flush dev eth2
ip addr add 10.84.4.125/30 dev eth2
ip link set eth3 up
ip -4 addr flush dev eth3
ip addr add 10.84.4.153/30 dev eth3
sysctl -w net.ipv4.ip_forward=1 >/dev/null 2>&1 || echo 1 > /proc/sys/net/ipv4/ip_forward
ip -br a
cat /proc/sys/net/ipv4/ip_forward

### SOAL 3: routing statis  (diisi nanti)
### SOAL 4+: NAT/firewall (khusus Gendou)  (diisi nanti)
