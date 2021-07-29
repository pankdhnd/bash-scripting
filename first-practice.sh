#!/bin/bash

##no spaces in between while declaring variable
WORD='Test Word'

#echo "$WORD"
#echo '$WORD'

#echo "This is a $WORD"

#echo "This is a ${WORD}"

#echo "concatenate string with variables ${WORD}ing"

##store output of a command (id -un)  to a variable
#USER_NAME=$(id -un)

##another way to store output of a command to a variable
USER_NAME=`id -un`

echo "Name of the current user is $USER_NAME"

if [[ "${UID}" -eq 0 ]]
then
	echo "$USER_NAME is not a root user"
else
	echo "$USER_NAME is a root user"
fi

REFERENCE_UID="2000"

if [[ "${UID}" -ne "${REFERENCE_UID}" ]]
then
       echo "Your UID does not matches $REFERENCE_UID"
       #exit 1
fi      

#Get exit staus of recently executed command. Bash stores this status in a special variable and can be acceesed by ${?}
USER_NAME=$(id -un)


if [[ "${?}" -ne 0 ]]
then
	echo "id command did not execute successfuly"
	exit 1
fi

#String comparison in if statemnet
REFERENCE_USERNAME="pankaj"

#instead of -eq, a single equal to sign i.e. "=" can also be used. Single sign for equal to check, double == for pattern check, but some people use double for equal check as well
if [[ "${USER_NAME}" != "${REFERENCE_USERNAME}" ]]
then
	echo "Username does not match with the reference username"
fi


#Display what you typed on the command line
echo "You typed: ${0}"


#Display the path and the filename of the script. Run script will full path to view correctly
#This style of writing is called as command substitution where we directly use commands at place instead of first storing their output in variable, and then using those variables  
echo "Directory path is: $(dirname ${0}) and filename is $(basename ${0})"

#Display number of arguments provided to the script. This is useful is determining if user has provided sufficient number of arguments to script.
#We can use an if condition here
NUMBER_OF_PARAMETERS=${#}  #OR use $#
echo "Number of arguments: $NUMBER_OF_PARAMETERS"

: '
if [[ NUMBER_OF_PARAMETERS -lt 1 ]]
then
	echo "Insufficient parameters. Usage: $(basename ${0}) PARAMETER"
fi
'

for X in Mark, Andy, Ron
do
	echo "Hi ${X}"
done

for USER_NAME in ${@}
do
	PASSWORD=$(date +%s%N | sha256sum | head -c15)
	echo "${USER_NAME}:$PASSWORD"
done









#specify exit code fo the script
exit 0

