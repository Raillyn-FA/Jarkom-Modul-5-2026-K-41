#!/bin/sh
# /root/soal4_fuyutsuki.sh  --  SOAL 4: DNS agar node bisa me-resolve nama domain (Router Fuyutsuki)
[ "$(id -u)" = 0 ] || { echo "Harus root"; exit 1; }

if [ "$1" = cek ]; then cat /etc/resolv.conf; exit 0; fi

printf 'nameserver 8.8.8.8\nnameserver 8.8.4.4\n' > /etc/resolv.conf
cat /etc/resolv.conf
