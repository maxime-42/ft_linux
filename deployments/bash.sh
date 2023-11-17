
cd $1

./configure --prefix=/usr                   \
            --build=$(support/config.guess) \
            --host=$LFS_TGT                 \
            --without-bash-malloc

make
Installez le paquet :

make DESTDIR=$LFS install
Créez un lien pour les programmes qui utilisent sh comme shell :

ln -sv bash $LFS/bin/sh
