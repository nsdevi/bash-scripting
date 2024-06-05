#!/bin/bash

source components/common.sh
set -e
COMPONENT=shipping

echo -n "Installing Maven"
dnf install maven -y
stat $?

#Calling User creation function
USER_SETUP

#Calling downloading and extracting
DOWNLOAD_AND_EXTRACT

echo -n "Configuring artifacts"
cd /home/${FUSER}/${COMPONENT}
mvn clean package
mv target/shipping-1.0.jar shipping.jar
stat $?

CONFIG_SVC
