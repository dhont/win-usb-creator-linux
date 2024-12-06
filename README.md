# Windows USB Creator for Linux

This repository contains a script to download on a Linux machine and write the Windows 11 ISO to a USB drive, making it bootable for installation. This script has been tested on Ubuntu Server LTS 22.04.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Script Usage](#script-usage)
- [Getting the Windows 11 ISO Download Link](#getting-the-windows-11-iso-download-link)
- [Notes](#notes)

## Prerequisites
- Ubuntu or any Linux-based system
- `wget` installed: `sudo apt-get install wget`
- **woeusb** installed: `sudo add-apt-repository ppa:tomtomtom/woeusb && sudo apt update && sudo apt install woeusb`
  - The script will check for `woeusb` and prompt to install if it's not already installed.
- **Download the Windows 11 ISO:**
  1. Visit the [Windows 11 Download Page](https://www.microsoft.com/en-us/software-download/windows11).
  2. Scroll down to the section titled "Download Windows 11 Disk Image (ISO)".
  3. Select "Windows 11 (multi-edition ISO)" from the dropdown menu and click "Download".
  4. Select "English (International)" from the dropdown menu and click "Confirm".
  5. Click the "64-bit Download" button.
  6. Copy the download link. This link is valid for 24 hours.

## Script Usage
1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/windows-usb-creator-linux.git
   cd windows-usb-creator-linux
   ```

2. Ensure the script is executable:
   ```bash
   chmod +x create_windows_usb.sh
   ```

3. Update the script with the Windows 11 ISO download link you obtained in the prerequisites section.

4. List devices to identify the correct USB device path:
   ```bash
   sudo fdisk -l
   ```

5. Run the script with `sudo`:
   ```bash
   sudo ./create_windows_usb.sh
   ```

6. Enter the USB device path (e.g., `/dev/sdX`) when prompted.

## Notes
- **Important:** The download link for the Windows 11 ISO is only valid for 24 hours. You will need to update the script with the new URL if the link expires.
- Make sure to back up any important data on your USB drive before running the script, as this process will erase all data on the drive.
- The script uses `woeusb` to create the bootable USB drive and checks if it is installed. If not, it will prompt to install or exit.