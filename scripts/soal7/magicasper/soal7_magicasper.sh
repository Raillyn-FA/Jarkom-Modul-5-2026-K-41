#!/bin/sh
# /root/soal7_magicasper.sh  --  SOAL 7: pasang iptables + netcat-traditional, nyalakan listener  (Magi-Casper, 10.84.4.58)
[ "$(id -u)" = 0 ] || { echo "Harus root"; exit 1; }
PORTS="5000"          # port TCP listener sesuai glosarium soal

if [ "$1" = cek ]; then
  hostname; ip -br a
  echo "== listener"; ss -ltn 2>/dev/null | grep -E ":($(echo $PORTS | tr ' ' '|')) "
  for p in $PORTS; do echo "== pesan yang diterima di port $p"; cat /root/received_$p.log 2>/dev/null; done
  exit 0
fi

# 1) paket (butuh internet lewat Gendou dan DNS dari soal4_dns.sh)
if ! command -v apt-get >/dev/null 2>&1; then echo "apt-get tidak ada di node ini"; exit 1; fi
if ! command -v iptables >/dev/null 2>&1 || ! dpkg -s netcat-traditional >/dev/null 2>&1; then
  apt-get update -qq && apt-get install -y -qq iptables netcat-traditional || { echo "Instal paket gagal (cek DNS dan internet)"; exit 1; }
fi
# pastikan 'nc' memakai versi traditional
update-alternatives --set nc /bin/nc.traditional >/dev/null 2>&1

# 2) listener: tiap port diulang agar tetap menerima setelah satu koneksi selesai
for p in $PORTS; do
  if ss -ltn 2>/dev/null | grep -q ":$p "; then echo "listener $p sudah jalan"; continue; fi
  nohup sh -c "while true; do nc -l -p $p >> /root/received_$p.log 2>&1; done" >/dev/null 2>&1 &
  echo "listener TCP $p dinyalakan"
done
sleep 1
ss -ltn 2>/dev/null | grep -E ":($(echo $PORTS | tr ' ' '|')) "
