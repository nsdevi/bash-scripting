#!/bin/bash

ID=$(id -u) ###User id of the root user is always 0
if [ $ID -eq 0 ]; then
    echo Installing HTTPD
    yum install httpd
else
    echo "Try to excute with the root user or Sudo"
fi
