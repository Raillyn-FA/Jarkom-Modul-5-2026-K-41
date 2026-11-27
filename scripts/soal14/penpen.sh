#!/bin/sh
# SOAL 14: jadwal akses ke Pen-Pen (ping dan TCP 80)

PILOT_START=${PILOT_START:-08:00}
PILOT_STOP=${PILOT_STOP:-16:00}
PILOT_DAYS=${PILOT_DAYS:-Mon,Tue,Wed,Thu,Fri}
STAF_START=${STAF_START:-17:00}
STAF_STOP=${STAF_STOP:-23:00}

PILOT="10.84.4.66,10.84.4.67,10.84.4.68,10.84.3.130"   # Unit-01, Unit-02, Unit-00, Sachiel
STAF="10.84.4.74,10.84.4.75"                           # Lilith, Adam
DUMMY="10.84.4.50,10.84.4.51,10.84.4.102"              # Entry-Plug, Dummy-Plug, Spy

ipt(){ if [ "$DRYRUN" = 1 ]; then echo "iptables $*"; else iptables "$@"; fi; }
utc(){ h=${1%:*}; m=${1#*:}; h=${h#0}; h=${h:-0}; printf "%02d:%s" $(( (h + 17) % 24 )) "$m"; }

if [ "$1" = cek ]; then
  echo "UTC : $(date -u '+%a %H:%M')   WIB : $(date -u -d '+7 hours' '+%a %H:%M')"
  iptables -L JADWAL -n -v --line-numbers
  exit 0
fi

if [ "$DRYRUN" != 1 ]; then
  command -v iptables >/dev/null 2>&1 || apt-get install -y iptables >/dev/null 2>&1
  iptables -m time --help >/dev/null 2>&1 || { echo "modul time tidak tersedia"; exit 1; }
fi

PS=$(utc $PILOT_START); PE=$(utc $PILOT_STOP); SS=$(utc $STAF_START); SE=$(utc $STAF_STOP)
echo "Pilot : WIB $PILOT_START-$PILOT_STOP ($PILOT_DAYS)  =>  UTC $PS-$PE"
echo "Staf  : WIB $STAF_START-$STAF_STOP (tiap hari)      =>  UTC $SS-$SE"

deny(){ ipt -A JADWAL "$@" -p icmp -j REJECT --reject-with icmp-admin-prohibited
        ipt -A JADWAL "$@" -p tcp  -j REJECT --reject-with tcp-reset; }

ipt -N JADWAL 2>/dev/null
ipt -F JADWAL
deny -s $DUMMY                                                       # terduga: tidak pernah
ipt -A JADWAL -s $PILOT -m time --timestart $PS --timestop $PE --weekdays $PILOT_DAYS -j ACCEPT
deny -s $PILOT                                                       # pilot di luar jadwal
ipt -A JADWAL -s $STAF -m time --timestart $SS --timestop $SE -j ACCEPT
deny -s $STAF                                                        # staf di luar jadwal
ipt -A JADWAL -j RETURN                                              # lainnya: bebas

# pasang jump dari INPUT hanya untuk ping dan TCP 80 (sekali saja)
for r in "-p icmp --icmp-type echo-request" "-p tcp --dport 80"; do
  if [ "$DRYRUN" = 1 ]; then echo "iptables -I INPUT 1 $r -j JADWAL"
  else iptables -C INPUT $r -j JADWAL 2>/dev/null || iptables -I INPUT 1 $r -j JADWAL; fi
done
[ "$DRYRUN" = 1 ] || iptables -L JADWAL -n -v --line-numbers
