#!/bin/bash

# Script Name: setup_lfs_user.sh
# Description: Script to create the 'lfs' user and set permissions.
# Author: [Your Name]
# Date: [Current Date]


echo -e "\nCREATE LFS USER\n"
# Variables
LFS="$LFS"  # Replace with the actual path

# Check if the 'lfs' user already exists
if id "lfs" &>/dev/null; then
	echo "User 'lfs' already exists. Skipping user creation."
else
  # Create 'lfs' group and user
	sudo groupadd lfs
      	sudo useradd -s /bin/bash -g lfs -m -k /dev/null lfs

	  # Set password for the 'lfs' user
	sudo passwd lfs

  # Set ownership of directories
	sudo chown -vR lfs $LFS/lib64
	sudo chown -vR lfs $LFS/sources
	echo "User 'lfs' created and permissions set."
fi

