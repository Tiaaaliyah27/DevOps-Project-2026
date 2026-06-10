#!/bin/bash

echo "===== Server Performance Stats ====="
echo

echo "OS Version:"
grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"'
echo

echo "Uptime:"
uptime -p
echo

echo "Load Average:"
uptime | awk -F'load average:' '{print $2}'
echo

echo "CPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print "Used: " 100 - $8 "%"}'
echo

echo "Memory Usage:"
free -h
free | awk '/Mem:/ {printf "Used: %s / Total: %s (%.2f%%)\n", $3, $2, $3/$2 * 100}'
echo

echo "Disk Usage:"
df -h --total | grep -E 'Filesystem|total'
echo

echo "Top 5 Processes by CPU:"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6
echo

echo "Top 5 Processes by Memory:"
ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 6
echo

echo "Logged In Users:"
who
