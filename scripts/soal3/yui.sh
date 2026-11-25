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

if [ "$1" = cek ]; then hostname; ip -br a; ip route; exit 0; fi

### SOAL 3: routing statis (default ke atas + rute subnet di bawah, sudah diringkas)
ip route replace default via 10.84.4.117
ip route replace 10.84.4.32/28 via 10.84.4.138   # cabang Mari
ip route replace 10.84.0.0/23 via 10.84.4.110   # cabang Rei
ip route replace 10.84.4.0/27 via 10.84.4.134   # cabang Shinji
ip route
### SOAL 4+: NAT/firewall (khusus Gendou)  (diisi nanti)
