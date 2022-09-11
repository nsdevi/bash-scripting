#!bin/bash
set -e #ensure script will stop if any instruction fails

source components/common.sh

echo -n "installing nginx"
yum install nginx -y
stat $?

systemctl enable nginx

echo -n "starting nginx"
systemctl start nginx
stat $?

echo -n "downloading code"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
stat $?

cd /usr/share/nginx/html
rm -rf *
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf

systemctl restart nginx