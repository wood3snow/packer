#!/bin/bash

VAGRANT_USER=vagrant
VAGRANT_HOME=/home/${VAGRANT_USER}

# Installing packages
echo "Installing packages ..."
sudo yum -y install gcc make perl kernel-headers-`uname -r` kernel-devel-`uname -r`

# Installing Virtualbox Guest Additions
echo "Installing VirtualBox Guest Additions ..."

VBOX_VERSION=$(cat ${VAGRANT_HOME}/.vbox_version)
sudo mount -t iso9660 -o loop ${VAGRANT_HOME}/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sudo sh /mnt/VBoxLinuxAdditions.run
sudo umount /mnt
sudo /etc/rc.d/init.d/vboxadd setup
sudo chkconfig vboxadd-x11 off
rm ${VAGRANT_HOME}/VBoxGuestAdditions_$VBOX_VERSION.iso
