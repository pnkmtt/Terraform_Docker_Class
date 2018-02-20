#!/bin/bash
sudo apt update
sudo apt install unzip -y
unzip /vagrant/terraform_0.11.3_linux_amd64.zip -d /var/tmp/
sudo cp /var/tmp/terraform /usr/sbin/terraform
sudo chmod 755 /usr/sbin/terraform