#!/bin/bash

a=$1
if [ $a -ge 18 ] ; then
    echo "You are ${a} years old, eligible to cast a vote"
else
    echo "You are not eligible to cast a vote"
fi


action=$2
if [ "$action" = "start" ] ; then
    echo Selected option is start
else
    echo Invalid Option
fi