# bash-scripting notes for my reference
### Declare variable. Remember, no spaces in between variable name, value and assignment operator
```bash
WORD='Test Word'
```

### To use embed variable in a string, use $ symbol before variable name
```bash
echo "Name of the current user is $USER_NAME"
```

### Store output of a command in a variable. Note its not a single quote charater, but the charater on the tilt button
```bash
VARIABLE=`command`
Example:
USER_NAME=`id -un`
```
Another syntax to achieve same result
```bash
VARIABLE=$(command)
Example:
USER_NAME=$(id -un)
```

### Sample if the else. Remember to add spaces betwen after [[ and before ]]
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

### To execute the last command run by specifying first letter for the command
```bash
Syntax:
!<letter>
Example: Lets say last command we executed was: vi test.sh. We later executed some other commands. Now we want to execute the last command that starts with letter v, then use below command  
!v
```

### To generate a random number, you can use the built in RANDOM variable
```bash
echo $RANDOM
```

### Check programs on the system which can generate different kinf of checksums
```bash
ls -l /usr/bin/*sum
```
### Generate sha256 checksum of date in seconds (can be useful in generating random passwords)
```bash
date +%s | sha256sum
```
Note that we can use any other crypto method and any other random number, or nano seconds from date to generate strong passwords

### Print lines from any file using head command. Here we are prining 1st line from the file. Please refer to man page to view other options for head command
```bash
head -n1 /etc/passwd

We can use alternatives to above commands:

head -n 1 /etc/passwd
OR
head -1 /etc/passwd
```

### Print first 4 characters from any file using head command. 
```bash
head -c4 /etc/passwd
```

### We can also use head command in congestion with other coommands, lets say echo, to limit the outout by specifying number of characers. Example:
```bash
echo "testing" | head -c4
```

## Shuffle input lines/lines from file randomly using SHUF (shuffle) command
```bash
shuf <filename>
```

## List each charter from text into seperate line using FOLD command
```bash
echo "Testing" | fold -w1
```