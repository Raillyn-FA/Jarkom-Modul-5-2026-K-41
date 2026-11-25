#!/bin/sh
# /root/rei.sh  --  Router Rei: menjalankan semua bagian berurutan (soal 2, 3, 4)
# Argumen "cek" diteruskan ke tiap bagian (hanya menampilkan bukti, tidak mengubah konfigurasi).
sh /root/soal2_rei.sh "$@"
sh /root/soal3_rei.sh "$@"
sh /root/soal4_rei.sh "$@"
