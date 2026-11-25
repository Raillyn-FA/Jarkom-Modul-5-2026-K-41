#!/bin/sh
# /root/gendo.sh  --  Router Gendou: menjalankan semua bagian berurutan (soal 2, 3, 4)
# Argumen "cek" diteruskan ke tiap bagian (hanya menampilkan bukti, tidak mengubah konfigurasi).
sh /root/soal2_gendo.sh "$@"
sh /root/soal3_gendo.sh "$@"
sh /root/soal4_gendo.sh "$@"
# soal 5 (firewall) ditambahkan di sini nanti: soal5_gendo.sh
