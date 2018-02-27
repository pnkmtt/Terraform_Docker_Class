#!/bin/bash
echo 'copy in lab ssh keys'
cp /vagrant/files/ssh/id_rsa* ~vagrant/.ssh
chmod 644 ~vagrant/.ssh/id_rsa*
cat ~vagrant/.ssh/id_rsa.pub >> ~vagrant/.ssh/authorized_keys
echo 'install ansible 2.4'
sudo apt update
#sudo apt upgrade -y
sudo apt install software-properties-common python-software-properties -y
sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible -y
ansible --version
echo 'because of windows copy the inventory file to a directory and fix permissions - this is a hack'
cp /vagrant/hosts /var/tmp/hosts
chmod -x /var/tmp/hosts