#!/bin/sh
# /root/asuka.sh  --  Router Asuka: menjalankan semua bagian berurutan (soal 2, 3, 4)
# Argumen "cek" diteruskan ke tiap bagian (hanya menampilkan bukti, tidak mengubah konfigurasi).
sh /root/soal2_asuka.sh "$@"
sh /root/soal3_asuka.sh "$@"
sh /root/soal4_asuka.sh "$@"
