#!/bin/bash

: '

Author: Samuel Couto
Creation date: 18.01.2025
Modified in: 05.04.2025
Description: Creates files backups

'

bkpFunctions=$(find $PWD -type d -name "backup-functions")

function main {
    
    echo "|======================|"
    echo "|    BACKUP-SYSTEM     |"
    echo "|======================|"
    
    PS3=">> "
    
    select option in "Create a new Backup" "Backup management" "Exit"; do
        case $option in
        "Create a new Backup")
            clear; "$bkpFunctions/backup-creation.sh"
            ;;

        "Backup management")
            clear; "$bkpFunctions/backup-management.sh"
            ;;

        "Exit")
            clear; echo "Finishing the program..."
            exit
            ;;
        esac
    done
}

if [[ -d "$HOME/Backups/" ]]; then    
    main
else
    mkdir "$HOME/Backups/" && main
fi

# SDG