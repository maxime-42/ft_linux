

#!/bin/bash

# Header Comments:
# Script Name: install_linux_api_headers.sh
# Description: Script to install Linux API headers for the Linux From Scratch (LFS) system.
# Author: [Your Name]
# Date: [Current Date]

# Explanation:
# This script is part of the LFS installation process and focuses on preparing the Linux kernel source
# by cleaning unnecessary files and extracting the required header files for the API.
# The cleaned and extracted headers are then copied to the appropriate location in the LFS system.

# Step 1: Clean the Kernel Source


package_dirname=$LFS/sources/$1

cd $package_dirname

make mrproper

# Step 2: Extract and Copy Header Files
make headers
find usr/include -name '.*' -delete
rm usr/include/Makefile
cp -rv usr/include $LFS/usr

echo "Linux API headers installation complete."
