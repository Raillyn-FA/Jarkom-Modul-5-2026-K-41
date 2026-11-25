#!/bin/sh
# /root/makoto.sh  --  Router Makoto: menjalankan semua bagian berurutan (soal 2, 3, 4)
# Argumen "cek" diteruskan ke tiap bagian (hanya menampilkan bukti, tidak mengubah konfigurasi).
sh /root/soal2_makoto.sh "$@"
sh /root/soal3_makoto.sh "$@"
sh /root/soal4_makoto.sh "$@"
