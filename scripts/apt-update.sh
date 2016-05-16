#!/bin/bash

if [ $EUID != 0 ]; then
	echo "this script must be run using sudo"
	echo ""
	echo "usage:"
	echo "sudo ./apt-update.sh"
	exit $exit_code
  exit 1
fi

apt-get update
apt-get dist-upgrade
apt-get autoremove
