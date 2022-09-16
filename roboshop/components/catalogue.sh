#!/bin/bash

set -e 

source components/common.sh

COMPONENT=catalogue

echo -n "Configure Yum Remos for nodejs:"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash >> /tmp/${COMPONENT}.log 
stat $?

echo -n "Installing nodejs:"
yum install nodejs -y >> /tmp/${COMPONENT}.log 
stat $?

echo -n "Adding $FUSER user:"
id ${FUSER} &>> LOGFILE || useradd ${FUSER}   # Creates users only in case if the user account doen's exist
stat $? 

echo -n "Downloading $COMPONENT"
curl -s -L -o /tmp/catalogue.zip "https://github.com/stans-robot-project/catalogue/archive/main.zip"
stat $?