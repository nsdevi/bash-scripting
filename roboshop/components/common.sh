# validating whether the executing user is root or not
ID=$(id -u)
if [ $ID -ne 0 ]; then
    echo -e "\e[31m Execute the script with the Sudo or root user \e[0m"
    exit 1
fi

#Declaring the stat function

stat() {
    if [ $1 -eq 0 ]; then
        echo -e "\e[32m Success \e[0m"
    else
        echo -e "\e[31m failed, please check the logs \e[0m"
    fi
}

User_setup() {
    echo -n "Adding $FUSER user:"
    id ${FUSER} &>> LOGFILE  || useradd ${FUSER}   # Creates users only in case if the user account doen's exist
    stat $? 
}