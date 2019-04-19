#! /bin/bash
#This program runs an automated script that loads in all the necessary files such as public keys and alias files and file structures

#check for sudo
if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root"
	exit 1
fi

#move bash aliases to home directory
cp -f .bash_aliases ~/.bash_aliases

#install programs
sudo apt update
sudo apt upgrade
sudo apt install openssh htop


#force no root login over ssh
sudo sed -i 's/#\?\s*\(PermitRootLogin\s*\).*$/\1 no/' /etc/ssh/sshd_config

#force no password authentication over ssh
sudo sed -i 's/#\?\s*\(PasswordAuthentication\s*\).*$/\1 no/' /etc/ssh/sshd_config

#force allow public key authentication
sudo sed -i 's/#\?\s*\(PubkeyAuthentication\s*\).*$/\1 yes/' /etc/ssh/sshd_config

#replace authorized keys file to .ssh/authorized_keys
mkdir ~/.ssh
touch ~/.ssh/authorized_keys
cp -f authorized_keys ~/.ssh/authorized_keys



#set git user
read -p "Enter name for git [Jeffrey Koehler Auto]: " name
name=${name:-"Jeffrey Koehler Auto"}
git config --global user.name $name

#set git email
read -p "Enter name for git [jeffreykoehlerauto@deef.tech]: " email
email=${email:-"jeffreykoehlerauto@deef.tech"}
git config --global user.email $email

#reload the bash file, reloading all the 
source ~/.bashrc
