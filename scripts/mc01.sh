#!/bin/bash

yum update -y

dnf install epel-release -y
dnf install memcached -y

systemctl start memcached
systemctl enable memcached

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/sysconfig/memcached

systemctl restart memcached

systemctl start firewalld
systemctl enable firewalld

firewall-cmd --permanent --add-port=11211/tcp
firewall-cmd --permanent --add-port=11111/udp
firewall-cmd --reload