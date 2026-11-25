#!/bin/sh
# /root/kaworu.sh  --  Router Kaworu: menjalankan semua bagian berurutan (soal 2, 3, 4)
# Argumen "cek" diteruskan ke tiap bagian (hanya menampilkan bukti, tidak mengubah konfigurasi).
sh /root/soal2_kaworu.sh "$@"
sh /root/soal3_kaworu.sh "$@"
sh /root/soal4_kaworu.sh "$@"
