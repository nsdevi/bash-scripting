#!/bin/bash
set -e
source components/common.sh
COMPONENT=catalogue
FUSER=roboshop
ID=(id $FUSER)

echo -n "Downloading yum repos for Nodejs"
yum install https://rpm.nodesource.com/pub_16.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y >> /tmp/$COMPONENT.log
stat $?

echo -n "Installing NodeJS"
yum install nodejs -y >> /tmp/$COMPONENT.log
stat $?

echo -n "$FUSER User Creation"
id ${FUSER} || useradd ${FUSER} # it creates the user only if user doesn;t exist
stat $?


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

echo -n "Changing the ownership to $FUSER"
chown -R $FUSER:$FUSER $COMPONENT/
stat $?

echo -n "Installing $COMPONENT dependecies"
cd $COMPONENT
npm install &>> /tmp/$COMPONENT.log
stat $?

echo -n "COnfiguring systemd file"
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' /home/${FUSER}/${COMPONENT}/systemd.service
mv /home/${FUSER}/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
stat $?

echo -n "Starting the service"
systemctl daemon-reload &>> /tmp/$COMPONENT.log
systemctl enable ${COMPONENT} &>> /tmp/$COMPONENT.log
systemctl start ${COMPONENT} &>> /tmp/$COMPONENT.log
