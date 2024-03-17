#!/bin/bash

# Function to display main menu
main_menu() {
    dialog --clear --backtitle "Personal Management & Administration" \
    --title "Main Menu" \
    --menu "Choose an option:" 15 50 7 \
    1 "Calendar" \
    2 "Analog Clock" \
    3 "Email Client" \
    4 "Word Processor" \
    5 "Spreadsheets" \
    6 "Calculator" \
    7 "Notes" \
    8 "Dependency Install" \
    9 "Return to Main Menu" 2> /tmp/menu_choice

    choice=$(cat /tmp/menu_choice)
    case $choice in
        1) calendar;;
        2) analog_clock;;
        3) email_client;;
        4) word_processor;;
        5) spreadsheets;;
        6) calculator;;
        7) notes;;
        8) dependency_install;;
        9) ./Menu_Main.sh;;
        *) echo "Invalid option";;
    esac
}

# Function to install dependencies
dependency_install() {
    # Put your dependency installation commands here
    # For example:
    # sudo apt-get install -y calendar_app analog_clock_app email_client_app word_processor_app spreadsheets_app calculator_app notes_app
    echo "Installing dependencies..."
    sleep 2
    sudo apt-get install -y khal mutt wordgrinder sc wcalc
    echo "Dependencies installed successfully."
    sleep 1
    main_menu
}

# Sample functions for the options
calendar() {
    echo "Launching Calendar..."
    # Put your calendar application launching command here
    khal
    sleep 2
    main_menu
}

analog_clock() {
    echo "Launching Analog Clock..."
    # Put your analog clock application launching command here
    sleep 2
    main_menu
}

email_client() {
    echo "Launching Email Client..."
    # Put your email client application launching command here
    mutt
    sleep 2
    main_menu
}

word_processor() {
    echo "Launching Word Processor..."
    # Put your word processor application launching command here
    wordgrinder
    sleep 2
    main_menu
}

spreadsheets() {
    echo "Launching Spreadsheets..."
    # Put your spreadsheets application launching command here
    sc
    sleep 2
    main_menu
}

calculator() {
    echo "Launching Calculator..."
    # Put your calculator application launching command here
    wcalc
    sleep 2
    main_menu
}

notes() {
    echo "Launching Notes..."
    # Put your notes application launching command here
    sleep 2
    main_menu
}

# Initial call to main menu
main_menu
