#!/bin/bash

a=10
b=Hello
#Date_command=${date+ %F}
echo today's date is ${date+ %F}
echo value of a is :$a
echo ${a}
echo "${b}"
echo value of d is :$d

## if we don't declare the value, then by default it takes as Null value
### example "rm -rf Test/temp" it removes the temp
## rm -rf Test/${Dir} if we don't declare the DIr variable then it consider as Null and will remove the Test Directory
# Local variables have more priority than environment variables
# No datatypes in Bashscripting, everyting is a String by default.
## Echo is the cmd to print in bash
## Bash= Bourne Again shell


## All the scripts will be running on Heap Memory. If we are not sure of the value, we can pass through export while running(export d=10) and this value will be removed once machine got poweredoff/shutdown.



