#!/bin/sh
# /root/soal17_zeruel.sh  --  SOAL 17: listener TCP 9000 (Zeruel)
[ "$(id -u)" = 0 ] || { echo "Harus root"; exit 1; }
PORT=9000
LOG=/root/received_$PORT.log

if [ "$1" = cek ]; then
  hostname
  ss -ltn 2>/dev/null | grep ":$PORT "
  echo "== pesan yang diterima di port $PORT"
  cat $LOG 2>/dev/null
  exit 0
fi

# butuh nc; pasang netcat-traditional bila belum ada (internet lewat Gendou, DNS dari soal4)
if ! command -v nc >/dev/null 2>&1; then
  command -v apt-get >/dev/null 2>&1 && { apt-get update -qq; apt-get install -y -qq netcat-traditional; }
fi
command -v nc >/dev/null 2>&1 || { echo "nc tidak tersedia di node ini"; exit 1; }

if ss -ltn 2>/dev/null | grep -q ":$PORT "; then echo "listener $PORT sudah jalan"; exit 0; fi
nohup sh -c "while true; do nc -l -p $PORT >> $LOG 2>&1; done" >/dev/null 2>&1 &
sleep 1
ss -ltn 2>/dev/null | grep ":$PORT "