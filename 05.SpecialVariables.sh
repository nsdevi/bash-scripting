#!/bin/bash

# #  $0 --- It gives the name of the script you're running
# #  $1 to $9---- you can pass maximum of 9 variables from the cmd line when running the script
# #  $@
# #  $*
# #  $#
# #  $$
echo "The script you're running is $0"

a=10
b=$1 # $1 first argument passed to the script
C=$2 # $2 second argument passed to the script
echo The Value of a is :$a
echo The value of b is :$b
echo The value of C is :$C

echo $?
echo $$
echo $@
echo $*

