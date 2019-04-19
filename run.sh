#! /bin/bash

set +e

while true; do
	read -p "Create User Deef? [y/n]" yn
	case $yn in
	[Yy]*)
		useradd --home /home/deef --create-home --shell /bin/bash deef
		;;
	[Nn]*) break ;;

	*) echo "Please answer yes or no." ;;
	esac
done

#This program runs an automated script that loads in all the necessary files such as public keys and alias files and file structures

#check for sudo
#if [[ $EUID -ne 0 ]]; then
#	echo "This script must be run as root"
#	exit 1
#fi

while true; do
	read -p "Move files into home? [y/n]" yn
	case $yn in
	[Yy]*)
		#move bash aliases to home directory
		cp -f .bash_aliases ~/.bash_aliases
		cp -f .dircolors ~/.dircolors

		;;
	[Nn]*) break ;;

	*) echo "Please answer yes or no." ;;
	esac
done

while true; do
	read -p "update/upgrade/install? [y/n]" yn
	case $yn in
	[Yy]*)
		sudo apt update
		sudo apt upgrade
		sudo apt install openssh-server htop
		;;
	[Nn]*) break ;;

	*) echo "Please answer yes or no." ;;
	esac
done

while true; do
	read -p "Update Key Values? [y/n]" yn
	case $yn in
	[Yy]*)
		#force no root login over ssh
		sudo sed -i 's/#\?\s*\(PermitRootLogin\s*\).*$/\1 no/' /etc/ssh/sshd_config

		#force no password authentication over ssh
		sudo sed -i 's/#\?\s*\(PasswordAuthentication\s*\).*$/\1 no/' /etc/ssh/sshd_config

		#force allow public key authentication
		sudo sed -i 's/#\?\s*\(PubkeyAuthentication\s*\).*$/\1 yes/' /etc/ssh/sshd_config
		;;
	[Nn]*) break ;;

	*) echo "Please answer yes or no." ;;
	esac
done

#replace authorized keys file to .ssh/authorized_keys

while true; do
	read -p "Add authorized Keys? [y/n]" yn
	case $yn in
	[Yy]*)
		mkdir ~/.ssh
		touch ~.ssh/authorized_keys
		cat authorized_keys >>~/.ssh/authorized_keys
		;;
	[Nn]*) break ;;

	*) echo "Please answer yes or no." ;;
	esac
done

#echo setting git user
#set git user
#read -p "Enter name for git [Jeffrey Koehler Auto]: " name
#name=${name:-"Jeffrey Koehler Auto"}
#git config --global user.name $name

#set git email
#read -p "Enter name for git [jeffreykoehlerauto@deef.tech]: " email
#email=${email:-"jeffreykoehlerauto@deef.tech"}
#git config --global user.email $email

source ~/.bashrc
