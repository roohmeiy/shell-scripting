#!/bin/bash

# Specify the backup file
backup_file="permissions_backup.txt"

# Restore ACLs from the backup file
if setfacl --restore="$backup_file"; then
    echo "Permissions restored successfully"
else
    echo "Failed to restore permissions"
fi
