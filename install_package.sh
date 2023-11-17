#!/bin/bash
# Script Header: LFS Package Installation Script
# Description: This script installs packages listed in a CSV file for Linux From Scratch (LFS).
# Author: [mkayumba]
# Date: [Current Date]

# Creating sources directory if not exists
#mkdir -p /sources



update_csv_file() {
local csv_file="$1"

  # Check if the file exists
  if [ -f "$csv_file" ]; then
    # Use sed to replace 'no' with 'yes' in the CSV file
    sed -i 's/\bno\b/yes/g' "$csv_file"
    echo "Updated '$csv_file' - 'no' replaced with 'yes'."
  else
    echo "Error: File '$csv_file' not found."
  fi
}



deploy_script=""
# Reading CSV file and processing each line
while IFS=';' read -r package_name version download_link md5_checksum installed part
do
    # Displaying package information

    echo -e "\n\n INSTALLATION :\n"
    echo  "Package Name: $package_name"
    echo  "Version: $version"
    echo  "Download Link: $download_link"
    echo  "MD5 Checksum: $md5_checksum"
    echo  "Installed : " $installed
    echo  "Part : $part"
    
    directory_package=""
    if [ $part != "" ]; then
    	deploy_script="$package_name-part-$part.sh"
    	directory_package="$LFS/sources/$package_name-part-$part"
    else
    	deploy_script="$package_name.sh" 
    	directory_package="$LFS/sources/$package_name-$version"
    fi
    
    echo  -e "Deployment script :  $deploy_script\n"
    echo  -e "Directory package :  $directory_package \n\n"

    if [ "$installed" == "no" ]; then
	pushd "deployments"
		# Running the package installation script and logging output to a file
		sh $deploy_script $directory_package
		#update_csv_file "package_list.csv"
	popd
   	echo -e "Success installation :  $package_name\n" 
    else
		echo -e "The package '$package_name' has been already installed"
    fi
    echo -e "_____________________________________\n"
done < package_list.csv

