#!/bin/sh
# /root/hikari.sh  --  Router Hikari: menjalankan semua bagian berurutan (soal 2, 3, 4)
# Argumen "cek" diteruskan ke tiap bagian (hanya menampilkan bukti, tidak mengubah konfigurasi).
sh /root/soal2_hikari.sh "$@"
sh /root/soal3_hikari.sh "$@"
sh /root/soal4_hikari.sh "$@"
