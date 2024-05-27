#!/bin/bash
set -e 
source components/common.sh
COMPONENT=mongodb
echo -n "downloading ${COMPONENT} repo"
curl -s -o /etc/yum.repos.d/${COMPONENT}.repo https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/mongo.repo
stat $?

echo -n "Installing $COMPONENT Service"
yum install -y ${COMPONENT}-org >> /tmp/${COMPONENT}.log
stat $?

echo -n "Starting $COMPONENT Service"
systemctl enable mongod >> /tmp/${COMPONENT}.log
systemctl start mongod >> /tmp/${COMPONENT}.log
stat $?

echo -n "Configuring ${COMPONENT} file"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf # it replaces 127.0.0.1 with 0.0.0.0 in /etc/mongof.conf file
stat $?

echo -n "restarting $COMPONENT Service"
systemctl restart mongod >> /tmp/${COMPONENT}.log
stat $?

echo -n "Downloading the $COMPONENT schema"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
stat $?

echo -n "Extracting the $COMPONENT schema"
cd /tmp && unzip -o ${COMPONENT}.zip ## "-o indicates it overrides the file"
stat $?

echo -n "Injecting the $COMPONENT schema"
cd $COMPONENT-main
mongo < catalogue.js >> /tmp/${COMPONENT}.log
mongo < users.js >> /tmp/${COMPONENT}.log
stat $?
