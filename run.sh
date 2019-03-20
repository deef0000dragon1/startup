#! /bin/bash
#This program runs an automated script that loads in all the necessary files such as public keys and alias files and file structures

#check for sudo
if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root"
	exit 1
fi

#move bash aliases to home directory
cp -f .bash_aliases ~/.bash_aliases

source .
#install ssh if it does not exist.
sudo apt install openssh
sudo apt install speedtest-cli
sudo apt install htop

#replace authorized keys file to .ssh/authorized_keys
mkdir ~/.ssh
touch ~/.ssh/authorized_keys
cp -f authorized_keys ~/.ssh/authorized_keys

##Set up git config etc.

#set colors
eval $(dircolors -b .dircolors)
