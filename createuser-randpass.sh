#!/bin/bash

#This script creats a new user by accepting input from user

#Accpet user name from user
read -p "Enter user name to create: " USER_NAME

if [[ "${UID}" -ne 0 ]]
then
    echo "Script must be executed as a root use. Exiting now"
    exit 1
fi

#Accept real name of the user
read -p "Enter your real name: " REAL_NAME

#Generate random password using date, sha256sum commands and limits output to 10 characters using head
#PASSWORD=`date +%s%N | sha256sum | head -c10`
PASSWORD=$(date +%s%N | sha256sum | head -c10)

#Using more stronger password using RANDOM variable and adding a random special charater in int using shuf and fold commands


#Create the user
useradd -c "${REAL_NAME}" -M "${USER_NAME}"

if [[ "${?}" -ne 0 ]]
then
	echo "User creation failed. Exiting now"
	exit 1
fi

#Set password for user
#echo the password and pipe to passwd command so that password would be supplied to passwd command like standard input (stdin)
#echo ${PASSWORD} | passwd --stdin ${USER_NAME}  
echo -e "$PASSWORD\n$PASSWORD" |passwd "$USER_NAME"

if [[ "${?}" -ne 0 ]]
then
	echo "Could not set password for the user. Exiting now"
	exit 1
fi

#Set auto expiry for the password so that user will have to change it on his first login
passwd -e $USER_NAME

echo "User created. Below are the details:"
echo "Username: $USER_NAME"
echo "PASSWORD: $PASSWORD"
echo "HOST: $HOSTNAME"