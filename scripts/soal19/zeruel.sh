#!/bin/sh
# /root/soal19_zeruel.sh  --  SOAL 19: isolasi Armisael dari sisi tetangga satu switch  (Zeruel)
# Armisael dan Zeruel satu switch, jadi lalu lintas di antara keduanya tidak melewati Shigeru.
# Aturan dipasang di Zeruel (bukan di Armisael) dan hanya menyentuh alamat Armisael; Zeruel ke tujuan lain bebas.
[ "$(id -u)" = 0  ] || { echo "Harus root"; exit 1; }
ARM=10.84.4.83               # Armisael

if [ "$1" = cek ]; then
  hostname
  echo "== INPUT";  iptables -L INPUT -n -v
  echo "== OUTPUT"; iptables -L OUTPUT -n -v
  exit 0
fi

if ! command -v iptables >/dev/null 2>&1; then
  apt-get update -qq; apt-get install -y -qq iptables || { echo "iptables gagal dipasang"; exit 1; }
fi
iptables -t nat -S >/dev/null 2>&1 || update-alternatives --set iptables /usr/sbin/iptables-legacy >/dev/null 2>&1

add() { iptables -C "$@" 2>/dev/null || iptables -I "$@"; }
add INPUT  -s $ARM -j DROP      # Armisael -> Zeruel (termasuk ping dan nc)
add OUTPUT -d $ARM -j DROP      # Zeruel -> Armisael (termasuk balasan)

iptables -S INPUT
iptables -S OUTPUT