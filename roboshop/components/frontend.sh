#!/bin/bash
set -e #it ensure that script will stop if any instruction fails
## source is the command to import the file
source components/common.sh

echo "Installing Nginx"
yum install nginx -y >> /tmp/frontend.log
if [ $? -eq 0 ] ; then
    echo -e "\e[32m Success \e[0m "
systemctl enable nginx

echo "Starting the Nginx"
systemctl start nginx

curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
cd /usr/share/nginx/html
rm -rf *
unzip /tmp/frontend.zip  >> /tmp/frontend.log
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.mdk
mv localhost.conf /etc/nginx/default.d/roboshop.conf
