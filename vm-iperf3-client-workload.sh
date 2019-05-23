localhost:~# cat /srv/workload.sh
#!/bin/sh

BANDWIDTH=1048576
IP=`ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{print $1}'`
IP_LAST_PART=`echo $IP | rev | cut -d "." -f1 | rev`
IP_NO_LAST_PART=`echo $IP | sed 's/\.[^.]*$//'`
CMD="iperf3 -c ${IP_NO_LAST_PART}.$(($IP_LAST_PART + 1)) -t 1"

while true; do
  BW_RATIO=$(((RANDOM%10)+1))
  $CMD -b $((BANDWIDTH*BW_RATIO)) > /dev/null 2>&1
  sleep $(((RANDOM%40)+1))
done

---- ends up being:
iperf3 -c 169.254.0.170 -t 1
