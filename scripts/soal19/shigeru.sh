#!/bin/sh
# /root/soal19_shigeru.sh  --  SOAL 19: isolasi Armisael dari sisi Shigeru  (Router Shigeru)
[ "$(id -u)" = 0 ] || { echo "Harus root"; exit 1; }
ARM=10.84.4.83               # Armisael

if [ "$1" = cek ]; then
  hostname
  echo "== FORWARD";  iptables -L FORWARD -n -v
  echo "== INPUT";    iptables -L INPUT -n -v
  echo "== OUTPUT";   iptables -L OUTPUT -n -v
  exit 0
fi

if ! command -v iptables >/dev/null 2>&1; then
  apt-get update -qq; apt-get install -y -qq iptables || { echo "iptables gagal dipasang"; exit 1; }
fi
iptables -t nat -S >/dev/null 2>&1 || update-alternatives --set iptables /usr/sbin/iptables-legacy >/dev/null 2>&1

# Cek dulu (-C) baru sisipkan (-I): aman dijalankan ulang, dan selalu di atas aturan lain (termasuk ZONA soal 18).
add() { iptables -C "$@" 2>/dev/null || iptables -I "$@"; }
add FORWARD -s $ARM -j DROP     # Armisael -> Lilith, Seele, Radar, dst. (keluar)
add FORWARD -d $ARM -j DROP     # siapa pun -> Armisael (masuk)
add INPUT   -s $ARM -j DROP     # Armisael -> Shigeru sendiri (gateway-nya)
add OUTPUT  -d $ARM -j DROP     # Shigeru -> Armisael (balasan dan ping dari gateway)

iptables -S FORWARD
iptables -S INPUT
iptables -S OUTPUT