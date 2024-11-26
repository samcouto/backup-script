#!/usr/bin/bash

# ==========================================
# | Author:            Samuel Couto        |
# | Creation Date:     12.11.2024          |
# | Last Modification: 26.11.2024          |
# | Description:       Create file backups |
# | Usage:             ./filesBackup.sh    |
# ==========================================

# Validates if the ~/Backups/ directory exists
function checkDir {
  if [[ -d "$HOME"/Backups/ ]]
  then
    main
  else
    mkdir "$HOME"/Backups/
    main
    exit 0
  fi
}

function exitValidation {
  while true ; do
    read -rp "Do you want to exit? (Y/n): " vStrOpt
    if [[ ${vStrOpt^^} = "N" ]]
    then
      clear
      main
    elif [[ ${vStrOpt^^} = "Y" ]]
    then
      clear
      exit
    else
      continue
      exit 0
    fi
  done
}

# Lists all the .tar backup files in the backup directory
function backupsList {
  echo "Reading your $HOME/Backups/ directory..."

  cd "$HOME"/Backups/ || return

  vStrCheckBackupDir=$(ls "$HOME"/Backups/)
  
  if [[ -z $vStrCheckBackupDir ]]
  then
    echo "You don't have any .tar backup files in your $HOME/Backups/ directory!"
    exitValidation
  else
    ls
    exitValidation
    exit 0
  fi
}

# Starts the backup process
function backup {
  read -p "Insert the directory to be backuped: " vStrDir

  if [[ -d "$vStrDir" ]]
  then
    echo "Your backup is starting..."

    tar -cvf "$HOME"/Backups/files_backup_"$(date +%d-%m-%Y_%H-%M-%S)".tar "$vStrDir"* 2>/dev/null 

    echo "Your backup is ready at $HOME/Backups/"
    sleep 2

    clear
    main
  else
    echo "Please, insert a valid directory!"
    sleep 2

    backup
    exit 0
  fi
}

function main {
  echo "|=======BACKUPS=======|"
  echo "| 0. Exit             |"
  echo "| 1. Start backup     |"
  echo "| 2. List all backups |"
  echo "|=====================|"

  read -rp "Hello $USER! What would you like to do? " vIntOpt

  case $vIntOpt in

    0)
      clear
      exit 0
      ;;

    1)
      clear
      backup
      ;;

    2)
      clear
      backupsList
      ;;

    *)
      clear
      main
      ;;

  esac
}

checkDir