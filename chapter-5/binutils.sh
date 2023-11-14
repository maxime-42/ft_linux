#!/bin/bash

# Header Comments:
# Script Name: install_binutils_cross.sh
# Description: Installation script for Cross-Compiled Binutils
# Author: [Your Name]
# Date: [Current Date]
# Usage: ./install_binutils_cross.sh <package_directory_name>
# Example: ./install_binutils_cross.sh binutils-2.36.1


# Change directory to the specified Binutils source directory
cd $1


# Create a 'build' directory for the build process
mkdir -v build
cd build

if [ "$2" == "passe 2" ]; then
   echo -e "************Binutil Part 2*****************\n"
   sed '6009s/$add_dir//' -i ltmain.sh
   ../configure                   \
       --prefix=/usr              \
       --build=$(../config.guess) \
       --host="$LFS_TGT"          \
       --disable-nls              \
       --enable-shared            \
       --disable-werror           \
       --enable-64-bit-bfd
   make
   make DESTDIR="$LFS" install
else
    echo -e "************Binutil Part 1*****************\n"
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

fi

