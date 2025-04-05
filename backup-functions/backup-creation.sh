#!/bin/bash

bkpMainScript=$(find $PWD -type d -name "backup-script")

echo "|================|"
echo "|   NEW-BACKUP   |"
echo "|================|"

cd "$HOME/Backups/" || return

read -p "Set a directory to be backuped: " bkpDir
read -p "Set a name for this backup: " bkpName

# Gets the previously informed directory and creates a compacted copy of it in the Backups directory
tar -cvf "$HOME/Backups/$bkpName""_$(date +%d-%m-%Y_%H-%M-%S)".tar "$bkpDir"* 2>/dev/null

echo "Your backup is ready"; sleep 2
clear; "$bkpMainScript/backup.sh"