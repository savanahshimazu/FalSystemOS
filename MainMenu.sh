#!/bin/bash

# Function to display the menu
display_menu() {
    clear
    echo "Welcome to the Program Selector!"
    echo "--------------------------------"
    echo "1. Calculator"
    echo "2. Text Editor"
    echo "3. File Explorer"
    echo "4. System Monitor"
    echo "5. Exit"
    echo "--------------------------------"
}

# Function to run the selected program
run_program() {
    case $1 in
        1) gnome-calculator ;;
        2) gedit ;;
        3) nautilus ;;
        4) gnome-system-monitor ;;
        5) exit ;;
        *) echo "Invalid option. Please try again." ;;
    esac
}

# Function to display clock and CPU usage
display_clock_cpu() {
    while true; do
        clear
        echo "Current Time: $(date +"%T")"
        echo "CPU Usage: $(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')%"
        sleep 1
    done
}

# Run clock and CPU display function in the background
display_clock_cpu &

# Main program loop
while true; do
    display_menu
    read -p "Enter your choice [1-5]: " choice
    run_program $choice
    read -p "Press Enter to continue..."
done
