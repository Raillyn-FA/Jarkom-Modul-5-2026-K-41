#!/bin/sh
# /root/magicasper.sh  --  Magi-Casper: soal 6 (IP), DNS, soal 7 (paket + listener) berurutan
# Argumen "cek" diteruskan ke tiap bagian (hanya menampilkan bukti).
sh /root/soal6_magicasper.sh "$@"
sh /root/soal4_dns.sh "$@"
sh /root/soal7_magicasper.sh "$@"
