#!/bin/sh
# /root/fuyutsuki.sh  --  Router Fuyutsuki: menjalankan semua bagian berurutan (soal 2, 3, 4)
# Argumen "cek" diteruskan ke tiap bagian (hanya menampilkan bukti, tidak mengubah konfigurasi).
sh /root/soal2_fuyutsuki.sh "$@"
sh /root/soal3_fuyutsuki.sh "$@"
sh /root/soal4_fuyutsuki.sh "$@"
