ID=$(id - u)
if [ $ID -ne 0 ]; then
echo -e "/e[31m Try to execute with sudo/root access /e[0m"\
fi