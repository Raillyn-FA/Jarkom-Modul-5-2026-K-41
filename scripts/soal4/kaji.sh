#!/bin/sh
# /root/kaji.sh  --  Router Kaji: menjalankan semua bagian berurutan (soal 2, 3, 4)
# Argumen "cek" diteruskan ke tiap bagian (hanya menampilkan bukti, tidak mengubah konfigurasi).
sh /root/soal2_kaji.sh "$@"
sh /root/soal3_kaji.sh "$@"
sh /root/soal4_kaji.sh "$@"
