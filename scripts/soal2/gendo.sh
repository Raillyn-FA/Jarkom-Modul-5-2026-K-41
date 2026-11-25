#!/bin/sh
# /root/gendo.sh  --  Router Gendou  (K-41, Operation Geofront)
# Skrip kumulatif: soal 2 sekarang, bagian soal 3 dst. ditambah di bawah.
# Pengkabelan GNS3 (adapter -> tujuan):
#   eth0: NAT1 (DHCP)
#   eth1: Switch-Cmd
#   eth2: link ke Fuyutsuki
#   eth3: link ke Shigeru
#   eth4: link ke Misato
#   eth5: link ke Kaji
#   eth6: link ke Asuka
#   eth7: link ke Hikari
#   eth8: link ke Yui

[ "$(id -u)" = 0 ] || { echo "Harus root"; exit 1; }

if [ "$1" = cek ]; then   # sh /root/gendo.sh cek  -> ping ujung seberang tiap link
  echo "== link ke Hikari (10.84.4.114)"; ping -c 2 -W 1 10.84.4.114
  echo "== link ke Yui (10.84.4.118)"; ping -c 2 -W 1 10.84.4.118
  echo "== link ke Fuyutsuki (10.84.4.146)"; ping -c 2 -W 1 10.84.4.146
  echo "== link ke Misato (10.84.4.150)"; ping -c 2 -W 1 10.84.4.150
  echo "== link ke Shigeru (10.84.4.158)"; ping -c 2 -W 1 10.84.4.158
  echo "== link ke Asuka (10.84.4.166)"; ping -c 2 -W 1 10.84.4.166
  echo "== link ke Kaji (10.84.4.170)"; ping -c 2 -W 1 10.84.4.170
  exit 0
fi

### SOAL 2: alamat interface + IP forwarding
ip link set eth0 up
# eth0 ke NAT1 memakai DHCP (hanya Gendou)
ip -4 addr show dev eth0 | grep -q 'inet ' || {
  if command -v dhclient >/dev/null 2>&1; then dhclient eth0
  elif command -v udhcpc >/dev/null 2>&1; then udhcpc -i eth0 -q
  else echo 'dhclient/udhcpc tidak ada'; fi
}
ip link set eth1 up
ip -4 addr flush dev eth1
ip addr add 10.84.4.105/30 dev eth1
ip link set eth7 up
ip -4 addr flush dev eth7
ip addr add 10.84.4.113/30 dev eth7
ip link set eth8 up
ip -4 addr flush dev eth8
ip addr add 10.84.4.117/30 dev eth8
ip link set eth2 up
ip -4 addr flush dev eth2
ip addr add 10.84.4.145/30 dev eth2
ip link set eth4 up
ip -4 addr flush dev eth4
ip addr add 10.84.4.149/30 dev eth4
ip link set eth3 up
ip -4 addr flush dev eth3
ip addr add 10.84.4.157/30 dev eth3
ip link set eth6 up
ip -4 addr flush dev eth6
ip addr add 10.84.4.165/30 dev eth6
ip link set eth5 up
ip -4 addr flush dev eth5
ip addr add 10.84.4.169/30 dev eth5
sysctl -w net.ipv4.ip_forward=1 >/dev/null 2>&1 || echo 1 > /proc/sys/net/ipv4/ip_forward
ip -br a
cat /proc/sys/net/ipv4/ip_forward

### SOAL 3: routing statis  (diisi nanti)
### SOAL 4+: NAT/firewall (khusus Gendou)  (diisi nanti)
