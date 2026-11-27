#!/bin/sh
# SOAL 20: uji kebakaran (Gendou). Pakai: simpan | hapus | pulih | hitung
[ "$(id -u)" = 0 ] || { echo "Harus root"; exit 1; }
NAMA=gendou
case "$1" in
  simpan)
    iptables-save > /root/$NAMA.rules || { echo "iptables-save gagal"; exit 1; }
    echo "tersimpan: /root/$NAMA.rules ($(wc -l < /root/$NAMA.rules) baris)" ;;
  hapus)
    for t in filter nat mangle; do
      iptables -t $t -F 2>/dev/null
      iptables -t $t -X 2>/dev/null
    done
    iptables -P INPUT ACCEPT; iptables -P FORWARD ACCEPT; iptables -P OUTPUT ACCEPT
    # dari DHCP NAT1 dibiarkan, supaya Gendou tidak kehilangan koneksinya ke NAT1.
    ip route show | while read -r baris; do
      case "$baris" in
        *"proto kernel"*) continue ;;
        default*) continue ;;
      esac
      ip route del $baris 2>/dev/null
    done
    echo "semua aturan iptables (termasuk nat) dan rute statis dihapus" ;;
  pulih)
    if iptables-restore < /root/$NAMA.rules; then
      if [ -f /root/$NAMA.sh ]; then sh /root/$NAMA.sh >/dev/null 2>&1; else echo "PERINGATAN: /root/$NAMA.sh tidak ada"; fi
      echo "pemulihan selesai"
    else
      echo "iptables-restore gagal"
    fi ;;
  hitung)
    echo "iptables -S        : $(iptables -S | wc -l) baris"
    echo "iptables -t nat -S : $(iptables -t nat -S | wc -l) baris"
    echo "ip route           : $(ip route | wc -l) baris"
    ip route ;;
  *) echo "pakai: sh $0 simpan|hapus|pulih|hitung" ;;
esac