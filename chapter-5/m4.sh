#! /bin/bash




cd $1

echo -e "\nstart configuration\n"
./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)

echo -e "Next command: Make\n"
make

echo -e "Next command: make DESTDIR=$LFS install\n" 

make DESTDIR=$LFS install

