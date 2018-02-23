#!/bin/bash
echo 'copy in ssh keys'
cp /vagrant/files/ssh/id_rsa* ~vagrant/.ssh
chmod 644 ~vagrant/.ssh/id_rsa*
cat ~vagrant/.ssh/id_rsa.pub >> ~vagrant/.ssh/authorized_keys
#echo 'add ansible respoitory'
#sudo apt-add-repository ppa:ansible/ansible -y
echo 'update system'
sudo apt-get update -y
echo 'install ansible'
sudo apt-get install software-properties-common python-software-properties ansible -y
