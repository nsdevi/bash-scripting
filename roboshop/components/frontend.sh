#!bin/bash
set -e #ensure script will stop if any instruction fails

source components/common.sh

echo -n "installing nginx"
yum install nginx -y  >> /tmp/frontend.log
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

echo "extracting zip file and save the file in /tmp/frontend.log:"
unzip -o /tmp/frontend.zip >> /tmp/frontend.log
mv frontend-main/* .
mv static/* .

echo "perforning cleanup"
rm -rf frontend-main README.md

echo "configuring the reverse proxy"
mv localhost.conf /etc/nginx/default.d/roboshop.conf

for component in catalogue; do 
    echo -n "Updating the proxy file"
    sed -i -e "/${component}/s/localhost/${component}.roboshop.internal/"  /etc/nginx/default.d/roboshop.conf
    stat $?
done

echo -n "restarting the nginx"
systemctl restart nginx
stat $?