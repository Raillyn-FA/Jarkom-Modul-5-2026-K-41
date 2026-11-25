#!/bin/sh
# /root/yui.sh  --  Router Yui: menjalankan semua bagian berurutan (soal 2, 3, 4)
# Argumen "cek" diteruskan ke tiap bagian (hanya menampilkan bukti, tidak mengubah konfigurasi).
sh /root/soal2_yui.sh "$@"
sh /root/soal3_yui.sh "$@"
sh /root/soal4_yui.sh "$@"
