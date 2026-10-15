#!/bin/bash

# disk-monitor.sh - Monitor disk usage
# DevOps Apprentice - Week 2 Day 2

THRESHOLD=80
EMAIL="your-email@example.com"

echo "=========================================="
echo "     DISK USAGE MONITOR"
echo "=========================================="
echo ""

df -h | awk 'NR==1 || /^\/dev/' | while read -r filesystem size used avail percent mount; do
    if [ "$filesystem" = "Filesystem" ]; then
        printf "%-20s %-8s %-8s %-8s %-8s %s\n" "Filesystem" "Size" "Used" "Avail" "Use%" "Mounted"
        printf "%-20s %-8s %-8s %-8s %-8s %s\n" "--------" "----" "----" "-----" "----" "-------"
        continue
    fi
    
    # Extract number from percentage
    usage_num=$(echo "$percent" | tr -d '%')
    
    if [ "$usage_num" -ge "$THRESHOLD" ]; then
        status="⚠️ WARNING"
    else
        status="✅ OK"
    fi
    
    printf "%-20s %-8s %-8s %-8s %-8s %s %s\n" "$filesystem" "$size" "$used" "$avail" "$percent" "$mount" "$status"
done

echo ""
echo "Partitions above ${THRESHOLD}% usage:"
df -h | awk -v thresh="$THRESHOLD" 'NR>1 && /^\/dev/ {
    gsub(/%/,""); 
    if ($5 >= thresh) print "⚠️ " $1 ": " $5 "% full"
}'
