#!/bin/sh
# /root/maya.sh  --  Router Maya: menjalankan semua bagian berurutan (soal 2, 3, 4)
# Argumen "cek" diteruskan ke tiap bagian (hanya menampilkan bukti, tidak mengubah konfigurasi).
sh /root/soal2_maya.sh "$@"
sh /root/soal3_maya.sh "$@"
sh /root/soal4_maya.sh "$@"
