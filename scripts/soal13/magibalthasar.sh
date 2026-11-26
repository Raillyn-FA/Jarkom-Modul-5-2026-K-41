#!/bin/sh
# /root/soal13_magibalthasar.sh  --  SOAL 13: brankas Balthasar (TCP 5000 dan 5001 hanya untuk Casper dan Pilot)
[ "$(id -u)" = 0 ] || { echo "Harus root"; exit 1; }

PORTS="5000,5001"
# Casper, lalu semua Pilot: Unit-01, Unit-02, Unit-00, Sachiel
ALLOWED="10.84.4.58 10.84.4.66 10.84.4.67 10.84.4.68 10.84.3.130"

if [ "$1" = cek ]; then
  hostname
  iptables -S INPUT
  iptables -L BRANKAS -n -v
  exit 0
fi

command -v iptables >/dev/null 2>&1 || { echo "iptables belum terpasang (jalankan soal 7)"; exit 1; }

# Chain sendiri supaya aturan rapi, counter terlihat, dan skrip aman dijalankan ulang.
iptables -N BRANKAS 2>/dev/null
iptables -F BRANKAS
for src in $ALLOWED; do
  iptables -A BRANKAS -s $src -j ACCEPT
done
# Sisanya (termasuk Melchior yang satu switch) ditolak seketika dengan TCP RST, bukan DROP:
# DROP membuat klien menunggu sampai timeout, REJECT membuatnya gagal langsung.
iptables -A BRANKAS -p tcp -j REJECT --reject-with tcp-reset   # -p tcp wajib untuk tcp-reset

# Hanya TCP 5000 dan 5001 yang dilewatkan ke chain ini; lalu lintas lain dan policy INPUT tidak disentuh.
# Hapus dulu semua lompatan lama (mencegah aturan dobel kalau skrip diulang), lalu pasang satu.
while iptables -D INPUT -p tcp -m multiport --dports $PORTS -j BRANKAS 2>/dev/null; do :; done
iptables -I INPUT 1 -p tcp -m multiport --dports $PORTS -j BRANKAS

iptables -S INPUT
iptables -S BRANKAS