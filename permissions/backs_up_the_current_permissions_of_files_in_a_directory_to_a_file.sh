#!/bin/bash

read -p "Enter the directory to back up permissions: " directory

# Check if the directory exists
if [ ! -d "$directory" ]; then
    echo "Directory does not exist. Please enter a valid directory."
    exit 1
fi

# Create a backup file for permissions
backup_file="permissions_backup.txt"

# Clear the backup file or create it if it doesn't exist
> "$backup_file"

# Loop through the files in the specified directory
for file in "$directory"/*; do
    # Check if it's a file or directory
    if [ -e "$file" ]; then
        # Get the permissions of the file
        permissions=$(ls -ld "$file" | awk '{print $1}')
        # Get the name of the file
        filename=$(basename "$file")
        # Append the permissions and filename to the backup file
        echo "$permissions $filename" >> "$backup_file"
    fi
done

# Inform the user that the backup is complete
echo "Permissions backup completed! Saved to $backup_file."
