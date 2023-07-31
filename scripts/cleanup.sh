#!/bin/bash

set -ueo pipefail

while [ ! -f /var/lib/cloud/instance/boot-finished ]; do sleep 5; done

sudo rm /etc/netplan/*
#sudo sed -i 's/ip=dhcp//g' /etc/default/grub
#sudo update-grub
#sudo apt -y purge cloud-init

exit 0
