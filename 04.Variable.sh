#!/bin/bash

a=10
b=Hello

Date_command=$(date +%F)
Loggedin_users=$(who | wc -l)

echo "today's date is ${Date_command}"
echo $(date +%F)
echo No . of users loogged in are: ${Loggedin_users}
echo value of a is : $a
echo ${a}
echo "${b}"




