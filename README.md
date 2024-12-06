Sure! Here's the complete `README.md` file in raw format:

```markdown
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
- `parted` installed: `sudo apt-get install parted`
- `boot-info` installed: `sudo apt-get install boot-info`
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

4. Run the script:
   ```bash
   sudo ./create_windows_usb.sh
   ```

5. Enter the USB device path (e.g., `/dev/sdX`) when prompted.

## Notes
- **Important:** The download link for the Windows 11 ISO is only valid for 24 hours. You will need to update the script with the new URL if the link expires.
- Make sure to back up any important data on your USB drive before running the script, as this process will erase all data on the drive.
- The script checks if the ISO file is already downloaded. If it's smaller than 10 MB, it will stop and prompt you to check the URL.
- The script now includes a check to see if the USB stick is bootable after the `dd` process. If `boot-info` is not installed, the script will prompt the user to install it or skip the boot check.
```

Feel free to copy and use this for your repository. Let me know if you have any other questions or need further assistance! 😊
