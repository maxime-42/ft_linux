#! /bin/bash

#########################
partition="/dev/sdb3" 
mount_point="/mnt/lfs"

if grep -qs "$partition" /proc/mounts; then
	echo -e "$LFS is alreay mounted"
else
	sh setup_disk.sh
	sh setup_env.sh
fi

###########################
sh filesystem.sh
############################
sh add_user.sh
############################
