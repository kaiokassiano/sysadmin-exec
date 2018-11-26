#!/bin/bash

# sum of decimal values
sum_sys_decimal=$(cat /tmp/time.log | grep sys | awk -Fm '{print $2}' | awk -Fs '{print $1}' | awk '{sum+=$1} END {printf "%.3f", sum}')
sum_user_decimal=$(cat /tmp/time.log | grep user | awk -Fm '{print $2}' | awk -Fs '{print $1}' | awk '{sum+=$1} END {printf "%.3f", sum}')

# sum of integer values
sum_sys_integer=$(cat /tmp/time.log | grep sys | awk -Fm '{print $1}' | awk '{print $2}' | awk '{sum+=$1} END {printf "%d", sum}')
sum_user_integer=$(cat /tmp/time.log | grep sys | awk -Fm '{print $1}' | awk '{print $2}' | awk '{sum+=$1} END {printf "%d", sum}')

# calculate ammount of time of cpu spent, in seconds
total_sys=$(echo "scale=3;($sum_sys_integer * 60) + $sum_sys_decimal" | bc | awk '{printf "%.3f\n", $0}')
total_user=$(echo "scale=3;($sum_user_integer * 60) + $sum_user_decimal" | bc | awk '{printf "%.3f\n", $0}')

# print summary
echo "============================================"
echo -e "Summary of total CPU time used (in seconds):\n"
echo -e "\tuser: ${total_user}s"
echo -e "\tsys: ${total_sys}s"
