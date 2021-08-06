#!/bin/bash

#This script creats a new user by accepting input from user

#Accpet user name from user
read -p "Enter user name to create: " USER_NAME

#Accept real name of the user
read -p "Enter your real name: " REAL_NAME

#Accept password for the user
read -p "Enter your password: " PASSWORD

#Create the user
useradd -c "${REAL_NAME}" -M "${USER_NAME}"

#Set password for user
#echo the password and pipe to passwd command so that password would be supplied to passwd command like standard input (stdin)
#echo ${PASSWORD} | passwd --stdin ${USER_NAME}  
echo -e "$PASSWORD\n$PASSWORD" |passwd "$USER_NAME"

#Set auto expiry for the password so that user will have to change it on his first login
passwd -e $USER_NAME

