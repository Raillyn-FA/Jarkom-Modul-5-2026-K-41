#!/bin/sh
# /root/misato.sh  --  Router Misato: menjalankan semua bagian berurutan (soal 2, 3, 4)
# Argumen "cek" diteruskan ke tiap bagian (hanya menampilkan bukti, tidak mengubah konfigurasi).
sh /root/soal2_misato.sh "$@"
sh /root/soal3_misato.sh "$@"
sh /root/soal4_misato.sh "$@"
