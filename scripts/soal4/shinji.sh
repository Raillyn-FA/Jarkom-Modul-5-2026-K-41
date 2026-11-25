#!/bin/sh
# /root/shinji.sh  --  Router Shinji: menjalankan semua bagian berurutan (soal 2, 3, 4)
# Argumen "cek" diteruskan ke tiap bagian (hanya menampilkan bukti, tidak mengubah konfigurasi).
sh /root/soal2_shinji.sh "$@"
sh /root/soal3_shinji.sh "$@"
sh /root/soal4_shinji.sh "$@"
