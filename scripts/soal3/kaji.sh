#!/bin/sh
# /root/kaji.sh  --  Router Kaji  (K-41, Operation Geofront)
# Skrip kumulatif: soal 2 sekarang, bagian soal 3 dst. ditambah di bawah.
# Pengkabelan GNS3 (adapter -> tujuan):
#   eth0: link ke Gendou
#   eth1: Switch-Intel

[ "$(id -u)" = 0 ] || { echo "Harus root"; exit 1; }

if [ "$1" = cek ]; then hostname; ip -br a; ip route; exit 0; fi

### SOAL 3: routing statis (default ke atas + rute subnet di bawah, sudah diringkas)
ip route replace default via 10.84.4.169
ip route
### SOAL 4+: NAT/firewall (khusus Gendou)  (diisi nanti)
