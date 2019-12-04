#! /bin/bash


set +e

if getent passwd deef > /dev/null 2>&1; then
	echo "User deef already exists"
else
	while true; do
		read -p "Create User Deef? [y/n]" yn
		case $yn in
		[Yy]*)
			useradd --home /home/deef --create-home --shell /bin/bash deef
			break
			;;
		[Nn]*) break ;;
		*) echo "Please answer yes or no." ;;
		esac
	done
fi

#This program runs an automated script that loads in all the necessary files such as public keys and alias files and file structures

#check for sudo
#if [[ $EUID -ne 0 ]]; then
#	echo "This script must be run as root"
#	exit 1
#fi

while true; do
	read -p "Set New Hostname? [y/n]" yn
	case $yn in
	[Yy]*)
		read -p "Enter New Hostname: " name
		sudo hostnamectl set-hostname $name
		break
		;;
	[Nn]*) break ;;

	*) echo "Please answer yes or no." ;;
	esac
done


while true; do
	read -p "Move files into home? [y/n]" yn
	case $yn in
	[Yy]*)
		#move bash aliases to home directory
		cp -f .bash_aliases ~/.bash_aliases
		cp -f .dircolors ~/.dircolors

		break
		;;
	[Nn]*) break ;;

	*) echo "Please answer yes or no." ;;
	esac
done

while true; do
	read -p "Append 'source .bash_alisese' to .bashrc? [y/n]" yn
	case $yn in
	[Yy]*)
		#move bash aliases to home directory
		echo "test -f ~/startup/.bash_alises && . ~/startup/.bash_alisese" >> ~/.bashrc
		test -f ~/.bash_profile && echo "test -f ~/.bashrc && . ~/.bashrc" >> ~/.bash_profile

		break
		;;
	[Nn]*) break ;;

	*) echo "Please answer yes or no." ;;
	esac
done

while true; do
	read -p "Move files into root? [y/n]" yn
	case $yn in
	[Yy]*)
		#move bash aliases to home directory
		sudo cp -f .bash_aliases /root/.bash_aliases
		sudo cp -f .dircolors /root/.dircolors

		break
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
		break
		;;
	[Nn]*) break ;;

	*) echo "Please answer yes or no." ;;
	esac
done

while true; do
	read -p "Update Key Settings? [y/n]" yn
	case $yn in
	[Yy]*)
		#force no root login over ssh
		sudo sed -i 's/#\?\s*\(PermitRootLogin\s*\).*$/\1 no/' /etc/ssh/sshd_config

		#force no password authentication over ssh
		sudo sed -i 's/#\?\s*\(PasswordAuthentication\s*\).*$/\1 no/' /etc/ssh/sshd_config

		#force allow public key authentication
		sudo sed -i 's/#\?\s*\(PubkeyAuthentication\s*\).*$/\1 yes/' /etc/ssh/sshd_config
		break
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
		touch ~/.ssh/authorized_keys
		cat authorized_keys >>~/.ssh/authorized_keys
		break
		;;
	[Nn]*) break ;;

	*) echo "Please answer yes or no." ;;
	esac
done

while true; do
	read -p "Add authorized Keys to root? [y/n]" yn
	case $yn in
	[Yy]*)
		sudo mkdir /root/.ssh
		sudo touch /root/.ssh/authorized_keys
		sudo cat authorized_keys >>/root/.ssh/authorized_keys
		break
		;;
	[Nn]*) break ;;

	*) echo "Please answer yes or no." ;;
	esac
done



while true; do
	read -p "Regenerate SSH Server Keys? [y/n]" yn
	case $yn in
	[Yy]*)
		sudo rm -v /etc/ssh/ssh_host_*
		sudo dpkg-reconfigure openssh-server
		sudo systemctl restart ssh
		break
		;;
	[Nn]*) break ;;

	*) echo "Please answer yes or no." ;;
	esac
done


while true; do
	read -p "Install Golang? [y/n]" yn
	case $yn in
	[Yy]*)
		rm update-golang.sh
		wget https://raw.githubusercontent.com/udhos/update-golang/master/update-golang.sh
		sudo bash ./update-golang.sh
		break
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
