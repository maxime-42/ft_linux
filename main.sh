#! /bin/bash

CHAPITER_5=5

echo -e "\n\n--------- START lfs user -------\n"
#######################
sh setup_env.sh
#######################
sh download_package.sh
#######################
sh install_package.sh $CHAPITER_5 
######################
