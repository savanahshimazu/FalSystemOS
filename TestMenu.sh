#!/bin/bash

# Function to display the submenu
show_submenu() {
    local folder="$1"
    local options=()
    while IFS= read -r -d '' file; do
        options+=("$(basename "$file" .sh)")
    done < <(find "$folder" -type f -name "*.sh" -print0)
    
    options+=("Back")

    while true; do
        local choice
        choice=$(dialog --clear --title "Submenu - $folder" --menu "Choose an option:" 15 50 5 "${options[@]}" 2>&1 >/dev/tty)
        case "$choice" in
            Back) return;;
            *) . "$folder/$choice.sh"; break;;
        esac
    done
}

# Main menu options
options=(
    1 "Programs [Utility]"
    2 "Programs [Web]"
    3 "Programs [Entertainment]"
    4 "Settings"
)

# Main menu
while true; do
    choice=$(dialog --clear --title "Main Menu" --menu "Choose an option:" 15 50 5 "${options[@]}" 2>&1 >/dev/tty)

    case "$choice" in
        1) show_submenu "Utility";;
        2) show_submenu "Web";;
        3) show_submenu "Entertainment";;
        4) echo "Settings option is not implemented yet.";;
        *) break;;
    esac
done
