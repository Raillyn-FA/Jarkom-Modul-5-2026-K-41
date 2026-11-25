# Jarkom-Modul-5-2026-K-41

|         Nama         |     NRP     |
|----------------------|-------------|
|Aliya Rahmadina       | 5027251056  |
|Rayhan Fadhilah Allayn| 5027251126  |

Bisa. Saya bagi berdasarkan **node yang dipegang**, supaya kalian tidak saling menimpa konfigurasi di project GNS3 yang sama. Aturan soal 9, 10, dan 12 juga lebih aman kalau satu orang memegang satu kelompok node.

## Pembagian

| Soal | Pemegang | Catatan |
|---|---|---|
| 1 | **Rayhan** | Hitung VLSM dan isi tabel/spreadsheet. **Aliya** memverifikasi hitungan, membuat gambar pohon IP, dan melingkari jalur Dummy-Plug ke Armisael. |
| 2, 3 | Berdua, **per cabang** | Rayhan: Gendou, Fuyutsuki, Maya, Toji, Shigeru, Makoto, Misato. Aliya: Hikari, Kaworu, Yui, Rei, Mari, Shinji, Asuka, Kensuke, Ritsuko, Kaji. Aliya juga memasang topologi dan menaikkan jumlah adapter di GNS3. |
| 4, 5 | **Rayhan** | Semuanya di Gendou (`gendo.sh`). |
| 6 | **Aliya** | IP statis semua node non-router, dibuat persisten. |
| 7 | **Rayhan** | MAGI. |
| 8 | **Aliya** | Listener Pen-Pen dan Tokyo3-Core. |
| 9 | **Aliya** | Sabotase di Shigeru. |
| 10 | **Aliya** | Sabotase di Misato dan Gendou. |
| 11, 12, 13 | **Rayhan** | Semuanya di MAGI (Casper dan Balthasar). |
| 14, 15, 16 | **Aliya** | Semuanya di Pen-Pen dan Tokyo3-Core. |
| 17, 18, 19 | **Rayhan** | Fuyutsuki, Shigeru, dan Zeruel (soal 19). |
| 20 | Berdua | Rayhan mengambil Gendou (router), Aliya dua node lain. |

Ide pembagiannya:
- Rayhan memegang MAGI, Gendou, Fuyutsuki, dan Shigeru.
- Aliya memegang Pen-Pen, Tokyo3-Core, dan semua node di cabang barat.

## Urutan yang perlu dijaga

1. **Soal 1 harus selesai dulu.** Semua soal berikutnya bergantung pada tabel VLSM. Selama Rayhan menghitung, Aliya bisa memasang topologi.
2. **Soal 9 sebelum soal 18 dan 19.** Aliya menjalankan sabotase di Shigeru lebih dulu. Baru setelah itu Rayhan memasang aturan firewall di Shigeru.
3. **Soal 10 sebelum Rayhan mengunci `gendo.sh`.** Perbaikan dari soal 10 harus dimasukkan ke `gendo.sh` supaya tidak hilang.
4. **Soal 7 sebelum soal 12.** Script `break_fw.sh` butuh `iptables` yang sudah terpasang.
5. **Backup di luar GNS3.** Simpan semua script `/root/<nama>.sh` dan catatan langkah di satu repo GitHub bersama, sesuai saran di soal.

## Jadwal kasar (deadline Kamis, 26 Nov, 23.59 WIB)

- **Senin (23 Nov):** soal 1 sampai 3.
- **Selasa (24 Nov):** soal 4 sampai 8.
- **Rabu (25 Nov):** soal 9 sampai 16.
- **Kamis (26 Nov):** soal 17 sampai 20, laporan, ekspor project, dan demo ke asisten.

Pembagian ini mengandaikan kalian punya waktu dan kemampuan yang kira-kira setara. Apakah ada soal yang salah satu dari kalian ingin atau tidak ingin pegang, atau jadwal kalian berbeda selama empat hari ini? Kalau ada, saya sesuaikan.