#!/bin/bash

destination=$LFS/sources
# Lit le fichier CSV et traite chaque ligne
while IFS=';' read -r package_name version link md5 installed part
do
	# Affiche les informations du paquet

	echo -e  "\n***Download***\n"
	echo  "Nom du paquet : $package_name"
	echo  "Version : $version"
	echo  "Lien de téléchargement$ :link"
	echo  "Somme de contrôle MD5 : $md5"
	echo "Installed : $installed"
	echo -e "Part : $part\n\n"	


	# Check if the package had already been installed
	if [[ "$md5" == "" && $installed == "no" ]]; then
		mkdir $LFS/sources/tmp
		new_dirname=$package_name-"part"-$part
		pushd $LFS/sources/tmp  
			wget "$link"
			tar -xf $package_name-$version.tar*
			mv  $package_name-$version ../$new_dirname
			cd ../
			chown -R lfs:lfs $new_dirname 
		popd
		rm -rf $LFS/sources/tmp

	elif [ "$installed" == "no" ]; then
	    wget -P $LFS/sources "$link"
	    if [ $? -eq 0 ]; then
		echo -e "\nDownload success  : $package_name $version\n !!!"
		tar -xf $destination/$package_name-$version.tar*
		mv  $package_name-$version $destination
		chown -R lfs:lfs $destination/$package_name-$version  # Corrected this line
		rm -rf $destination/$package_name-$version.tar*
	    else
		echo "echec du téléchargement : $package_name $version"
	    fi
	else
	    echo -e  "$package_name has been already downloaded.\n"
	fi

	echo -e "_____________________________________\n"
done < package_list.csv
