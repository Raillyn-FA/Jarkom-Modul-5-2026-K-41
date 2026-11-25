#!/bin/sh
# /root/soal4_gendo.sh  --  SOAL 4: NAT keluar lewat NAT1 (MASQUERADE) + DNS  (Router Gendou)
[ "$(id -u)" = 0 ] || { echo "Harus root"; exit 1; }
WAN=eth0               # interface ke NAT1 (IP-nya dari DHCP, bisa berganti)
INT=10.84.0.0/16       # prefix internal kelompok

if [ "$1" = cek ]; then
  iptables -t nat -S POSTROUTING
  iptables -t nat -L POSTROUTING -n -v
  ip route show default
  cat /etc/resolv.conf
  exit 0
fi

# Gendou sudah punya internet lewat DHCP NAT1, jadi boleh memasang iptables sendiri
if ! command -v iptables >/dev/null 2>&1; then
  (apt-get update -qq && apt-get install -y -qq iptables) >/dev/null 2>&1 || apk add -q iptables >/dev/null 2>&1
fi
command -v iptables >/dev/null 2>&1 || { echo "iptables gagal dipasang"; exit 1; }
# beberapa container gagal memakai backend nft; pindah ke legacy bila perlu
iptables -t nat -S >/dev/null 2>&1 || update-alternatives --set iptables /usr/sbin/iptables-legacy >/dev/null 2>&1

# MASQUERADE (bukan SNAT --to-source): tidak perlu diubah saat IP NAT1 berganti.
# Hanya sumber internal yang keluar lewat NAT1 yang diterjemahkan; antar-LAN tidak tersentuh.
iptables -t nat -C POSTROUTING -s $INT ! -d $INT -o $WAN -j MASQUERADE 2>/dev/null || \
  iptables -t nat -A POSTROUTING -s $INT ! -d $INT -o $WAN -j MASQUERADE
iptables -t nat -L POSTROUTING -n -v

# DNS: biarkan yang dari DHCP bila sudah ada
grep -q '^nameserver' /etc/resolv.conf 2>/dev/null || printf 'nameserver 8.8.8.8\nnameserver 8.8.4.4\n' > /etc/resolv.conf
cat /etc/resolv.conf
