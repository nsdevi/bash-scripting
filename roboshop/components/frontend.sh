#!/bin/bash
## source is the command to import the file
source components/common.sh

echo "Installing Nginx"
yum install nginx -y
systemctl enable nginx
systemctl start nginx

curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
cd /usr/share/nginx/html
rm -rf *
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.mdk
mv localhost.conf /etc/nginx/default.d/roboshop.conf
