#!/bin/bash

source components/common.sh
COMPONENT=mysql

echo -n "Configuring $COMPONENT repos"
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/stans-robot-project/mysql/main/mysql.repo
stat $?

echo -n "Installing $COMPONENT"
yum install mysql-community-server -y >> /tmp/$COMPONENT.log
stat $?

echo -n "Starting $COMPONENT"
systemctl enable mysqld 
systemctl start mysqld
stat $?

echo -n "Fetching the default root password"
DEFAULT_ROOT_PASSOWRD=$(sudo grep temp /var/log/mysqld.log | head -n 1 | awk -F " " '{print $NF}')
stat $?

#it execute only if exit code is non zero
echo 'show databases;' | mysql -uroot -pRoboShop@1 &>> /tmp/$COMPONENT.log
if [ $? -ne 0 ]; then
echo -n "reset the root default password"
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1';" | mysql --connect-expired-password -uroot -p"${DEFAULT_ROOT_PASSOWRD}"
stat $?
fi

echo 'show plugins;' | mysql -uroot -pRoboShop@1 &>> /tmp/$COMPONENT.log | grep validate_password >> /tmp/$COMPONENT.log
if [ $? -eq 0 ]; then
echo -n "uninstall the password validate plugin"
echo "uninstall plugin validate_password;" | mysql -uroot -pRoboShop@1 &>> /tmp/pluginvalidate
stat $?
fi


