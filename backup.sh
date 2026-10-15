#!/bin/bash
#backup.sh - Automated backup script
#DevOps Apprentice - Week 2 Day 2
BACKUP_DIR= "$HOME/backups"
SOURCE_DIR="$1"
TIMESTAMP=$(date + "%Y%m%d_%H%M%S")
BACKUP_FILE="backup_${TIMESTAMP}.tar.gz"
if [ -z "$SOURCE_DIR" ]; then
echo "Usage: $0 <source_directory>"
exit 1
fi
if [ ! -d "$SOURCE_DIR" ]; then
echo "Error: $SOURCE_DIR hindi umiiral!"
exit 1
fi
mkdir -p "$BACKUP_DIR"
echo "Nagba-backup ng $SOURCE_DIR..."
tar -czf "$BACKUP_DIR/$BACKUP_FILE" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")"
if [ $? -eq 0 ]; then
echo "✅ Backup successful: $BACKUP_DIR/$BACKUP_FILE"
 echo "Size: $(du -h "$BACKUP_DIR/$BACKUP_FILE" | cut -f1)"
else
echo "❌ Backup failed!"
exit 1
fi
# Linisin ang lumang backups (keep last 5)
cd "$BACKUP_DIR" && ls -t backup_*.tar.gz | tail -n +6 | xargs -r rm
echo "🧹 Old backups cleaned up"
