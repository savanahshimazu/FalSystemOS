#!/bin/bash

# Prompt the user with a dialog menu
dialog --backtitle "Logout Prompt" --title "Logout Confirmation" --yesno "Would you like to log out?" 10 30

# Get the exit status of the dialog command
exit_status=$?

# Check the user's choice
if [ $exit_status -eq 0 ]; then
    # User chose Yes
    echo "Goodbye!"
    pkill -TERM -u $USER
    exit
else
    # User chose No
    sudo bash Menu_Main.sh
fi
