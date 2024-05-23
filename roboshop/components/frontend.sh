#!/bin/bash

ID=$(id -u)
if [ $ID -ne 0 ] ; then
    echo "Try to execute with sudo or root user"
    exit 10
fi

echo "Installing Nginx"
yum install nginx -y
systemctl enable nginx
systemctl start nginx

curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"