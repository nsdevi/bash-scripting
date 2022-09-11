#!bin/bash
set -e #ensure script will stop if any instruction fails

source components/common.sh

component=mongodb
echo -n "configuring ${component} repository"

curl -s -o /etc/yum.repos.d/${component}.repo https://raw.githubusercontent.com/stans-robot-project/${component}/main/mongo.repo

echo -n "installing ${component} Service"
yum install -y ${component}-org >> /tmp/${component}.log
stat $?

echo -n "Updating the $COMPONENT Config:"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf 
stat $? 

systemctl enable mongod >> /tmp/${component}.log
echo -n "starting ${component} Service"
systemctl start mongod
stat $?

echo -n "downloading the schema"
curl -s -L -o /tmp/${component}.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
stat $?

echo -n "extracting the zip file"
cd /tmp && unzip ${component}.zip
stat $?

echo -n "injecting the schema"
cd ${component}-main
mongo < catalogue.js >> /tmp/${component}.log
mongo < users.js >> /tmp/${component}.log
stat $?

echo -n "\n-------------${component} configuration completed------------------\n"