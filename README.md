# bash-scripting notes for my reference
### Declare variable. Remember, no spaces in between variable name, value and assignment operator
```bash
WORD='Test Word'
```

### To use embed variable in a string, use $ symbol before variable name
```bash
echo "Name of the current user is $USER_NAME"
```

### Store output of a command in a variable
```bash
VARIABLE=`command`
Example:
USER_NAME=`id -un`
```

### Sample if the else. Rememberm to add spaces betwen after [[ and before ]]
```bash
if [[ "${UID}" -eq 0 ]]
then
	echo "$USER_NAME is not a root user"
else
	echo "$USER_NAME is a root user"
fi
```
### To view help for expressions used in if statement
```bash
help test
```

### Comparison operators that can be used in if
```
-eq = equal  
-ne = not equal  
-lt = less than  
-le = less than or equal  
-gt = greather than  
-ge = greather than or equal  
```


### Get exit staus of recently executed command. Bash stores this status in a special variable and can be acceesed by ${?}
```bash
if [[ "${?}" -ne 0 ]]
then
	echo "command did not execute successfuly"
	exit 1
fi
```

### To accept input from user during execution
```bash
read -p "Message prompt" VARIABLE
Example:
read -p "Enter user name to create: " USER_NAME
```