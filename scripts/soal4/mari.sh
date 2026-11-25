#!/bin/sh
# /root/mari.sh  --  Router Mari: menjalankan semua bagian berurutan (soal 2, 3, 4)
# Argumen "cek" diteruskan ke tiap bagian (hanya menampilkan bukti, tidak mengubah konfigurasi).
sh /root/soal2_mari.sh "$@"
sh /root/soal3_mari.sh "$@"
sh /root/soal4_mari.sh "$@"
