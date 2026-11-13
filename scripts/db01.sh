
#!/bin/bash

# Update system
yum update -y

# Install packages
yum install epel-release -y
yum install git mariadb-server -y

# Start MariaDB
systemctl start mariadb
systemctl enable mariadb

# Configure database
mysql -e "CREATE DATABASE accounts;"
mysql -e "CREATE USER '${DB:-CHANGE_ME}'@'%' IDENTIFIED BY '${DB_PASSWORD:-CHANGE_ME}';"
mysql -e "GRANT ALL PRIVILEGES ON accounts.* TO '${DB_USERNAME:-CHANGE_ME}'@'%';"
mysql -e "FLUSH PRIVILEGES;"

# Download project
git clone -b main https://github.com/hkhcoder/vprofile-project.git

# Import database
mysql accounts < vprofile-project/src/main/resources/db_backup.sql

# Configure firewall
systemctl start firewalld
systemctl enable firewalld
firewall-cmd --permanent --add-port=3306/tcp
firewall-cmd --reload

# Restart MariaDB
systemctl restart mariadb
