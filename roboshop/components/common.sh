## VAlidating whether the executing user is root or not
ID=$(id -u)
if [ $ID -ne 0 ] ; then
    echo -e "\e[31m Try to execute with sudo or root user \e[0m"
    exit 1
fi


##Declaring the function
stat() {
    if [ $1 -eq 0 ] ; then
    echo -e "\e[32m Success \e[0m "
else
    echo -e "\e[31m Failure \e[0m "
fi
}
