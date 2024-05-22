#!/bin/bash

ID=$(id -u)
if [$ID -ne 0 ] ; then
echo "Try to execute with Root user or Sudo"
exit 1
fi

echo "Installing Nginx"
yum install nginx -y
systemctl enable nginx
systemctl start nginx
