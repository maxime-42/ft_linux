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



# Variable for chapter number based on script argument
CHAPTER="chapter-$1"

# Reading CSV file and processing each line
while IFS=';' read -r package_name version download_link md5_checksum installed part
do
    # Displaying package information

    echo -e "\n INSTALLATION :\n"
    echo  "Package Name: $package_name"
    echo  "Version: $version"
    echo  "Download Link: $download_link"
    echo  "MD5 Checksum: $md5_checksum"
    echo "Installed : " $installed
    echo -e "Part : $part"
    echo -e "Path: $LFS/sources/$package_name-$version \n"
    
    file_path=$CHAPTER/$package_name.sh
    directory_path=$LFS/sources/$package_name-$version/build
   
    if [[ "$package_name" == "libstdc++" && "$download_link" == "" && "$installed" == "no" ]]; then
   	  sh "$CHAPTER/$package_name.sh" $LFS/sources/$package_name-$version
	   update_csv_file "package_list.csv"
    elif [[ "$package_name" == "binutils" && "$part" == "2" && "$installed" == "no" ]]; then
	  sh "$CHAPTER/$package_name.sh" $LFS/sources/$package_name-$version "2"

	   update_csv_file "package_list.csv"
    elif [[ "$package_name" == "gcc" && "$part" == "2" && "$installed" == "no" ]]; then
	   sh "$CHAPTER/$package_name.sh" $LFS/sources/$package_name-"part-"$part $part 
	   update_csv_file "package_list.csv"
    
    elif [ "$installed" == "no" ]; then
	# Changing directory to the specified chapter
	pushd $CHAPTER

		# Running the package installation script and logging output to a file
		sh $package_name.sh $LFS/sources/$package_name-$version
		
		#sh $package_name.sh $package_name-$version | tee > $package_name.log
		# Returning to the previous directory

	   	update_csv_file "package_list.csv"
	popd

    else
       echo -e "The package '$package_name' has been already installed"
    fi
    
    echo -e "_____________________________________\n"
done < package_list.csv

