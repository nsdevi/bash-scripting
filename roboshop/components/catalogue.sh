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

echo -n "Cleanup of Old ${COMPONENT} content:"
rm -rf /home/${FUSER}/${COMPONENT}  >> /tmp/${COMPONENT}.log 
stat $?

echo -n "extracting component"
cd /home/${FUSER}/ >>/tmp/${component}.zip
stat $?
unzip -o /tmp/${component}.zip
stat $?
mv ${component}-main ${component}
stat $?
echo -n "Changing the ownership to ${FUSER}:"
chown -R $FUSER:$FUSER $COMPONENT/
stat $?

echo -n "installing dependencies"
cd $COMPONENT && npm install &>> /tmp/${COMPONENT}.log 
stat $? 
npm install
stat $?

