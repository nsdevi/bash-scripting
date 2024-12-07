#!/bin/bash
source components/common.sh
echo "I'm installing frontend"
dnf module disable nginx -y
dnf module enable nginx:1.24 -y
dnf install nginx -y