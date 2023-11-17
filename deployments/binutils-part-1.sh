#!/bin/bash

# Header Comments:
# Script Name: install_binutils_cross.sh
# Description: Installation script for Cross-Compiled Binutils
# Author: [Your Name]
# Date: [Current Date]
# Usage: ./install_binutils_cross.sh <package_directory_name>
# Example: ./install_binutils_cross.sh binutils-2.36.1



cd $1
pwd

# Create a 'build' directory for the build process
mkdir -v build
cd build

# Configure Binutils with cross-compile settings
../configure --prefix="$LFS/tools" \
	--with-sysroot="$LFS" \
	--target="$LFS_TGT"   \
	--disable-nls       \
	--disable-werror

# Build Binutils
make

# Install Binutils
make install

