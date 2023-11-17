#!/bin/bash

# Specify the file path you want to check

file_path="/home/lfs/.bash_profile"
# Check if the file doesn't exist

if [ ! -e "$file_path" ]; then
	echo -e "\nstart config user .bashrc and .bash_profile yet.\n"

cat > /home/lfs/.bash_profile << "EOF"
       exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

	chown lfs:lfs /home/lfs/.bash_profile 

	source ~/.bash_profile

	cat > /home/lfs/.bashrc << "EOF"
	set +h
	umask 022
	LFS=/mnt/lfs
	LC_ALL=POSIX
	alias ll='ls -l'
	alias la='ls -A'
	alias l='ls -CF'
	LFS_TGT=$(uname -m)-lfs-linux-gnu
	PATH=/usr/bin
	if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
	PATH=$LFS/tools/bin:$PATH
	CONFIG_SITE=$LFS/usr/share/config.site
	export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
EOF


	## Set ownership to the lfs user
	chown lfs:lfs /home/lfs/.bashrc
	source ~/.bashrc
	echo -e "bashrc and bashrc_profile coming create\n"
else
	echo -e  "bashrc and bash_profile  files already exists."
fi

