#!/bin/bash
cp /vagrant/files/ssh/id_rsa* ~vagrant/.ssh
chmod 644 ~vagrant/.ssh/id_rsa*
cat ~vagrant/.ssh/id_rsa.pub >> ~vagrant/.ssh/authorized_keys
