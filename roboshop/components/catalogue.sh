#!bin/bash
set -e #ensure script will stop if any instruction fails

source components/common.sh

component=catalogue
FUSER=roboshop

echo -n "configuring repos"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash >> /tmp/${component}.log
stat $?

echo -n "installing nodejs"
yum install nodejs -y >> /tmp/${component}.log
stat $?

echo "creating roboshop user"
id $FUSER || useradd $FUSER 
stat $?

echo -n "Downloading component"
curl -s -L -o /tmp/${component}.zip "https://github.com/stans-robot-project/${component}/archive/main.zip" >> /tmp/${component}.log
stat $?

echo -n "extracting component"
cd /home/${FUSER}
unzip /tmp/${component}.zip
mv ${component}-main ${component}
cd /home/$FUSER/${component}
stat $?

echo -n "installing dependencies"
npm install
stat $?