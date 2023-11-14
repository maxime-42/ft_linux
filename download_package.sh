#!/bin/bash

echo -e  "\n***Download package ***\n"
destination=$LFS/sources
# Lit le fichier CSV et traite chaque ligne
while IFS=';' read -r package_name version link md5 installed
do
    # Affiche les informations du paquet
    echo  "Nom du paquet : $package_name"
    echo  "Version : $version"
    echo  "Lien de téléchargement : $nk"
    echo  "Somme de contrôle MD5 : $md5"
    echo "Installed : $installed"

   # Check if the package had  already installed
   if [ "$installed" == "no" ]; then
   	wget -P $LFS/sources "$link"
	if [ $? -eq 0 ]; then
       		echo -e "\nDownload success  : $package_name $version\n !!!"
 		tar -xf $destination/$package_name-$version.tar*
		mv  $package_name-$version $destination
		chown -R lfs:lfs $directory_path
		rm -rf $destination/$package_name-$version.tar*  
	else
   
       		echo "echec du téléchargement : $package_name $version"
	fi
   else
  	echo -e  "$package_name has been already download.\n"
   fi


    echo -e "_____________________________________\n"
done < package_list.csv
