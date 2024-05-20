#!/bin/bash

read -p "Enter your name:" Name
echo Entered name is $Name

echo Hi
<<COMMENT
echo Hello
echo Hi
COMMENT
