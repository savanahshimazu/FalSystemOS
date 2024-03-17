#!/bin/bash

# Function to display menu and execute selected script
show_menu() {
    while true; do
        option=$(dialog --clear \
                        --backtitle "Menu" \
                        --title "Main Menu" \
                        --menu "Choose an option:" \
                        15 50 4 \
                        "1" "Programs [Utility]" \
                        "2" "Programs [Web]" \
                        "3" "Programs [Entertainment]" \
                        "4" "Settings" \
                        3>&1 1>&2 2>&3)
        exit_status=$?
        if [ $exit_status -eq 0 ]; then
            case $option in
                1) execute_scripts "Utility" ;;
                2) execute_scripts "Web" ;;
                3) execute_scripts "Entertainment" ;;
                4) echo "Open settings" ;; # Placeholder for settings
            esac
        else
            clear
            break
        fi
    done
}

# Function to execute scripts in specified folder
execute_scripts() {
    folder="$1"
    script_list=$(ls "./$folder"/*.sh 2>/dev/null)
    if [ -n "$script_list" ]; then
        while true; do
            script=$(dialog --clear \
                            --backtitle "Menu" \
                            --title "$folder" \
                            --menu "Choose a script to execute:" \
                            15 50 5 \
                            $(for file in $script_list; do \
                                echo "$(basename $file .sh)"; \
                            done) \
                            3>&1 1>&2 2>&3)
            exit_status=$?
            if [ $exit_status -eq 0 ]; then
                bash "./$folder/$script.sh"
            else
                break
            fi
        done
    else
        dialog --msgbox "No scripts found in $folder folder." 10 50
    fi
}

# Function to display system information
show_system_info() {
    while true; do
        system_info=$(date +'%Y-%m-%d %H:%M:%S')$'\n'$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{printf "CPU Usage: %.2f%", 100-$1}')
        dialog --clear \
               --backtitle "System Information" \
               --infobox "$system_info" 6 50
        sleep 1
    done
}

# Main function
main() {
    show_system_info &
    show_menu
}

main
