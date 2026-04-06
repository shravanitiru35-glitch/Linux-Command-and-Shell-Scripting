#!/bin/bash
# backup.sh - Backup files modified in the last 24 hours

# Task 1: Set directories from command-line arguments
targetDirectory="$1"
destinationDirectory="$2"

# Print directories
echo "Target directory: $targetDirectory"
echo "Destination directory: $destinationDirectory"

# Task 2: Save current timestamp in seconds
currentTS=$(date +%s)

# Task 3: Save original absolute path
origAbsPath=$(pwd)

# Task 4: Change to destination directory and save absolute path
cd "$destinationDirectory" || exit
destAbsPath=$(pwd)

# Task 5: Change back to original directory, then go to target directory
cd "$origAbsPath" || exit
cd "$targetDirectory" || exit

# Task 6: Calculate timestamp for 24 hours ago
yesterdayTS=$(($currentTS - 24 * 60 * 60))

# Task 7: Initialize array to hold files to backup
toBackup=()

# Task 8: Loop over files and check last modified time
for file in *; do
    # Only consider regular files
    if [ -f "$file" ]; then
        fileTS=$(stat -c %Y "$file")
        if [ "$fileTS" -ge "$yesterdayTS" ]; then
            toBackup+=("$file")
        fi
    fi
done

# Task 9: Define backup file name
backupFileName="backup-$(date +%Y-%m-%d_%H-%M-%S).tar.gz"

# Task 10: Create compressed archive of files modified in last 24 hours
if [ ${#toBackup[@]} -gt 0 ]; then
    tar -czvf "$backupFileName" "${toBackup[@]}"
else
    echo "No files modified in the last 24 hours to backup."
    exit 0
fi

# Task 11: Move backup file to destination directory
mv "$backupFileName" "$destAbsPath"

# Task 12: Print success message
echo "Backup created successfully at $destAbsPath/$backupFileName"

# Task 13: Return to original path
cd "$origAbsPath" || exit
echo "Backup script finished."
