#!/bin/sh
# /root/fuyutsuki.sh  --  Router Fuyutsuki  (K-41, Operation Geofront)
# Skrip kumulatif: soal 2 sekarang, bagian soal 3 dst. ditambah di bawah.
# Pengkabelan GNS3 (adapter -> tujuan):
#   eth0: link ke Gendou
#   eth1: Switch-Terminal
#   eth2: link ke Maya
#   eth3: link ke Toji

[ "$(id -u)" = 0 ] || { echo "Harus root"; exit 1; }

if [ "$1" = cek ]; then hostname; ip -br a; ip route; exit 0; fi

### SOAL 3: routing statis (default ke atas + rute subnet di bawah, sudah diringkas)
ip route replace default via 10.84.4.145
ip route replace 10.84.3.192/27 via 10.84.4.126   # cabang Maya
ip route replace 10.84.4.72/29 via 10.84.4.154   # cabang Toji
ip route
### SOAL 4+: NAT/firewall (khusus Gendou)  (diisi nanti)
