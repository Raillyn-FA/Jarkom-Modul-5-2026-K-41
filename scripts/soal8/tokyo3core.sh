#!/bin/sh
# SOAL 8: listener Tokyo3-Core (port 80 dan 8080)
if [ "$1" = cek ]; then hostname; ip -br a; ps aux | grep "nc -l" | grep -v grep; exit 0; fi

# pasang nc kalau belum ada
command -v nc >/dev/null 2>&1 || { apt-get update && apt-get install -y netcat-traditional; }
Q=""; nc -h 2>&1 | grep -q -- "-q" && Q="-q 1"

pkill -f "nc -l -p" 2>/dev/null
nohup sh -c "while true; do echo \"Welcome to \$(hostname)\" | nc -l -p 80 $Q; done" >/dev/null 2>&1 &
nohup sh -c "while true; do echo \"syifa imutz\" | nc -l -p 8080 $Q; done" >/dev/null 2>&1 &
sleep 1
ps aux | grep "nc -l" | grep -v grep
