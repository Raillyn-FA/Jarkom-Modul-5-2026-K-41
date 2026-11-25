#!/bin/sh
# /root/toji.sh  --  Router Toji  (K-41, Operation Geofront)
# Skrip kumulatif: soal 2 sekarang, bagian soal 3 dst. ditambah di bawah.
# Pengkabelan GNS3 (adapter -> tujuan):
#   eth0: link ke Fuyutsuki
#   eth1: Switch-Dogma

[ "$(id -u)" = 0 ] || { echo "Harus root"; exit 1; }

if [ "$1" = cek ]; then   # sh /root/toji.sh cek  -> ping ujung seberang tiap link
  echo "== link ke Fuyutsuki (10.84.4.153)"; ping -c 2 -W 1 10.84.4.153
  exit 0
fi

### SOAL 2: alamat interface + IP forwarding
ip link set eth0 up
ip -4 addr flush dev eth0
ip addr add 10.84.4.154/30 dev eth0
ip link set eth1 up
ip -4 addr flush dev eth1
ip addr add 10.84.4.73/29 dev eth1
sysctl -w net.ipv4.ip_forward=1 >/dev/null 2>&1 || echo 1 > /proc/sys/net/ipv4/ip_forward
ip -br a
cat /proc/sys/net/ipv4/ip_forward

### SOAL 3: routing statis  (diisi nanti)
### SOAL 4+: NAT/firewall (khusus Gendou)  (diisi nanti)
