#!/bin/bash
set -e
source components/catalogue.sh
COMPONENT=catalogue
FUSER=roboshop

echo -n "Downloading yum repos for Nodejs"
yum install https://rpm.nodesource.com/pub_16.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y
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

echo -n "Extracting the $COMPONENT schema"
cd /home/roboshop && unzip -o /tmp/${COMPONENT}.zip ## "-o indicates it overrides the file"
stat $?


