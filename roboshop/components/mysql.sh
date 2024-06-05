#!/bin/bash
set -e
source components/common.sh
COMPONENT=mysql

echo -n "Configuring $COMPONENT repos"
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/stans-robot-project/mysql/main/mysql.repo
stat $?

echo -n "Installing $COMPONENT"
yum install mysql-community-server -y
stat $?

echo -n "Starting $COMPONENT"
systemctl enable mysqld 
systemctl start mysqld
stat $?

echo -n "Fetching the password"
DEFAULT_ROOT_PASSOWRD=$(sudo grep temp /var/log/mysqld.log | head -n 1 | awk -F " " '{print $NF}')
stat $?

echo -n "changing the default password"
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1';" | mysql --connect-expired-password -uroot -p${DEFAULT_ROOT_PASSOWRD}
stat $?
