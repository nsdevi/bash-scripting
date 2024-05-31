#!/bin/bash
set -e
source components/common.sh

COMPONENT=redis

echo -n "Configuring the $COMPONENT repo"
curl -L https://raw.githubusercontent.com/stans-robot-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo
stat $?
echo -n "Installing $COMPONENT"
yum install redis-6.2.13 -y >> /tmp/$COMPONENT.log
stat $? 

echo -n "whitelisting the $COMPONENT config"
sed -i -e 's/127.0.0.1/0.0.0.0/g' /etc/$COMPONENT.conf
stat $?

echo -n "Starting $COMPONENT"
systemctl enable redis >> /tmp/$COMPONENT.log
systemctl start redis >> /tmp/$COMPONENT.log
stat $?

