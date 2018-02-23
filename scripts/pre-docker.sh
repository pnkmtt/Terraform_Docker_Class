#/bin/bash
#!/bin/bash
echo 'Running update'
sudo apt update
echo ' Installing Docker'
sudo apt install docker.io -y

#ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2376 -H unix:///var/run/docker.sock --storage-driver aufs --label provider=generic --mtu=1472 --bip=192.168.0.1/24
#sudo vi /lib/systemd/system/docker.service
#sudo systemctl daemon-reload
#sudo systemctl restart docker
