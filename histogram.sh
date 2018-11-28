#!/bin/bash

echo "==========================="
echo -e "Histogram of used commands:\n"

commands_count=$(cat /tmp/time.log | grep -v -E "(^$|real|user|sys|===)" | sort | uniq -c | sort -n)

echo "$commands_count"
