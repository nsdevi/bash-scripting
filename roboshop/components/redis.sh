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

