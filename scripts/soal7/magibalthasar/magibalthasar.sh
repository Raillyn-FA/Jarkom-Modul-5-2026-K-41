#!/bin/sh
# /root/magibalthasar.sh  --  Magi-Balthasar: soal 6 (IP), DNS, soal 7 (paket + listener) berurutan
# Argumen "cek" diteruskan ke tiap bagian (hanya menampilkan bukti).
sh /root/soal6_magibalthasar.sh "$@"
sh /root/soal4_dns.sh "$@"
sh /root/soal7_magibalthasar.sh "$@"
