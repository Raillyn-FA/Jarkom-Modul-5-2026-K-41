#!/bin/sh
# /root/soal5_gendou.sh  --  SOAL 5: kunci NAT1 (policy DROP + pengecualian)  (Router Gendou)
[ "$(id -u)" = 0 ] || { echo "Harus root"; exit 1; }
WAN=eth0               # sisi NAT1
INT=10.84.0.0/16       # prefix internal kelompok

if [ "$1" = cek ]; then
  iptables -S
  iptables -L INPUT -n -v
  iptables -L FORWARD -n -v
  exit 0
fi

command -v iptables >/dev/null 2>&1 || { echo "iptables belum terpasang (jalankan soal 4)"; exit 1; }

# Kosongkan hanya chain INPUT dan FORWARD (tabel nat milik soal 4 tidak disentuh)
iptables -F INPUT
iptables -F FORWARD

# ---- INPUT (paket yang ditujukan ke Gendou sendiri)
iptables -A INPUT -i lo -j ACCEPT                                              # loopback
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT         # (a) balasan koneksi yang sudah ada
iptables -A INPUT -i $WAN -p udp --sport 67 --dport 68 -j ACCEPT               # DHCP dari NAT1
iptables -A INPUT ! -i $WAN -s $INT -j ACCEPT                                  # (d) internal -> Gendou

# ---- FORWARD (paket yang hanya lewat)
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT       # (a) balasan koneksi yang sudah ada
iptables -A FORWARD ! -i $WAN -s $INT -o $WAN -j ACCEPT                        # (b) internal -> internet
iptables -A FORWARD ! -i $WAN ! -o $WAN -s $INT -d $INT -j ACCEPT              # (c) antar-LAN

# Policy dipasang terakhir, setelah semua pengecualian siap
iptables -P INPUT DROP
iptables -P FORWARD DROP

iptables -S