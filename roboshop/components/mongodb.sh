#!bin/bash
set -e #ensure script will stop if any instruction fails

source components/common.sh

component=mongodb
echo -n "configuring ${component} repository"

curl -s -o /etc/yum.repos.d/${component}.repo https://raw.githubusercontent.com/stans-robot-project/${component}/main/mongo.repo

echo -n "installing ${component} Service"
yum install -y ${component}-org
stat $?

echo -n "Updating the $COMPONENT Config:"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf 
stat $? 

systemctl enable mongod >> /tmp/${component}.log
echo -n "starting ${component} Service"
systemctl start mongod
stat $?
