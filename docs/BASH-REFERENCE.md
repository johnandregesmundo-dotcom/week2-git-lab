# 🐚 Bash Scripting Reference

Complete guide sa Bash scripting na natutunan ko.

---

## 🏗️ Script Structure

```bash
#!/bin/bash
# script.sh - Description
# Author: Your Name
# Date: 2024-XX-XX

set -e  # Exit on error (recommended)

# Your code here
Gawing executable:

bash
chmod +x script.sh
./script.sh
📥 Variables
bash
NAME="Juan"
AGE=25
echo "Hello, $NAME!"                    # Hello, Juan!
echo "Age: ${AGE}"                      # Age: 25

# Command substitution
DATE=$(date +%Y-%m-%d)
FILES=$(ls)
Argument variables:

bash
$0    # Script name
$1    # First argument
$2    # Second argument
$#    # Number of arguments
$@    # All arguments
$?    # Exit code ng last command
$$    # PID ng script
🔢 Arithmetic
bash
NUM=$((5 + 3))                # 8
NUM=$((NUM * 2))              # 16
let NUM++
🔀 Conditionals
if / elif / else
bash
if [ "$VAR" = "value" ]; then
    echo "Equal"
elif [ "$VAR" = "other" ]; then
    echo "Other"
else
    echo "Not equal"
fi
Comparison Operators
Numbers:

bash
[ "$a" -eq "$b" ]      # Equal
[ "$a" -ne "$b" ]      # Not equal
[ "$a" -gt "$b" ]      # Greater than
[ "$a" -lt "$b" ]      # Less than
[ "$a" -ge "$b" ]      # Greater or equal
[ "$a" -le "$b" ]      # Less or equal
Strings:

bash
[ "$a" = "$b" ]        # Equal
[ "$a" != "$b" ]       # Not equal
[ -z "$a" ]            # Empty
[ -n "$a" ]            # Not empty
Files:

bash
[ -f file.txt ]        # Is a file
[ -d dir ]             # Is a directory
[ -r file ]            # Readable
[ -w file ]            # Writable
[ -x file ]            # Executable
[ -e path ]            # Exists
case statement
bash
case "$ACTION" in
    start)
        echo "Starting..."
        ;;
    stop)
        echo "Stopping..."
        ;;
    *)
        echo "Unknown action"
        exit 1
        ;;
esac
🔁 Loops
for
bash
for i in 1 2 3 4 5; do
    echo "Number: $i"
done

for file in *.txt; do
    echo "File: $file"
done

for i in {1..10}; do
    echo "Count: $i"
done
while
bash
COUNT=1
while [ $COUNT -le 5 ]; do
    echo "Count: $COUNT"
    ((COUNT++))
done
while read (para sa files)
bash
while read -r line; do
    echo "Line: $line"
done < file.txt

# With pipe
cat file.txt | while read -r line; do
    echo "Line: $line"
done
🎯 Functions
bash
my_function() {
    local arg1=$1
    local arg2=$2
    echo "Arg1: $arg1, Arg2: $arg2"
}

my_function "hello" "world"
With return value:

bash
add() {
    echo $(($1 + $2))
}

RESULT=$(add 5 3)
echo "Result: $RESULT"    # 8
📤 Input / Output
bash
echo "Hello"                       # Print
printf "%-20s %s\n" "Name" "Juan"  # Formatted
read -p "Enter name: " NAME        # User input
read -s -p "Password: " PASS       # Silent input

# Redirection
echo "Hello" > file.txt            # Overwrite
echo "World" >> file.txt           # Append
command 2>/dev/null                # Suppress errors
command &>/dev/null                # Suppress all output
🔗 Pipes at Command Substitution
bash
ls | grep ".txt"                    # Pipe
COUNT=$(ls | wc -l)                 # Command substitution
FILES=`ls`                          # Old style (avoid)
⚠️ Error Handling
bash
set -e                    # Exit on error
set -u                    # Exit kung may undefined variable
set -o pipefail           # Exit kung may failed command sa pipe
set -euo pipefail         # All three (recommended)

# Manual error check
command
if [ $? -ne 0 ]; then
    echo "Error!"
    exit 1
fi

# Or:
command || { echo "Failed"; exit 1; }
🎨 Colors at Formatting
bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'  # No Color

echo -e "${GREEN}Success!${NC}"
echo -e "${RED}Error!${NC}"
🧪 Sample Scripts
backup.sh — Backup script
bash
#!/bin/bash
set -e

SOURCE=$1
BACKUP_DIR="$HOME/backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

if [ -z "$SOURCE" ]; then
    echo "Usage: $0 <source>"
    exit 1
fi

if [ ! -d "$SOURCE" ]; then
    echo "Error: $SOURCE not found"
    exit 1
fi

mkdir -p "$BACKUP_DIR"
tar -czf "$BACKUP_DIR/backup_$TIMESTAMP.tar.gz" "$SOURCE"
echo "✅ Backup: $BACKUP_DIR/backup_$TIMESTAMP.tar.gz"
health-check.sh — System health
bash
#!/bin/bash

echo "=== System Health ==="
echo "Date: $(date)"
echo "Uptime: $(uptime -p)"
echo ""
echo "Disk:"
df -h | grep "/dev"
echo ""
echo "Memory:"
free -h
echo ""
echo "Top 5 CPU:"
ps aux --sort=-%cpu | head -6
💡 Best Practices
set -euo pipefail — Sa umpisa ng script.

Quote variables — "$VAR" hindi $VAR.

Use local — Sa functions, para hindi mag-leak.

Comments — Ipaliwanag mo yung "bakit", hindi "ano".

Descriptive names — SOURCE_DIR hindi s.

Idempotency — Safe to run multiple times.

Error handling — Lagi i-check yung $?.

Test mo muna — Sa test folder bago production.

