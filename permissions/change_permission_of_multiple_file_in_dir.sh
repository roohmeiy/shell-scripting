#!/bin/bash

# Prompt the user for the directory and permission level
read -p "Enter the directory name: " dir
read -p "Enter the permission level (e.g., 755 or 644): " perm

# Check if the directory exists
if [[ -d "$dir" ]]; then
    # Change permissions for all files in the directory
    for file in "$dir"/*; do
        chmod "$perm" "$file"
        echo "Changed permissions of $file to $perm"
    done
else
    echo "Directory $dir does not exist."
fi
