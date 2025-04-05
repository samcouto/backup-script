#!/bin/bash

bkpFunctions=$(find $PWD -type d -name "backup-functions")
bkpMainScript=$(cd .. && find $PWD -type d -name "backup-script")

function bkpMangement {
    PS3=">> "

    echo "|=========================|"
    echo "|    BACKUP-MANAGEMENT    |"
    echo "|=========================|"

    select bkpOption in "List Backups" "Remove Backup" "Export Backup" "Exit"; do
        case $bkpOption in
        "List Backups")
            clear
            
            bkpList=$(ls "$HOME/Backups/")

            if [[ -z $bkpList ]]; then
                echo "There are no backups yet!"; sleep 2
                clear; bkpMangement
            else
                echo "$bkpList"; sleep 2
                bkpMangement
            fi
            ;;

        "Remove Backup")
            clear; "$bkpFunctions/backup-remover.sh"
            ;;
            
        "Export Backup")
            clear; "$bkpFunctions/backup-export.sh"
            ;;

        "Exit")
            clear; "$bkpMainScript/backup.sh"
            ;;
        esac
    done
}

bkpMangement