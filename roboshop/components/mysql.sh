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
