#!/bin/bash

bkpFunctions=$(find $PWD -type d -name "backup-functions")

echo "|======================|"
echo "|    EXPORT-BACKUP     |"
echo "|======================|"

PS3=">> "

select expOption in "Remote Server" "Cancel"; do

    case $expOption in

        "Remote Server")
            clear; remoteExport
            ;;

        "Cancel")
            clear; "$bkpFunctions/backup-management.sh"
            ;;
    esac            
done

function remoteExport {
    echo "|======================|"
    echo "|    REMOTE-EXPORT     |"
    echo "|======================|"

    read -p "Insert the remote server IP address: " rmtServer
    read -p "Insert the remote user " rmtUser
    read -p "Insert the remote directory: " rmtDir
    
    bkpList=$(ls "$HOME/Backups/")
    echo "$bkpList"

    read -p "Which backup will be sent? " bkpSelection
    clear; echo "Starting the process..."

    # Sends a copy of the selectec backup to a remote server
    scp "$HOME/Backups/$bkpSelection" "$rmtUser@$rmtServer:$rmtDir"

    clear; echo "Your copy was succesfully sent!"

    "$bkpFunctions/backup-management.sh"
}