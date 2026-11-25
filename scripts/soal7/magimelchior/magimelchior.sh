#!/bin/sh
# /root/magimelchior.sh  --  Magi-Melchior: soal 6 (IP), DNS, soal 7 (paket + listener) berurutan
# Argumen "cek" diteruskan ke tiap bagian (hanya menampilkan bukti).
sh /root/soal6_magimelchior.sh "$@"
sh /root/soal4_dns.sh "$@"
sh /root/soal7_magimelchior.sh "$@"
