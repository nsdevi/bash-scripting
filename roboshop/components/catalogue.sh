#!/bin/bash

set -e 

source components/common.sh

COMPONENT=catalogue\
FUSER=roboshop 
LOGFILE=/tmp/robot.log 

echo -n "Configure Yum Remos for nodejs:"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash >> /tmp/${COMPONENT}.log 
stat $?

echo -n "Installing nodejs:"
yum install nodejs -y >> /tmp/${COMPONENT}.log 
stat $?

echo -n "Adding $FUSER user:"
id ${FUSER} &>> LOGFILE || useradd ${FUSER}   # Creates users only in case if the user account doen's exist
stat $? 

echo -n "Downloading ${COMPONENT} :"
    curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip" >> /tmp/${COMPONENT}.log 
    stat $? 

    echo -n "Cleanup of Old ${COMPONENT} content:"
    rm -rf /home/${FUSER}/${COMPONENT}  >> /tmp/${COMPONENT}.log 
    stat $?

    echo -n "Extracting ${COMPONENT} content: "
    cd /home/${FUSER}/ >> /tmp/${COMPONENT}.log 
    unzip -o  /tmp/${COMPONENT}.zip  >> /tmp/${COMPONENT}.log   &&   mv ${COMPONENT}-main ${COMPONENT} >> /tmp/${COMPONENT}.log 
    stat $? 

    echo -n "Changing the ownership to ${FUSER}:"
    chown -R $FUSER:$FUSER $COMPONENT/
    stat $?

     echo -n "Installing $COMPONENT Dependencies:"
    cd $COMPONENT && npm install &>> /tmp/${COMPONENT}.log 
    stat $? 

    echo -n "Configuring the Systemd file: "
    sed -i -e 's/CARTHOST/cart.roboshop.internal/' -e 's/USERHOST/user.roboshop.internal/' -e 's/AMQPHOST/rabbitmq.roboshop.internal/' -e 's/CARTENDPOINT/cart.roboshop.internal/' -e 's/DBHOST/mysql.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/'  -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' /home/${FUSER}/${COMPONENT}/systemd.service 
    mv /home/${FUSER}/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
    stat $? 

    echo -n "Starting the service"
    systemctl daemon-reload  &>> /tmp/${COMPONENT}.log 
    systemctl enable ${COMPONENT} &>> /tmp/${COMPONENT}.log
    systemctl start ${COMPONENT} &>> /tmp/${COMPONENT}.log
    stat $?

     echo -e "\n ************ $Component Installation Completed ******************** \n"