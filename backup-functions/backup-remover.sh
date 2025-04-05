#!/bin/bash

bkpFunctions=$(find $PWD -type d -name "backup-functions")

echo "|====================|"
echo "|   BACKUP-REMOVER   |"
echo "|====================|"

# Creates an array to store all backups in the Backups directory
readarray -t bkpArray < <(ls "$HOME/Backups/")

# Iterates in all the backups inside the bkpArray
for bkp in "${bkpArray[@]}"; do
    if [[ -z $bkp ]]; then
        echo "There are no backups to be removed!"; sleep 2
        "$bkpFunctions/backup-management.sh"
    else
        rm -i "$HOME/Backups/$bkp" # rm -i asks for a confirmation before deleting the file
    fi
done

clear; "$bkpFunctions/backup-management.sh"