#!/bin/bash

# case $Var in
#     cond1)
#       command 1
#       ;;
#     cond2)
#         command 2   
#         ;;
#     cond3)
#         command 3
#         ;;
#     *)
#         command ;;;
# esac
action=$1
case $action in
    start)
        echo starting the service
        ;;
    stop)
        echo stopping the service
        ;;
    restart)
        echo restarting the service
        ;;
    *)
        echo -e "\e[36m Invalid Option \e[0m]"
        ;;

esac