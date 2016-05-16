#!/bin/bash

if [ $EUID != 0 ]; then
	echo "this script must be run using sudo"
	echo ""
	echo "usage:"
	echo "sudo ./clean_linux_images.sh"
	exit $exit_code
	exit 1
fi
uname -r

echo "This script will destroy all linux images except the last one."
echo "If you have updated your linux image in this session, restart before using this script."

read -p "Are you sure you want to delete previous linux images? " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

sudo dpkg --list 'linux-image*'
dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge

sudo apt-get autoremove
sudo update-grub
