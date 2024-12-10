#!/bin/bash
set -e #it ensure that script will stop if any instruction fails

## source is the command to import the file
source components/common.sh
# echo -n "modification in yum.repos.d file"
# sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
# sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
# stat $?

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
echo -n "Extracting the Zip file"
unzip /tmp/frontend.zip  >> /tmp/frontend.log
stat $?

mv frontend-main/* .
mv static/* .
echo -n "Performing Cleanup"
rm -rf frontend-main README.mdk
stat $?

echo -n "Configuring reverse Proxy"
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?

for component in catalogue user cart shipping ; do
echo -n "updating the proxy file"
sed -i -e "/$component/s/localhost/$component.roboshop.internal/" /etc/nginx/default.d/roboshop.conf
stat $?
done

echo -n "restarting the Nginx:"
systemctl restart nginx
stat $?

