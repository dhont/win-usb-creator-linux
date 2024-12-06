#!/bin/bash

# Define the URL for the Windows 11 ISO and the output file path
# Replace this link with the actual download link for the Windows 11 ISO
ISO_URL="https://software.download.prss.microsoft.com/dbazure/Win11_24H2_EnglishInternational_x64.iso?t=4f3887d6-b42e-4634-aab6-801a9b6a62a4&P1=1733608031&P2=601&P3=2&P4=f4j88C%2bbrYklMWM85afasg3PZSySPij4yTAxQztHsEHQa6GBRE349KCDP7WbmIjLcjh4iOVg8lkm%2bX6PO3pl%2b2ADQR1jgdTnd5gyskEkxuLc07mwkxtHPggv4sU%2b3cUk%2bWloWn3yWW%2fzLlBqtxiefZMKyYYyZ9oT976J2wMksEs9AjClgoIFOLwdI4RvJp2HFnBf1db5TjlZUREXrB2ubYY74Nz6R3%2fMh7nx2rF1GndmgK1aYR%2fTo2R1NI0mVoD%2f%2f4VTW2CGDLt1%2fTq5FfkNIpP%2fZpgKLQcF9bdDQJGa8P9UikJOU1eW2DkLXrndrOho8ARP%2f%2bA9CfSfey%2fGKFwRnw%3d%3d"
OUTPUT_ISO="windows11.iso"

# Prompt the user for the USB device path (e.g., /dev/sdX)
read -p "Please enter the USB device path (e.g., /dev/sdX): " USB_DEVICE

# Check if the Windows 11 ISO is already downloaded
if [ -f "$OUTPUT_ISO" ]; then
    if [ $(stat -c%s "$OUTPUT_ISO") -lt 10485760 ]; then
        echo "The downloaded ISO is smaller than 10 MB. Please check the URL as it may not be correct."
        exit 1
    else
        echo "The Windows 11 ISO is already downloaded."
    fi
else
    # Download the Windows 11 ISO
    echo "Downloading Windows 11 ISO..."
    wget -O $OUTPUT_ISO $ISO_URL
fi

# Unmount the USB device if mounted
echo "Unmounting the USB device..."
sudo umount ${USB_DEVICE}*

# Check that the selected device is not the root filesystem or main hard drive
ROOT_DEV=$(lsblk -o MOUNTPOINT,PKNAME | grep " /$" | awk '{print $2}')
if [ "${USB_DEVICE#/dev/}" == "$ROOT_DEV" ]; then
    echo "Error: The selected device is the root filesystem or part of the main hard drive. Exiting..."
    exit 1
fi

# Delete all partitions on the USB drive
echo "Deleting all partitions on the USB device..."
sudo parted $USB_DEVICE --script mklabel msdos

# Write the ISO to the USB drive
echo "Writing ISO to USB drive..."
sudo dd if=$OUTPUT_ISO of=$USB_DEVICE bs=4M status=progress

# Sync to ensure all writes are completed
echo "Syncing..."
sync

# Check if boot-info is installed
if ! command -v bootinfoscript &> /dev/null; then
    read -p "boot-info is not installed. Do you want to install it? (y/n): " INSTALL_BOOT_INFO
    if [ "$INSTALL_BOOT_INFO" == "y" ]; then
        sudo apt-get install boot-info
    else
        read -p "Do you want to skip the boot check? (y/n): " SKIP_BOOT_CHECK
        if [ "$SKIP_BOOT_CHECK" == "y" ]; then
            echo "Skipping the boot check."
            exit 0
        else
            echo "Exiting without checking bootability."
            exit 1
        fi
    fi
fi

# Run boot-info to check if the USB is bootable
echo "Checking if the USB is bootable..."
sudo bootinfoscript

# Check the RESULTS.txt file for bootable status
if grep -q " => syslinux" RESULTS.txt || grep -q " => grub" RESULTS.txt; then
    echo "The USB drive is bootable."
else
    echo "The USB drive is not bootable. Please check the process or try again."
fi

echo "Windows 11 ISO has been written to the USB drive successfully."
