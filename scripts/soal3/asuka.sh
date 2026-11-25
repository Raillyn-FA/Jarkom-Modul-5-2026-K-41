#!/bin/sh
# /root/asuka.sh  --  Router Asuka  (K-41, Operation Geofront)
# Skrip kumulatif: soal 2 sekarang, bagian soal 3 dst. ditambah di bawah.
# Pengkabelan GNS3 (adapter -> tujuan):
#   eth0: link ke Gendou
#   eth1: Switch-Archive
#   eth2: link ke Ritsuko
#   eth3: link ke Kensuke

[ "$(id -u)" = 0 ] || { echo "Harus root"; exit 1; }

if [ "$1" = cek ]; then hostname; ip -br a; ip route; exit 0; fi

### SOAL 3: routing statis (default ke atas + rute subnet di bawah, sudah diringkas)
ip route replace default via 10.84.4.165
ip route replace 10.84.3.128/26 via 10.84.4.122   # cabang Kensuke
ip route replace 10.84.4.48/29 via 10.84.4.142   # cabang Ritsuko
ip route
### SOAL 4+: NAT/firewall (khusus Gendou)  (diisi nanti)
