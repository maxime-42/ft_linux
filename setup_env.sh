#!/bin/bash

#!/bin/bash

# Specify the file path you want to check

file_path="/home/lfs/.bash_profile"
# Check if the file doesn't exist
if [ ! -e "$file_path" ]; then
  echo "This file doesn't exist yet."

  cat > /home/lfs/.bash_profile << "EOF"
       exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF
chown lfs:lfs /home/lfs/.bash_profile 
source ~/.bash_profile
else
  echo "bash_profile is file exists."
fi


# Set up ~/.bash_profile
#cat > /home/lfs/.bash_profile << "EOF"
#exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
#EOF


file_path="/home/lfs/.bashrc"
# Check if the file doesn't exist
if [ ! -e "$file_path" ]; then
cat > /home/lfs/.bashrc << "EOF"
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
EOF

# Set ownership to the lfs user
chown lfs:lfs /home/lfs/.bash_profile /home/lfs/.bashrc

echo "User 'lfs' has been set up with custom bash configurations."

chown lfs:lfs /home/lfs/.bashrc
source ~/.bashrc
else
  echo "bash config  is already done."
fi


# Set up ~/.bashrc
#cat > /home/lfs/.bashrc << "EOF"
#set +h
#umask 022
#LFS=/mnt/lfs
#LC_ALL=POSIX
#LFS_TGT=$(uname -m)-lfs-linux-gnu
#PATH=/usr/bin
#if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
#PATH=$LFS/tools/bin:$PATH
#CONFIG_SITE=$LFS/usr/share/config.site
#export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
#EOF

# Set ownership to the lfs user
