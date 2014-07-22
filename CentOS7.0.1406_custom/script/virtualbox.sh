#!/bin/bash

VAGRANT_USER=vagrant
VAGRANT_HOME=/home/${VAGRANT_USER}

# Installing packages
echo "Installing packages ..."
sudo yum -y install gcc make bzip2 perl kernel-headers-`uname -r` kernel-devel-`uname -r`

# Installing Virtualbox Guest Additions
echo "Installing VirtualBox Guest Additions ..."

VBOX_VERSION=$(cat ${VAGRANT_HOME}/.vbox_version)
sudo mount -t iso9660 -o loop ${VAGRANT_HOME}/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt


## Bug Fix
# sh /mnt/VBoxLinuxAdditions.run --noexec --target ~/vbox-extract
# mkdir ~/vbox-extract
# cd ~/vbox-extract
# mkdir vbox
# cd vbox
# tar jxvf ../VBoxGuestAdditions-amd64.tar.bz2
# cd src/vboxguest-4.3.12/vboxguest/r0drv/linux/
# sed -i -e "s/KERNEL_VERSION(3, 13, 0)/KERNEL_VERSION(3, 10, 0)/g" memobj-r0drv-linux.c
# cd ~/vbox-extract/vbox
# tar -jcvf ../VBoxGuestAdditions-amd64.tar.bz2 .
# cd ~/vbox-extract
# sudo ./install.sh


sudo sh /mnt/VBoxLinuxAdditions.run

sudo umount /mnt
sudo /etc/rc.d/init.d/vboxadd setup
sudo chkconfig vboxadd-x11 off

rm ${VAGRANT_HOME}/VBoxGuestAdditions_$VBOX_VERSION.iso
