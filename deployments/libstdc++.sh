#! /bin/bash

cd  "$LFS/sources/gcc-part-1/"



mkdir -v build
cd build

echo -e "\nCurrent directory : $PWD\n" 

../libstdc++-v3/configure           \
   --host=$LFS_TGT                 \
   --build=$(../config.guess)      \
   --prefix=/usr                   \
   --disable-multilib              \
   --disable-nls                   \
   --disable-libstdcxx-pch         \
   --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/11.2.0

make
make DESTDIR=$LFS install



echo -e "\n\nStart delete : $LFS/sources/libstdc++\n" 
echo -e "Start delete :  $LFS/sources/gcc-11.2.0.tar.xz\n\n" 
echo -e "Back to $LFS/sources\n"

cd $LFS/sources

echo -e "\nBefor delete:\n"
ls -ll


rm -rf "$LFS/sources/libstdc++"
rm -rf "$LFS/sources/gcc-11.2.0.tar.xz"

echo -e "\nAfter deleted:\n"
ls -ll
