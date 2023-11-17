#! /bin/bash

cd $1

echo -e "Next command: sed -i s/mawk// configure\n"

sed -i s/mawk// configure


mkdir build
pushd build
  ../configure
  make -C include
  make -C progs tic
popd


echo -e "start configuration\n"
./configure --prefix=/usr                \
            --host=$LFS_TGT              \
            --build=$(./config.guess)    \
            --mandir=/usr/share/man      \
            --with-manpage-format=normal \
            --with-shared                \
            --without-debug              \
            --without-ada                \
            --without-normal             \
            --disable-stripping          \
            --enable-widec

echo -e "Make\n"
make

echo -e "make DESTDIR"
make DESTDIR=$LFS TIC_PATH=$(pwd)/build/progs/tic install
echo "INPUT(-lncursesw)" > $LFS/usr/lib/libncurses.so



