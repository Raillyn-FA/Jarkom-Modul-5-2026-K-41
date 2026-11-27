#!/bin/sh
# /root/soal18_shigeru.sh  --  SOAL 18: gerbang zona sensitif Monolith dan Radar  (Router Shigeru)
[ "$(id -u)" = 0 ] || { echo "Harus root"; exit 1; }
UP=eth0                      # sisi Shigeru yang menghadap Gendou (arah "luar")
TERMINAL=10.84.4.56/29       # subnet Switch-Terminal (pengecualian: boleh mem-ping zona)

if [ "$1" = cek ]; then
  hostname
  iptables -S FORWARD
  iptables -L ZONA -n -v
  exit 0
fi

# paket yang dibutuhkan (internet lewat Gendou, DNS dari soal4)
if ! command -v iptables >/dev/null 2>&1; then
  apt-get update -qq; apt-get install -y -qq iptables || { echo "iptables gagal dipasang"; exit 1; }
fi
iptables -t nat -S >/dev/null 2>&1 || update-alternatives --set iptables /usr/sbin/iptables-legacy >/dev/null 2>&1

# Chain sendiri (ZONA) supaya rapi, counter terlihat, dan aman dijalankan ulang.
iptables -N ZONA 2>/dev/null
iptables -F ZONA
iptables -A ZONA -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT                 # balasan untuk koneksi yang dimulai dari dalam zona
iptables -A ZONA -s $TERMINAL -p icmp --icmp-type echo-request -j ACCEPT              # satu-satunya pengecualian: ping dari Terminal
iptables -A ZONA -j DROP                                                              # koneksi baru dari luar ke dalam zona ditolak

# Semua yang MASUK lewat sisi Gendou diperiksa chain ZONA. Berdasarkan arah (interface), bukan daftar subnet,
# jadi subnet baru di luar zona otomatis ikut terblokir. Lalu lintas yang dimulai dari zona tidak diperiksa.
while iptables -D FORWARD -i $UP -j ZONA 2>/dev/null; do :; done
iptables -I FORWARD 1 -i $UP -j ZONA

iptables -S FORWARD
iptables -S ZONA