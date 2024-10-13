#!/bin/bash

# Check if a directory path is provided
if [ $# -eq 0 ]; then
    echo "Please provide a directory path as an argument."
    exit 1
fi

# Get the directory path from the command-line argument
source_dir="$1"

# Check if the provided path is a valid directory
if [ ! -d "$source_dir" ]; then
    echo "Error: $source_dir is not a valid directory."
    exit 1
fi

# Function to remove old backups
remove_old_backups() {
    # Get a list of all backup folders, sorted by modification time (oldest first)
    backups=($(ls -1d "${source_dir}/backup_"* | sort))
    
    # Keep only the last 3 backups, delete the rest
    while [ ${#backups[@]} -gt 2 ]; do
        oldest_backup="${backups[0]}"
        rm -rf "$oldest_backup"
        echo "Removed old backup: $oldest_backup"
        backups=("${backups[@]:1}")  # Remove the first element from the list
    done
}

# Call the function to remove old backups BEFORE creating a new one
remove_old_backups

# Create a timestamped backup folder name
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
backup_dir="${source_dir}/backup_${timestamp}"

# Create the backup directory
mkdir -p "$backup_dir"

# Find the 3 most recently modified files (excluding directories and existing backups)
recent_files=$(find "$source_dir" -maxdepth 1 -type f -not -name "backup_*" -printf '%T@ %p\n' | sort -n | tail -3 | cut -f2- -d" ")

# Copy the recent files to the backup directory
while IFS= read -r file; do
    cp "$file" "$backup_dir/"
    echo "Backed up: $file"
done <<< "$recent_files"

echo "Backup created: $backup_dir"

echo "Backup process completed."
