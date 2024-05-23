#!/bin/bash
set -e #it ensure that script will stop if any instruction fails
## source is the command to import the file
source components/common.sh

echo -n "Installing Nginx:"
yum install nginx -y >> /tmp/frontend.log
if [ $? -eq 0 ] ; then
    echo -e "\e[32m Success \e[0m "
else
    echo -e "\e[31m Failure \e[0m "
fi

systemctl enable nginx
echo -n "Starting the Nginx:"
systemctl start nginx
if [ $? -eq 0 ] ; then
    echo -e "\e[32m Success \e[0m "
else
    echo -e "\e[31m Failure \e[0m "
fi

echo -n "Downloading the code:"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
if [ $? -eq 0 ] ; then
    echo -e "\e[32m Success \e[0m "
else
    echo -e "\e[31m Failure \e[0m "
fi

cd /usr/share/nginx/html
rm -rf *
unzip /tmp/frontend.zip  >> /tmp/frontend.log
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.mdk
mv localhost.conf /etc/nginx/default.d/roboshop.conf