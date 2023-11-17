#!/bin/bash
# Header Comments:
# Script Name: download_and_extract.sh
# Description: Script to download and extract specified tarballs
# Author: [Your Name]
# Date: [Current Date]


cd $1

echo -e "\n***************GCC Pass 1***************\n" 
## Define download links
mpfr_link="https://www.mpfr.org/mpfr-4.1.0/mpfr-4.1.0.tar.xz"
gmp_link="https://ftp.gnu.org/gnu/gmp/gmp-6.2.1.tar.xz"
mpc_link="https://ftp.gnu.org/gnu/mpc/mpc-1.2.1.tar.gz"

#Download and extract mpfr
wget $mpfr_link
tar -xf mpfr-4.1.0.tar.xz
mv -v mpfr-4.1.0 mpfr

## Download and extract gmp
wget $gmp_link
tar -xf gmp-6.2.1.tar.xz
mv -v gmp-6.2.1 gmp

## Download and extract mpc
wget $mpc_link
tar -xf mpc-1.2.1.tar.gz
mv -v mpc-1.2.1 mpc

## Clean up downloaded tarballs
rm -f mpfr-4.1.0.tar.xz gmp-6.2.1.tar.xz mpc-1.2.1.tar.gz

echo -e "\nDownload and extraction complete.\n"
# Explanation:
# On x86_64 systems, this script modifies the default directory name for 64-bit libraries from "lib64" to "lib".
# This is done by using the 'sed' command to replace occurrences of "lib64" with "lib" in a specific configuration file.

# Check the system architecture
case $(uname -m) in
	  x86_64)
    # Modify the configuration file to set "lib" as the default directory for 64-bit libraries
sed -e '/m64=/s/lib64/lib/' \
	-i.orig gcc/config/i386/t-linux64
	 ;;
esac
echo -e "install configuration\n"

mkdir -v build
cd build

../configure                  \
    --target=$LFS_TGT         \
    --prefix=$LFS/tools       \
    --with-glibc-version=2.35 \
    --with-sysroot=$LFS       \
    --with-newlib             \
    --without-headers         \
    --enable-initfini-array   \
    --disable-nls             \
    --disable-shared          \
    --disable-multilib        \
    --disable-decimal-float   \
    --disable-threads         \
    --disable-libatomic       \
    --disable-libgomp         \
    --disable-libquadmath     \
    --disable-libssp          \
    --disable-libvtv          \
    --disable-libstdcxx       \
    --enable-languages=c,c++

make 
make install 

cd ..
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
  `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/install-tools/include/limits.h
