#!/bin/bash

yum update -y

yum install epel-release -y
yum install wget -y

cd /tmp

dnf -y install centos-release-rabbitmq-38

dnf --enablerepo=centos-rabbitmq-38 -y install rabbitmq-server

systemctl enable --now rabbitmq-server

echo '[{rabbit, [{loopback_users, []}]}].' > /etc/rabbitmq/rabbitmq.config

rabbitmqctl add_user test test
rabbitmqctl set_user_tags test administrator

systemctl restart rabbitmq-server

systemctl start firewalld
systemctl enable firewalld

firewall-cmd --permanent --add-port=5672/tcp
firewall-cmd --reload