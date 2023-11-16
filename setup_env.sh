#!/bin/bash

# Variables
LFS="/mnt/lfs"
LFS_DISK="/dev/sdb"
LFS_TGT="x86_64-lfs-linux-gnu"

# Check if variables exist in .bashrc
#if ! grep -q "export LFS=" ~/.bashrc; then
  echo "export LFS=\"$LFS\"" >> ~/.bashrc
#fi

#if ! grep -q "export LFS_DISK=" ~/.bashrc; then
  echo "export LFS_DISK=\"$LFS_DISK\"" >> ~/.bashrc
#fi

#if ! grep -q "export LFS_TGT=" ~/.bashrc; then
  echo "export LFS_TGT=\"$LFS_TGT\"" >> ~/.bashrc
#fi

# Load the updated .bashrc
source ~/.bashrc

echo "Environment variables set:"
echo "LFS=$LFS"
echo "LFS_DISK=$LFS_DISK"
echo "LFS_TGT=$LFS_TGT"

