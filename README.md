# bash-scripting


## Below are the mostly used Git commands:

1. git clone reponame : downloads the whole repository
2. git pull           : download only the changes
3. git add filename   : Git will start tracking that you are making on the file named filename
4. git commit -m "msg name" : Adding msg to the commit/changes that you made
5. git push           : Your changes will be pushed to the repo


if we don't declare the value, then by default it takes as Null value
example "rm -rf Test/temp" it removes the temp
rm -rf Test/${Dir} if we don't declare the Dir variable then it consider as Null and will remove the Test Directory
Local variables have more priority than environment variables
No datatypes in Bashscripting, everyting is a String by default.
Echo is the cmd to print
Bash= Bourne Again shell
All the scripts will be running on Heap Memory. If we are not sure of the value, we can pass through export while running the script(export variable name=value ; ex: a=10) and this value will be erased once machine got poweredoff/shutdown.


