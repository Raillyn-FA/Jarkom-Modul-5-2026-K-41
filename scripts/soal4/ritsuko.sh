#!/bin/sh
# /root/ritsuko.sh  --  Router Ritsuko: menjalankan semua bagian berurutan (soal 2, 3, 4)
# Argumen "cek" diteruskan ke tiap bagian (hanya menampilkan bukti, tidak mengubah konfigurasi).
sh /root/soal2_ritsuko.sh "$@"
sh /root/soal3_ritsuko.sh "$@"
sh /root/soal4_ritsuko.sh "$@"
