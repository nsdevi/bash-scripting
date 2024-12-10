ID=$(id -u)
if [ $ID -ne 0 ] ; then
    echo -e "\e[31m Try to execute with sudo/root access \e[0m"
    exit 1
fi

stat() {
    if [ $1 -eq 0 ]; then
    echo -e "\e[32m Success \e[0m"
    else
    echo -e "\e[31m Failed, check for the logs \e[0m"
fi
}

