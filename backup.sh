#!/bin/bash
# backup.sh - sample script

# Task 1: Define source directory
SOURCE_DIR="/home/user/data"

# Task 2: Define backup directory
BACKUP_DIR="/home/user/backup"

# Task 3: Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Task 4: Get current date
DATE=$(date +%Y-%m-%d)

# Task 5: Define backup filename
BACKUP_FILE="$BACKUP_DIR/backup-$DATE.tar.gz"

# Task 6: Create a compressed tarball
tar -czf "$BACKUP_FILE" "$SOURCE_DIR"

# Task 7: Verify backup creation
if [ -f "$BACKUP_FILE" ]; then
  echo "Backup created successfully: $BACKUP_FILE"
else
  echo "Backup failed"
fi

# Task 8: Log backup to file
echo "$DATE - Backup completed" >> "$BACKUP_DIR/backup.log"

# Task 9: Remove backups older than 7 days
find "$BACKUP_DIR" -type f -mtime +7 -name "*.tar.gz" -exec rm {} \;

# Task 10: Send backup via email (example)
# mail -s "Backup $DATE" user@example.com < "$BACKUP_FILE"

# Task 11: Print list of files backed up
ls -lh "$BACKUP_FILE"

# Task 12: Check disk usage of backup directory
du -sh "$BACKUP_DIR"

# Task 13: End of script message
echo "Backup script finished"
