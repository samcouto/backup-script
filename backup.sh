#!/bin/bash

: '

Author: Samuel Couto
Creation date: 12.11.2024
Modified in: 15.02.2025
Description: Creates files backups

'
function main {
    echo "=BACKUP-SYSTEM="
    
    PS3=">> "
    
    select option in "New Backup" "Backup Management" "Exit"; do

        case $option in

        "New Backup")
            clear
            newBackup
            ;;

        "Backup Management")
            clear
            bkpMangement
            ;;

        "Exit")
            clear
            echo "Finishing the program..."
            exit
            ;;

        esac
    done
}

function newBackup {
    cd "$HOME/Backups/" || return

    read -p "Set a directory to backup: " backupDir
    read -p "Set a name for this backup: " backupName

    # Gets the previously informed directory and creates a compacted copy of it in the Backups directory
    tar -cvf "$HOME/Backups/$backupName""_$(date +%d-%m-%Y_%H-%M-%S)".tar "$backupDir"* 2>/dev/null

    echo "Your backup is ready"
    sleep 2

    clear
    main
}

function bkpMangement {
    echo "=BACKUP-MANAGEMENT="

    select bkpOption in "List Backups" "Delete Backup" "Exit"; do

        case $bkpOption in

        "List Backups")
            clear
            
            bkpList=$(ls "$HOME/Backups/")

            if [[ -z $bkpList ]]; then
                echo "There are no backups yet!"
                sleep 2 
                clear
                bkpMangement
            else
                echo "$bkpList"
                sleep 2
                bkpMangement
            fi
            ;;

        "Delete Backup")
            clear
            bkpDeletion
            ;;

        "Exit")
            clear
            main
            ;;

        esac
    done
}

function bkpDeletion {
    echo "=BACKUP-DELETION="

    readarray -t bkpArray < <(ls "$HOME/Backups/")
 
    for bkp in "${bkpArray[@]}"; do
        if [[ -z $bkp ]]; then
            echo "There are no backups to be deleted!"
            sleep 2
            bkpMangement
        else
            rm -i "$HOME/Backups/$bkp"
        fi
    done

    clear
    bkpMangement
}

# Validates the existence of the "$HOME/Backups/" directory
if [[ -d "$HOME/Backups/" ]]; then
    main
else
    mkdir "$HOME/Backups/"
    main
fi

# SDG
