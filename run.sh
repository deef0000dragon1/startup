#! /bin/bash

set +e

useradd --home /home/deef --create-home --shell /bin/bash deef



#This program runs an automated script that loads in all the necessary files such as public keys and alias files and file structures

#check for sudo
#if [[ $EUID -ne 0 ]]; then
#	echo "This script must be run as root"
#	exit 1
#fi

#move bash aliases to home directory
cp -f .bash_aliases /home/deef/.bash_aliases

echo updating and upgrading
#install programs
sudo apt update
sudo apt upgrade
echo installing openssh, htop
sudo apt install openssh-server htop

echo forcing ssh key login
#force no root login over ssh
sudo sed -i 's/#\?\s*\(PermitRootLogin\s*\).*$/\1 no/' /etc/ssh/sshd_config

#force no password authentication over ssh
sudo sed -i 's/#\?\s*\(PasswordAuthentication\s*\).*$/\1 no/' /etc/ssh/sshd_config

#force allow public key authentication
sudo sed -i 's/#\?\s*\(PubkeyAuthentication\s*\).*$/\1 yes/' /etc/ssh/sshd_config

echo adding keys to authorized_keys
#replace authorized keys file to .ssh/authorized_keys
mkdir /home/deef/.ssh
touch /home/deef/.ssh/authorized_keys
cp -f authorized_keys /home/deef/.ssh/authorized_keys


echo setting git user
#set git user
#read -p "Enter name for git [Jeffrey Koehler Auto]: " name
#name=${name:-"Jeffrey Koehler Auto"}
#git config --global user.name $name

#set git email
#read -p "Enter name for git [jeffreykoehlerauto@deef.tech]: " email
#email=${email:-"jeffreykoehlerauto@deef.tech"}
#git config --global user.email $email

echo setting girectory colors
#set colors
cp .dircolors /home/deef/.dircolors

echo reloading bashrc.
#reload the bash file, reloading all the 

su deef

source /home/deef/.bashrc
