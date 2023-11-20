#! /bin/bash
# Script Name: mount_vfs.sh
# Description: Script to check and mount virtual filesystems.
# Author: [Your Name]
# Date: [Current Date]



# Variables
LFS="/mnt/lfs"

# Function to check if a mount point is already mounted
is_mounted() {
  grep -qs "$1" /proc/mounts
}


# Function to check if a file exists
file_exists() {
  [ -e "$1" ]
}


# Check before running chown command
if ! $(ls -la "$LFS" | grep -q "root root"); then
	echo "Running chown command..."
	chown -R root:root "$LFS/{usr,lib,var,etc,bin,sbin,tools,sources,lib64}"
	echo "chown command completed."
else
	echo "chown command skipped as ownership is already set to root:root."
fi

echo -e "creation des répertoires dans lesquels les systèmes de fichiers seront mont"
mkdir -pv $LFS/{dev,proc,sys,run}

if ! file_exists "$LFS/dev/console"; then
	echo -e "Création desnoued initiaux vers les périphériq '/dev/console'\n"
	mknod -m 600 "$LFS/dev/console" c 5 1
fi

if ! file_exists "$LFS/dev/null"; then

	echo -e "Création de isnoued initiaux vers les périphériq '/dnull"
	mknod -m 666 "$LFS/dev/null" c 1 3
fi

# Mount and populate /dev
if ! is_mounted "$LFS/dev"; then
	echo -e "Monter et peupler dev\n"
      	mount -v --bind /dev "$LFS/dev"
fi

# Mount virtual filesystems

if ! is_mounted "$LFS/dev/pts"; then
	echo -e "Monter les systèmes de fichiers virtuels du noyau\n"
      	mount -v --bind /dev/pts "$LFS/dev/pts"
fi

if ! is_mounted "$LFS/proc"; then
	echo -e "monter pro\n"
	 mount -vt proc proc "$LFS/proc"
fi

if ! is_mounted "$LFS/sys"; then
	echo -e "mounte sysfs"
	mount -vt sysfs sysfs "$LFS/sys"
fi

if ! is_mounted "$LFS/run"; then
	echo -e "mount tmpfs \n"
	mount -vt tmpfs tmpfs "$LFS/run"
fi



if [ -h $LFS/dev/shm ]; then
  mkdir -pv $LFS/$(readlink $LFS/dev/shm)
fi


#cho -e "Env chroot\n"
#hroot "$LFS" /usr/bin/env -i   \
#   HOME=/root                  \
#   TERM="$TERM"                \
#   PS1='(lfs chroot) \u:\w\$ ' \
#   PATH=/usr/bin:/usr/sbin     \
#   /bin/bash --login +h -c "ls -l"
