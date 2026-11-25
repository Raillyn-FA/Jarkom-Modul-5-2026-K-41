#!/bin/sh
# /root/shigeru.sh  --  Router Shigeru: menjalankan semua bagian berurutan (soal 2, 3, 4)
# Argumen "cek" diteruskan ke tiap bagian (hanya menampilkan bukti, tidak mengubah konfigurasi).
sh /root/soal2_shigeru.sh "$@"
sh /root/soal3_shigeru.sh "$@"
sh /root/soal4_shigeru.sh "$@"
