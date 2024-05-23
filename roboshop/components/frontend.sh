#!/bin/bash
set -e #it ensure that script will stop if any instruction fails
## source is the command to import the file
source components/common.sh

echo -n "Installing Nginx:"
yum install nginx -y >> /tmp/frontend.log
stat $?

systemctl enable nginx
echo -n "Starting the Nginx:"
systemctl start nginx
stat $?


echo -n "Downloading the code:"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
stat $?

cd /usr/share/nginx/html
rm -rf *
unzip /tmp/frontend.zip  >> /tmp/frontend.log
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.mdk
mv localhost.conf /etc/nginx/default.d/roboshop.conf

echo -n "restarting the Nginx:"
systemctl restart nginx
stat $?

