#!/bin/sh
# SOAL 6: IP statis + gateway (Garden-Staff), PERMANEN
IP=10.84.4.2; PREFIX=27; MASK=255.255.255.224; GW=10.84.4.1

if [ "$1" = cek ]; then
  hostname; ip -br a; ip route
  echo "== ping gateway $GW"; ping -c 3 -W 1 $GW
  exit 0
fi

# 1) simpan permanen 
cat > /etc/network/interfaces <<CONF
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address $IP
    netmask $MASK
    gateway $GW
CONF

# 2) terapkan sekarang juga
ip link set eth0 up
ip -4 addr flush dev eth0
ip addr add $IP/$PREFIX dev eth0
ip route del default 2>/dev/null
ip route add default via $GW
ip -br a
ip route
