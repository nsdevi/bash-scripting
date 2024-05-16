#!/bin/bash

## Defining the Function

stat()
{
echo Load average of the system from last 1 min is: $(uptime | awk -F : '{print $5}' | awk -F , '{print$1}')
echo No.of Users logged in are: $(who | wc -l)
}

##Calling the function
stat