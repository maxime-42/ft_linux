cd $1

./configure --prefix=/usr --host=$LFS_TGT

echo -e "Next command: make"
make 

echo -e "Next command: make: make DESTDIR=$LFS install"
make DESTDIR=$LFS install

