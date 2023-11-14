#!/bin/bash

# Script Header: LFS Package Installation Script
# Description: This script installs packages listed in a CSV file for Linux From Scratch (LFS).
# Author: [mkayumba]
# Date: [Current Date]

# Creating sources directory if not exists
#mkdir -p /sources

echo -e "\n*** Installation ***\n"

# Variable for chapter number based on script argument
CHAPTER="chapter-$1"

# Reading CSV file and processing each line
while IFS=';' read -r package_name version download_link md5_checksum installed
do
    # Displaying package information
    echo  "Package Name: $package_name"
    echo  "Version: $version"
    echo  "Download Link: $download_link"
    echo  "MD5 Checksum: $md5_checksum"
    echo "Installed : " $installed
    echo -e "Chapiter: $CHAPTER\n"

    file_path=$CHAPTER/$package_name.sh
    directory_path=$LFS/sources/$package_name-$version/build
   
  if [[ "$package_name" == "libstdc++" && "$download_link" == "" && "$installed" == "no" ]]; then
   	  sh "$CHAPTER/$package_name.sh" $LFS/sources/$package_name-$version
   	  installed="yes"
   elif [[ "$package_name" == "binutils" && "$download_link" == "" && "$installed" == "no" ]]; then
	   sh "$CHAPTER/$package_name.sh" $LFS/sources/$package_name-$version "passe 2"
   	   installed="yes"

   elif [[ "$package_name" == "gcc" && "$download_link" == "" && "$installed" == "no" ]]; then
	   sh "$CHAPTER/$package_name.sh" $LFS/sources/$package_name-$version "passe 2"
   	   installed="yes"
   fi

  
   
    echo -e "Path: $LFS/sources/$package_name-$version "
    
    if [ "$installed" == "no" ]; then
 	echo -e "\nStart installation process : '$package_name' "
	# Changing directory to the specified chapter
	pushd $CHAPTER

		# Running the package installation script and logging output to a file
		sh $package_name.sh $LFS/sources/$package_name-$version
		
		#sh $package_name.sh $package_name-$version | tee > $package_name.log
		# Returning to the previous directory
	popd

    else
       echo -e "The package '$package_name' has been already installed"
    fi
    
    echo -e "_____________________________________\n"
done < package_list.csv

