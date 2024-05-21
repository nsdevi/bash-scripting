#!/bin/bash

ID=$(id -u)
if [ $ID -eq 0 ]; then
    echo Installing HTTPD
    yum install httpd
else
    echo "Try to excute with the root uset or Sudo"
fi
