#!/bin/bash

# log-analyzer.sh - Analyze log files
# DevOps Apprentice - Week 2 Day 4

LOG_FILE=$1

if [ -z "$LOG_FILE" ]; then
    echo "Usage: $0 <logfile>"
    exit 1
fi

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: $LOG_FILE not found!"
    exit 1
fi

echo "=========================================="
echo "     LOG ANALYSIS REPORT"
echo "=========================================="
echo "File: $LOG_FILE"
echo "Generated: $(date)"
echo ""

# Total lines
TOTAL=$(wc -l < "$LOG_FILE")
echo "📊 Total log entries: $TOTAL"

# Count by level
echo ""
echo "📈 Log Level Distribution:"
echo "-------------------------"
grep -c "INFO" "$LOG_FILE" 2>/dev/null | xargs -I{} echo "  INFO:    {}"
grep -c "WARN" "$LOG_FILE" 2>/dev/null | xargs -I{} echo "  WARN:    {}"
grep -c "ERROR" "$LOG_FILE" 2>/dev/null | xargs -I{} echo "  ERROR:   {}"

# Error details
echo ""
echo "❌ Error Details:"
echo "-----------------"
grep "ERROR" "$LOG_FILE" | while read -r line; do
    timestamp=$(echo "$line" | awk '{print $1, $2}')
    message=$(echo "$line" | cut -d' ' -f4-)
    echo "  [$timestamp] $message"
done

# Summary
ERROR_COUNT=$(grep -c "ERROR" "$LOG_FILE" 2>/dev/null || echo 0)
WARN_COUNT=$(grep -c "WARN" "$LOG_FILE" 2>/dev/null || echo 0)

echo ""
echo "🚨 ALERTS:"
if [ "$ERROR_COUNT" -gt 3 ]; then
    echo "  ⚠️ High error count: $ERROR_COUNT"
fi
if [ "$WARN_COUNT" -gt 2 ]; then
    echo "  ⚠️ Elevated warnings: $WARN_COUNT"
fi

echo ""
echo "=========================================="
