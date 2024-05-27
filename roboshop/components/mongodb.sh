#!/bin/bash
set -e 
source common.sh
COMPONENT=mongodb
echo -n "downloading ${COMPONENT} repo"
curl -s -o /etc/yum.repos.d/${COMPONENT}.repo https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/mongo.repo
stat $?

echo -n "Installing $COMPONENT Service"
yum install -y ${COMPONENT}-org
stat $?

echo -n "Starting $COMPONENT Service"
systemctl enable mongod >> /tmp/${COMPONENT}.log
systemctl start mongod >> /tmp/${COMPONENT}.log
stat $?

echo -n "COnfiguring ${COMPONENT} file"
sed -i -e 's/127.0.0.1/0.0.0.0' etc/mongod.conf
stat $?

echo -n "restarting $COMPONENT Service"
systemctl restart mongod >> /tmp/${COMPONENT}.log
stat $?