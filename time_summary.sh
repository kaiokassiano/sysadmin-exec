#!/bin/bash

sum_sys_decimal=$(cat /tmp/time.log | grep sys | awk -Fm '{print $2}' | awk -Fs '{print $1}' | awk '{sum+=$1} END {printf "%.3f", sum}')
sum_user_decimal=$(cat /tmp/time.log | grep user | awk -Fm '{print $2}' | awk -Fs '{print $1}' | awk '{sum+=$1} END {printf "%.3f", sum}')

sum_sys_integer=$(cat /tmp/time.log | grep sys | awk -Fm '{print $1}' | awk '{print $2}' | awk '{sum+=$1} END {printf "%d", sum}')
sum_user_integer=$(cat /tmp/time.log | grep sys | awk -Fm '{print $1}' | awk '{print $2}' | awk '{sum+=$1} END {printf "%d", sum}')

total_sys=$(echo "scale=3;($sum_sys_integer * 60) + $sum_sys_decimal" | bc | awk '{printf "%.3f\n", $0}')
total_user=$(echo "scale=3;($sum_user_integer * 60) + $sum_user_decimal" | bc | awk '{printf "%.3f\n", $0}')

echo "sys: ${total_sys}s"
echo "user: ${total_user}s"

echo -e "=========\nhistogram:"
commands_count=$(cat /tmp/time.log | grep -v === | grep -v -e "^$" | grep -v real | grep -v user | grep -v sys | sort | uniq -c | sort)
echo "$commands_count"
