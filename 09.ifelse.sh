#!/bin/bash

#Demo on IF
# a=$1
# if [ $a -ge 18 ] ; then
#     echo "You are ${a} years old, eligible to cast a vote"
# else
#     echo "You are not eligible to cast a vote"
# fi


# action=$2
# if [ "$action" = "start" ] ; then
#     echo Selected option is start
# else
#     echo Invalid Option
# fi



#Demo of ifelse
action=$1
if [ $action = start ] ; then
    echo "Starting the service"
elif [ $action = stop ] ; then
    echo "stop the service"
elif [ $action = restart ]; then
    echo "Restarting the service"
else   
    echo -e "\e[31m Invalid Option \e[0m"
fi
