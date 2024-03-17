#!/bin/bash

# Function to display news menu
display_menu() {
    dialog --backtitle "News Menu" \
           --title "Select a news source" \
           --menu "Choose a news source:" 15 50 5 \
           1 "BBC News" \
           2 "CNN" \
           3 "Reuters" \
           4 "The New York Times" \
           5 "Exit" \
           2> /tmp/menu_choice.tmp
}

# Function to open news source in w3m
open_news() {
    case $1 in
        1) w3m "https://www.bbc.com/news";;
        2) w3m "https://edition.cnn.com";;
        3) w3m "https://www.reuters.com";;
        4) w3m "https://www.nytimes.com";;
        *) echo "Exiting...";;
    esac
}

# Main script
while true; do
    display_menu
    choice=$(cat /tmp/menu_choice.tmp)
    case $choice in
        [1-5]) open_news $choice;;
        *) echo "Invalid option. Please choose again.";;
    esac
    rm /tmp/menu_choice.tmp
    [ "$choice" = "5" ] && break
done
