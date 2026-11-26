#!/bin/sh
# /root/soal12_magicasper.sh  --  SOAL 12: perbaikan hardening Casper (kumulatif, memuat juga soal 11)
[ "$(id -u)" = 0 ] || { echo "Harus root"; exit 1; }

if [ "$1" = cek ]; then
  hostname
  iptables -S
  iptables -L INPUT -n -v
  iptables -L OUTPUT -n -v
  exit 0
fi

command -v iptables >/dev/null 2>&1 || { echo "iptables belum terpasang (jalankan soal 7)"; exit 1; }

# Bangun ulang INPUT dan OUTPUT dari nol. Policy sementara ACCEPT agar tidak terkunci saat chain dikosongkan.
iptables -P INPUT ACCEPT
iptables -F INPUT
iptables -F OUTPUT

iptables -A INPUT -i lo -j ACCEPT                                          # loopback
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT     # balasan untuk koneksi/ping/DNS yang Casper mulai sendiri
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP                 # soal 11: tidak ada yang boleh mem-ping Casper
iptables -A INPUT -p tcp --dport 5000 -j ACCEPT                            # layanan TCP 5000 tetap hidup

iptables -P INPUT DROP                                                     # tujuan hardening: semua masuk yang tidak diizinkan ditolak
iptables -P OUTPUT ACCEPT                                                  # Casper bebas keluar (DNS, apt, ping)

iptables -S