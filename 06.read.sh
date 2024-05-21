#!/bin/bash

read -p "Enter your name:" Name
echo Entered name is $Name

echo Hi
<<COMMENT
echo It's Multiline comment (Text between "<<COMMENT ---- COMMENT" will consider as comment)
echo Hello
echo Hi
COMMENT
