#!/bin/bash

# Function to create encrypted file
create_encrypted_file() {
    dialog --title "Create New User" --clear \
    --inputbox "Enter Username:" 10 30 2> /tmp/username.tmp \
    --inputbox "Enter Password:" 10 30 2> /tmp/password.tmp

    username=$(cat /tmp/username.tmp)
    password=$(cat /tmp/password.tmp)

    # Encrypt username and password and store in file
    echo "$username:$password" | openssl aes-256-cbc -salt -out login_info.enc
}

# Function to get login information
get_login_info() {
    dialog --title "Login" --clear \
    --inputbox "Enter Username:" 10 30 2> /tmp/username.tmp \
    --passwordbox "Enter Password:" 10 30 2> /tmp/password.tmp

    username=$(cat /tmp/username.tmp)
    password=$(cat /tmp/password.tmp)

    # Decrypt the file and check if credentials match
    decrypted=$(openssl aes-256-cbc -d -salt -in login_info.enc 2>/dev/null)
    if [ "$decrypted" == "$username:$password" ]; then
        dialog --title "Welcome" --msgbox "Welcome back, $username!" 10 30
    else
        dialog --title "Error" --msgbox "Invalid username or password." 10 30
        exit 1
    fi
}

# Function to check and install required programs silently
check_and_install_programs() {
    programs=("khal" "mutt" "wordgrinder" "sc" "wcalc" "w3m" "w3m-img")
    to_install=()

    for program in "${programs[@]}"; do
        if ! command -v "$program" &> /dev/null; then
            to_install+=("$program")
        fi
    done

    if [ ${#to_install[@]} -gt 0 ]; then
        sudo apt-get update
        sudo apt-get install -y "${to_install[@]}" &>/dev/null
    fi
}

# Main program
if [ ! -e "login_info.enc" ]; then
    create_encrypted_file
fi

get_login_info
check_and_install_programs

# Additional functionality can be added here for the user's session after successful login.
sudo bash Menu_Main.sh