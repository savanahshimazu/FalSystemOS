#!/bin/bash

# Function to mount a USB drive
mount_usb() {
    device=$(lsblk -lp | grep "part $" | awk '{print $1,$4}' | \
             sed 's/\/.*\///' | sed 's/://')
    choice=$(dialog --menu "Choose a USB drive to mount:" 20 60 10 $device --stdout)
    if [ -n "$choice" ]; then
        sudo mkdir -p /mnt/usb
        sudo mount "$choice" /mnt/usb && \
        dialog --msgbox "USB drive mounted successfully!" 10 40
    fi
}

# Function to unmount a USB drive
unmount_usb() {
    device=$(lsblk -lp | grep "part $" | awk '{print $1,$4}' | \
             sed 's/\/.*\///' | sed 's/://')
    choice=$(dialog --menu "Choose a USB drive to unmount:" 20 60 10 $device --stdout)
    if [ -n "$choice" ]; then
        sudo umount "$choice" && \
        dialog --msgbox "USB drive unmounted successfully!" 10 40
    fi
}

# Main menu
while true; do
    choice=$(dialog --menu "USB Mount Menu" 20 60 10 \
                    1 "Mount USB drive" \
                    2 "Unmount USB drive" \
                    3 "Exit" --stdout)

    case $choice in
        1) mount_usb ;;
        2) unmount_usb ;;
        3) exit ;;
    esac
done
