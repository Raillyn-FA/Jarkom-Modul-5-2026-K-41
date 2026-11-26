#!/bin/sh
# /root/soal17_fuyutsuki.sh  --  SOAL 17: koneksi TCP Casper -> Zeruel dialihkan (DNAT) ke Pen-Pen  (Router Fuyutsuki)
[ "$(id -u)" = 0 ] || { echo "Harus root"; exit 1; }
CASPER=10.84.4.58
ZERUEL=10.84.4.82
PENPEN=10.84.3.194

if [ "$1" = cek ]; then
  hostname
  iptables -t nat -S PREROUTING
  iptables -t nat -L PREROUTING -n -v
  echo "== tabel conntrack (TCP)"
  if command -v conntrack >/dev/null 2>&1; then conntrack -L -p tcp 2>/dev/null; else cat /proc/net/nf_conntrack 2>/dev/null; fi
  exit 0
fi

# paket yang dibutuhkan (internet lewat Gendou, DNS dari soal4)
need=""
command -v iptables  >/dev/null 2>&1 || need="$need iptables"
command -v conntrack >/dev/null 2>&1 || need="$need conntrack"
if [ -n "$need" ]; then
  apt-get update -qq; apt-get install -y -qq $need || echo "PERINGATAN: gagal memasang:$need"
fi
command -v iptables >/dev/null 2>&1 || { echo "iptables belum terpasang"; exit 1; }
iptables -t nat -S >/dev/null 2>&1 || update-alternatives --set iptables /usr/sbin/iptables-legacy >/dev/null 2>&1

# Hanya TCP dari Casper yang menuju Zeruel; ping (ICMP) dan sumber lain tidak tersentuh.
# DNAT di PREROUTING: tujuan diganti ke Pen-Pen. Balasan Pen-Pen lewat Fuyutsuki lagi, dan
# conntrack otomatis mengembalikan alamat sumbernya menjadi Zeruel, jadi Casper tidak curiga.
# Tanpa SNAT/MASQUERADE: Pen-Pen melihat sumber asli (Casper).
iptables -t nat -C PREROUTING -s $CASPER -d $ZERUEL -p tcp -j DNAT --to-destination $PENPEN 2>/dev/null || \
  iptables -t nat -I PREROUTING 1 -s $CASPER -d $ZERUEL -p tcp -j DNAT --to-destination $PENPEN

iptables -t nat -S PREROUTING