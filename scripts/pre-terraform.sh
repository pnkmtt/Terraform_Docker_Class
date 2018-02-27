#!/bin/bash
echo '-----------------------copy in lab ssh keys-------------------------'
cp /vagrant/files/ssh/id_rsa* ~vagrant/.ssh
chmod 644 ~vagrant/.ssh/id_rsa*
cat ~vagrant/.ssh/id_rsa.pub >> ~vagrant/.ssh/authorized_keys
echo '-----------------------Run update-------------------------'
sudo apt update
#sudo apt upgrade -y
echo '-----------------------Install software-properties-common and python-software-properties-------------------------'
sudo apt install software-properties-common python-software-properties -y
echo '-----------------------Install ansible repository-------------------------'
sudo apt-add-repository ppa:ansible/ansible
echo '-----------------------Run update-------------------------'
sudo apt update
echo '-----------------------Install ansible-------------------------'
sudo apt install ansible -y
echo 'Because I did this on windows we copy the inventory file to a directory and fix permissions - this is a hack'
cp /vagrant/hosts /var/tmp/hosts
chmod -x /var/tmp/hosts