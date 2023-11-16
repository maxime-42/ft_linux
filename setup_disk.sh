#!/bin/bash

# Header Comments:
# Script Name: partition_and_format.sh
# Description: Script to partition and format a disk with a boot partition, swap partition, and system partition.
# Author: [Your Name]
# Date: [Current Date]

# Variables
disk="/dev/sdb"
boot_size="512M"
swap_size="8G"  # You can adjust this based on your system's needs
system_partition_start=""

echo -e "START PARTITION DISK"

# Partition the disk
echo -e "o\nn\np\n1\n\n+${boot_size}\na\n1\nt\n83\nn\np\n2\n\n+${swap_size}\nt\n2\n82\nn\np\n3\n\n\nw" | sudo fdisk "$disk"

# Set the boot partition flag
parted "$disk" set 1 boot on

# Make sure the partitions are recognized
partprobe "$disk"

# Format the partitions
sudo mkfs.ext2 "${disk}2"  # Boot partition
sudo mkswap "${disk}2"     # Swap partition
sudo mkfs.ext4 "${disk}3"  # System partition

# Display partition information
lsblk -f "$disk"


echo -e "Point de montage et montez le système de fichiers LFS\n"

sudo mkdir -pv $LFS
sudo mount -v -t ext4 ${disk}3 $LFS


