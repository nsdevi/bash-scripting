ID=$(id -u)
if [ $ID -ne 0 ]; then
    echo -e "\e[31m Execute the script with the Sudo or rrot user"
    exit 1
fi