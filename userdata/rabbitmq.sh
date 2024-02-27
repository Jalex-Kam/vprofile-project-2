#!/bin/bash
#https://centlinux.com/install-rabbitmq-on-linux/

sudo dnf update -y
sudo dnf install -y epel-release
sudo yum install wget -y
sudo yum install firewalld -y

sudo yum remove centos-release-rabbitmq-38 -y # remove the repo if exit

cd /tmp/  #chnage to temp folder

#To install RabbitMQ official yum repository, execute following command at Linux terminal.
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash

#Similarly, you should also install RabbitMQ ErLang repository.
curl -1sLf 'https://dl.cloudsmith.io/public/rabbitmq/rabbitmq-erlang/setup.rpm.sh' | sudo -E bash

#Build yum cache for newly installed yum repositories.
dnf makecache -y

#Install RabbitMQ on Linux:
sudo dnf install -y rabbitmq-server

#start and enable rabbitmq
sudo systemctl enable --now rabbitmq-server.service
sudo systemctl status rabbitmq-server
#configuring RabbitMQ to disable loopback users. [good for security]
sudo sh -c 'echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config'
##add test user to rabbitmq
sudo rabbitmqctl add_user test test
sudo rabbitmqctl set_user_tags test administrator
sudo systemctl restart rabbitmq-server

# start and enable firewalld
sudo systemctl start firewalld
sudo systemctl enable firewalld
# check firewalld status
sudo systemctl status firewalld

sudo firewall-cmd --add-port=5672/tcp
sudo firewall-cmd --runtime-to-permanent

# check open on firewalld
sudo firewall-cmd --list-all
