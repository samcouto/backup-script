# Backup Script

### *About*

This is a script to make backups of entire directories.

When used, the scrip is going to validate if the `$HOME/Backups/` directory exists, if so, the script will open a menu, other wise, the script will create the `$HOME/Backups/` and then the menu will be opened.

There are 2 options:

- Make a backup
- List all backups

If the first option is selected the script will ask for a directory to make a backup of its files.

Then the script is going to compress a copy of all files cointeined into the indicated directorie to a .tar file.

If the second option was selected the script will list all the backups made using this script.

### *SamCouto, November 23th, 2024*