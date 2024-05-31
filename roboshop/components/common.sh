## VAlidating whether the executing user is root or not
ID=$(id -u)
if [ $ID -ne 0 ] ; then
    echo -e "\e[31m Try to execute with sudo or root user \e[0m"
    exit 1
fi


##Declaring the function
stat() {
    if [ $1 -eq 0 ] ; then
    echo -e "\e[32m Success \e[0m "
else
    echo -e "\e[31m Failure \e[0m "
fi
}

FUSER=roboshop
LOGFILE=/tmp/robot.log

USER_SETUP() {
echo -n "$FUSER User Creation"
id ${FUSER} &>> LOGFILE || useradd ${FUSER} # it creates the user only if user doesn;t exist
stat $?
}

DOWNLOAD_AND_EXTRACT() {
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
}

CONFIG_SVC() {
echo -n "COnfiguring systemd file"
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' /home/${FUSER}/${COMPONENT}/systemd.service
mv /home/${FUSER}/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
stat $?

echo -n "Starting the service"
systemctl daemon-reload &>> /tmp/$COMPONENT.log
systemctl enable ${COMPONENT} &>> /tmp/$COMPONENT.log
systemctl start ${COMPONENT} &>> /tmp/$COMPONENT.log
}

NODEJS() {
echo -n "Downloading yum repos for Nodejs"
yum install https://rpm.nodesource.com/pub_16.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y >> /tmp/$COMPONENT.log
stat $?

echo -n "Installing NodeJS"
yum install nodejs -y >> /tmp/$COMPONENT.log
stat $?

# calling user creation function
USER_SETUP

# calling download and extracting function
DOWNLOAD_AND_EXTRACT

echo -n "Installing $COMPONENT dependecies"
cd $COMPONENT
npm install &>> /tmp/$COMPONENT.log
stat $?

# calling CONFIG_SVC funcion
CONFIG_SVC
}
