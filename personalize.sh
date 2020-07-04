#!/bin/bash
adduser --disabled-password --gecos "" $1
ln -s "$2" /home/$1/winhome
echo 'PATH=$PATH:~/.local/bin' >> /home/$1/.profile
echo "$1 ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/$1_user"
