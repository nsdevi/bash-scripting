#!/bin/bash
set -e
source components/catalogue.sh
COMPONENT=catalogue
FUSER=roboshop

echo -n "Downloading yum repos for Nodejs"
curl -sL https://rpm.nodesource.com/setup_16.x | bash
stat $?

echo -n "Installing NodeJS"
yum install nodejs -y
stat $?

echo -n "$FUSER User Creation"
useradd ${FUSER}
stat $?

echo -n "Downloading $COMPONENT"
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
stat $?

echo -n "Cleaning up old $COMPONENT files"
rm -rf /home/${FUSER}/${COMPONENT}
stat $?

echo -n "Extracting the $COMPONENT schema"
cd /home/${FUSER}
unzip -o /tmp/${COMPONENT}.zip ## "-o indicates it overrides the file"
mv ${COMPONENT}-main ${COMPONENT}
stat $?

echo -n "Installing $COMPONENT dependecies"
npm install
stat $?


