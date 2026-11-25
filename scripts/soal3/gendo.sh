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

if [ "$1" = cek ]; then hostname; ip -br a; ip route; exit 0; fi

### SOAL 3: routing statis (default ke atas + rute subnet di bawah, sudah diringkas)
# Gendou: default route ke NAT1 diambil dari DHCP (tidak ditulis manual, soal 4)
ip route show default | grep -q '^default' || echo 'PERINGATAN: default route dari NAT1 belum ada'
ip route replace 10.84.3.128/26 via 10.84.4.166   # cabang Asuka
ip route replace 10.84.4.48/29 via 10.84.4.166   # cabang Asuka
ip route replace 10.84.4.96/30 via 10.84.4.166   # cabang Asuka
ip route replace 10.84.4.120/30 via 10.84.4.166   # cabang Asuka
ip route replace 10.84.4.140/30 via 10.84.4.166   # cabang Asuka
ip route replace 10.84.3.192/27 via 10.84.4.146   # cabang Fuyutsuki
ip route replace 10.84.4.56/29 via 10.84.4.146   # cabang Fuyutsuki
ip route replace 10.84.4.72/29 via 10.84.4.146   # cabang Fuyutsuki
ip route replace 10.84.4.124/30 via 10.84.4.146   # cabang Fuyutsuki
ip route replace 10.84.4.152/30 via 10.84.4.146   # cabang Fuyutsuki
ip route replace 10.84.2.0/24 via 10.84.4.114   # cabang Hikari
ip route replace 10.84.3.224/27 via 10.84.4.114   # cabang Hikari
ip route replace 10.84.4.128/30 via 10.84.4.114   # cabang Hikari
ip route replace 10.84.4.100/30 via 10.84.4.170   # cabang Kaji
ip route replace 10.84.4.64/29 via 10.84.4.150   # cabang Misato
ip route replace 10.84.4.80/28 via 10.84.4.158   # cabang Shigeru
ip route replace 10.84.4.160/30 via 10.84.4.158   # cabang Shigeru
ip route replace 10.84.0.0/23 via 10.84.4.118   # cabang Yui
ip route replace 10.84.3.0/25 via 10.84.4.118   # cabang Yui
ip route replace 10.84.4.0/27 via 10.84.4.118   # cabang Yui
ip route replace 10.84.4.32/28 via 10.84.4.118   # cabang Yui
ip route replace 10.84.4.108/30 via 10.84.4.118   # cabang Yui
ip route replace 10.84.4.132/30 via 10.84.4.118   # cabang Yui
ip route replace 10.84.4.136/30 via 10.84.4.118   # cabang Yui
ip route
### SOAL 4+: NAT/firewall (khusus Gendou)  (diisi nanti)
