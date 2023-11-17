#!/bin/bash

# Lit le fichier CSV et traite chaque ligne
while IFS=';' read -r package_name version link md5 installed part
do
	# Affiche les informations du paquet

	echo -e "\nDownload:\n"
	echo  "Nom du paquet : $package_name"
	echo  "Version : $version"
	echo  "Lien de téléchargement$ :link"
	echo  "Somme de contrôle MD5 : $md5"
	echo "Installed : $installed"
	echo -e "Part : $part\n\n"	

	# Check if the package had already been installed
	if [[ $part == "" && $installed == "no" ]]; then
		pushd $LFS/sources
			wget "$link"
			tar -xf $package_name-$version.tar*
			chown -R lfs:lfs $package_name-$version  # Corrected this line
			rm -rf $package_name-$version.tar*
			echo -e "\nDownload success  : $package_name $version, Part : $part\n"
		popd

	elif [[ $part != "" && "$installed" == "no" ]]; then
		tmp="$LFS/sources/tmp"
		mkdir -p $tmp
		package_dirname="$package_name-part-$part"
		pushd $tmp  
			wget "$link"
			tar -xf $package_name-$version.tar*
			mv  $package_name-$version ../$package_dirname
			cd ../
			chown -R lfs:lfs $package_dirname 
		
			echo -e "\nDownload success  : $package_name $version, Part : $part\n"
		popd
		rm -rf $tmp

	else
	    echo -e  "$package_name has been already downloaded.\n"
	fi

	echo -e "_____________________________________\n"
done < package_list.csv
