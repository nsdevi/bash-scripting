#!/bin/bash
set -e
source components/common.sh
COMPONENT=catalogue
FUSER=roboshop

echo -n "Downloading yum repos for Nodejs"
yum install https://rpm.nodesource.com/pub_16.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y >> /tmp/$COMPONENT.log
stat $?

echo -n "Installing NodeJS"
yum install nodejs -y >> /tmp/$COMPONENT.log
stat $?

# echo -n "$FUSER User Creation"
# id ${FUSER} useradd ${FUSER}
# stat $?
if [ id ${FUSER} -ne 0 ] ; then
useradd ${FUSER}

echo -n "Downloading $COMPONENT"
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip" >> /tmp/$COMPONENT.log
stat $?

echo -n "Cleaning up old $COMPONENT files"
rm -rf /home/${FUSER}/${COMPONENT} >> /tmp/$COMPONENT.log
stat $?

echo -n "Extracting the $COMPONENT schema"
cd /home/${FUSER}
unzip -o /tmp/${COMPONENT}.zip >> /tmp/$COMPONENT.log ## "-o indicates it overrides the file"
mv ${COMPONENT}-main ${COMPONENT}
stat $?

echo -n "Installing $COMPONENT dependecies"
npm install >> /tmp/$COMPONENT.log
stat $?
