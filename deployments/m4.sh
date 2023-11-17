#! /bin/bash




cd $1

echo -e "Directory : $1\n"
ls -l

echo -e "\ncurrent directory : $PWD\n"

echo -e "\nstart configuration\n"

./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)

echo -e "Next command: Make\n"
make

echo -e "Next command: make DESTDIR=$LFS install\n" 

make DESTDIR=$LFS install

