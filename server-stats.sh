#!/bin/bash

echo "#################################################"
printf "%s\n" "1-Total CPU Usage" "2-Total memory usage (Free vs Used including percentage)" "3-Total disk usage (Free vs Used including percentage)" "4-Top 5 processes by CPU usage"\
	"5-Top 5 processes by memory usage" "6- Os-version" "7- Uptime & Load average" "8- No. of users logged in" 
echo "#################################################"

read -p "Enter your choice: " choice

case $choice in 
	1)
		grep "\bcpu\b" /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print "Total CPU Usage: " usage "%"}'
		;;
	2)
		echo "Memory Usage (Free vs Used) "
		free -m | awk 'NR==2 {print "Used: "($3/$2)*100 "%\nFree: "($4/$2)*100 "%" }'
		;;
	3)
		echo "Disk Usage (Free vs Used)"
		df -h / | awk 'NR==2 {print "Used space: " ($3/$2)*100 "%" "\nAvailable space: "($4/$2)*100 "%"}'
		;;
	4)	
		echo "Top 5 processes by CPU usage"
		ps -aux --sort=-%cpu | head -n 6 | awk 'NR==1 || NR <=11 {print $1 "\t", $2 "\t", $3}'
		;;	
	5)
		echo "Top 5 processes by memory usage"
		ps -aux --sort=-%mem | head -n 6 | awk 'NR==1 || NR <=11 {print $1 "\t", $2 "\t", $4}'
		;;
	6)
		echo "Os-Version"
		cat /etc/os-release | grep -E '^(NAME|VERSION)='
		;;
	7)
		echo "Uptime & load average"
		uptime
		;;
	8)
	       echo "No. of logged in users "
		w | awk "NR!=1 && NR!=2" | wc -l
       		;;	       


	*)
		echo -n "invalid"
		;;
esac

