#!/bin/sh
# /root/kensuke.sh  --  Router Kensuke: menjalankan semua bagian berurutan (soal 2, 3, 4)
# Argumen "cek" diteruskan ke tiap bagian (hanya menampilkan bukti, tidak mengubah konfigurasi).
sh /root/soal2_kensuke.sh "$@"
sh /root/soal3_kensuke.sh "$@"
sh /root/soal4_kensuke.sh "$@"
