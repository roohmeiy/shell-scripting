#!/bin/bash

# "This script sets ACL permissions for a user on a specified file."

# Prompt for the filename
read -p "Enter the filename: " file

# Prompt for the username
read -p "Enter the username: " user

# Prompt for the desired permissions
read -p "Enter the permissions (r, w, x, or combination like rwx): " permissions

# Check if the file exists
if [[ ! -e "$file" ]]; then
    echo "File $file does not exist."
    exit 1
fi

# Set ACL for the user on the specified file
setfacl -m u:"$user":"$permissions" "$file"

# Inform the user of the change
if [ $? -eq 0 ]; then
    echo "Set ACL for user $user with permissions '$permissions' on file $file."
else
    echo "Failed to set ACL on file $file."
fi
