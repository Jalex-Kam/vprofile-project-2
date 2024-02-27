#!/bin/bash
sudo dnf install epel-release -y
sudo dnf install memcached -y
sudo yum install firewalld -y
sudo systemctl start memcached
sudo systemctl enable memcached
sudo systemctl status memcached

sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/sysconfig/memcached
sudo systemctl restart memcached

# start and enable firewalld
sudo systemctl start firewalld
sudo systemctl enable firewalld
# check firewalld status
sudo systemctl status firewalld

# open port on the firewall
sudo firewall-cmd --add-port=11211/tcp
sudo firewall-cmd --runtime-to-permanent
sudo firewall-cmd --add-port=11111/udp
sudo firewall-cmd --runtime-to-permanent
sudo memcached -p 11211 -U 11111 -u memcached -d

# check open on firewalld
sudo firewall-cmd --list-all
