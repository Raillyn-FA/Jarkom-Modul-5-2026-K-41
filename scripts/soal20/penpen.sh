#!/bin/sh
# SOAL 20: uji kebakaran (Pen-Pen). Pakai: simpan | hapus | pulih | hitung
NAMA=penpen
case "$1" in
  simpan)
    iptables-save > /root/$NAMA.rules
    echo "tersimpan: /root/$NAMA.rules ($(wc -l < /root/$NAMA.rules) baris)" ;;
  hapus)
    iptables -F; iptables -X
    iptables -t nat -F; iptables -t nat -X
    iptables -t mangle -F 2>/dev/null; iptables -t mangle -X 2>/dev/null
    iptables -P INPUT ACCEPT; iptables -P FORWARD ACCEPT; iptables -P OUTPUT ACCEPT
    ip route del default 2>/dev/null
    echo "semua aturan iptables (termasuk nat) dan rute dihapus" ;;
  pulih)
    iptables-restore < /root/$NAMA.rules && sh /root/$NAMA.sh
    echo "pemulihan selesai" ;;
  hitung)
    echo "iptables -S        : $(iptables -S | wc -l) baris"
    echo "iptables -t nat -S : $(iptables -t nat -S | wc -l) baris"
    echo "rute default       : $(ip route | grep -c '^default') baris"
    ip route ;;
  *) echo "pakai: sh $0 simpan|hapus|pulih|hitung" ;;
esac
