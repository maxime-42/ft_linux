#! /bin/bash

# Script for Glibc-2.35 Installation in LFS environment


package_fix=wget https://www.linuxfromscratch.org/patches/lfs/11.1/glibc-2.35-fhs-1.patch

wget -P $LFS/sources "$package_fix"

cd $1 

case $(uname -m) in
    i?86)   ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3
    ;;
    x86_64) ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
            ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3
    ;;
esac

# Apply patch for Glibc programs using /var/db
patch -Np1 -i ../glibc-2.35-fhs-1.patch

mkdir -v build
cd       build

echo -e " start configuration\n"

echo "rootsbindir=/usr/sbin" > configparms

../configure                             \
      --prefix=/usr                      \
      --host=$LFS_TGT                    \
      --build=$(../scripts/config.guess) \
      --enable-kernel=3.2                \
      --with-headers=$LFS/usr/include    \
      libc_cv_slibdir=/usr/lib

make

echo -e "Warning on the command 'make DESTDIR=$LFS install' \n"
make DESTDIR=$LFS install


echo -e "\nNext command : sed '/RTLDLIST=/s@/usr@@g' -i $LFS/usr/bin/ldd"
sed '/RTLDLIST=/s@/usr@@g' -i $LFS/usr/bin/ldd

echo 'int main(){}' > dummy.c
$LFS_TGT-gcc dummy.c
readelf -l a.out | grep '/ld-linux'


rm -v dummy.c a.out


$LFS/tools/libexec/gcc/$LFS_TGT/11.2.0/install-tools/mkheaders

