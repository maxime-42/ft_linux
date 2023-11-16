#!/bin/bash

# Script: lfs_directory_setup.sh
# Description: Create a limited directory structure in the LFS filesystem.
# This is required for the compilation and installation of programs in later chapters.

folder_to_check="$LFS/sources/"

# Check if the folder exists
if [ -d "$folder_to_check" ]; then
    	echo "The Files system doesn't exist."
else
    	echo "The folder doesn't exist."
	# Create necessary directories in the LFS partition
	sudo mkdir -pv $LFS/{etc,var,sources} $LFS/usr/{bin,lib,sbin}

	# Create symbolic links for bin, lib, and sbin in the root directory
	for i in bin lib sbin; do
	  sudo ln -sv usr/$i $LFS/$i
	done

	# Create lib64 directory for 64-bit systems
	sudo mkdir -pv $LFS/lib64

	# Create a directory for the cross-compiler tools
	sudo mkdir -pv $LFS/tools

fi
