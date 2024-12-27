# bash-scripting notes for my reference
### Declare variable. Remember, no spaces in between variable name, value and assignment operator
```bash
WORD='Test Word'
```

### To use embed variable in a string, use $ symbol before variable name
```bash
echo "Name of the current user is $USER_NAME"
```

### To get list of all executables from the path for a command
```bash
which -a <command>
Example:
which -a touch
```

### Strip full directory path and get only file name
```bash
basename <full path>
```
Note that basename performs string operations on the given full path. The file or path doesn't necessarily exist.


### Strip file name from full path and get directory name/path
```bash
dirname <full path>
```
Note that dirname performs string operations on the given full path. The file or path doesn't necessarily exist.


### Store output of a command in a variable. Note its not a single quote charater, but the charater on the tilt button. Using this character is old approach.
```bash
VARIABLE=`command`
Example:
USER_NAME=`id -un`
```
#### Another syntax to achieve same result. This is the new and recommended approach
```bash
VARIABLE=$(command)
Example:
USER_NAME=$(id -un)
```

### There are FILE operators that can be used to test file/directory related conditions
For example, 
```bash
[ -e /etc/passwd ]
```
This checks if the file `/etc/passwd` exists.

There are more such operators, listed below:

* -d FILE - TRUE if file is directory
* -e FILE - TRUE if file exists
* -f FILE - TRUE if file exists is a regular file (and not symlink)
* -r FILE - TRUE if the file is readable by you/user exectuting the script
* -s FILE - TRUE if file exists and is not empty
* -w FILE - TRUE if file is writable by you/user executing the script
* -x FILE - TRUE if file is executable by you/user executing the script 

### There are also STRING operators for test
* -z STRING - TRUE if string is empty
* -n STRING - TRUE if string is not empty
* STRING1=STRING1 - TRUE if strings are equal
* STRING1!=STRING2 - TRUE if strings are not equal

### Arithmatic operators for test
* arg1 -eq arg2 - TRUE if arg1 is equal to arg2
* arg1 -ne arg2 - TRUE if arg1 is not equal to arg2

* arg1 -lt arg2 - TRUE if arg1 is less than arg2
* arg1 -le arg2 - TRUE if arg1 is less than or equal to arg2

* arg1 -gt arg2 - TRUE if arg1 is greater than arg2
* arg1 -ge arg2 - TRUE if arg1 is greater than or equal to arg2


### Sample if the else. Remember to add spaces betwen after [[ and before ]]
Syntax is:
```bash
if [condition]
then
	command 1
	command 2
	command N
fi
```

```bash
if [[ "${UID}" -eq 0 ]]
then
	echo "You are a root  user"
else
	echo "You are not a root user"
fi
```

### If with multiple conditions
```bash
if [ condition 1 ]
then
  echo "condition 1"
elif [ condition 2]
then
  echo "condition 2"
else
  echo "no condition satisfied"
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

## Passing arguments from command line and acceting them in variable
```bash
VARIABLE1=${1}
VARIABLE2=${2}

Where the number inside the ${} represent the position of the argument passed, and number should start with 1 to accept arguments starting from 1st position.
${0} is not used, as it just contains the name of the script being executed. If the script is executed by providing from abosolute (full) path, then full path along with file script name is displayed.
```
### Get the number of arguments supplied to a script
```bash
NUMBER_OF_PARAMETERS=${#}
OR
NUMBER_OF_PARAMETERS=$#
```

There is a also a special variable "$@" which gets all the parameters passed. Below is the example:
```bash
#!/bin/bash

echo "Executing script: ${0}"

for USER in $@
do
  echo "Archiving User: ${USER}"

  # Lock user account
  passwd -l ${USER}

  # Create an archive of home directory
  tar cf /archives/${USER}.tar.gz /home/${USER}
done
```



### Shift command shifts the position of command line arguments.
Lets say you have supplied 4 argumens, and you run shift command with number 2, then you will get only parameter 3 and 4
```bash
Syntax: 
shift 2
```	

### For loop syntax
```bash
for VAR in Mark Andy on
do
	echo "Hi ${VAR}"
done
```
 
#### Simple script using for loop to rename files in a directory
```bash
#!/bin/bash

PICTURES=$(ls *jpg)
DATE=$(date +%F)

for PICTURE in $PICTURES
do
  echo "renaming ${PICTURE} to: ${DATE}-${PICTURE}"
  mv ${PICTURE} ${DATE}-${PICTURE}
done
```



### While loop syntax
```bash
while [[ condition ]]
do
	echo "We are inside while"
done
```


### ${@} or $@ stores all the user arguments provided to the script. This way we don't have to calculate the number of arugments provided and we can loop through each one of them. A sample for loop is given below:
```bash
for USER_NAME in ${@}
do
	PASSWORD=$(date +%s%N | sha256sum | head -c15)
	echo "${USER_NAME}:$PASSWORD"
done
```

### Locate command searches for a file in a database created by updatedb. This updatedb runs only once in a day so the locate command cannot fetch the latest results. To fetch latest results, run updatedb and then run locate
```bash
updatedb
locate file.txt
```

### We can use !! to directly execute the last command we ran on he terminal.

## To create an archieve, we can use tar command
```bash
tar -cvf archieve.tar <file/directory-to-be-archieved>
```
Here, -c stands for create, -v stands for verbose, -f stands for file.  
-v prints the list of files being added to the archieve. We can exclude this option if we don't want the list to be printed.
We can also specify -z option to filter the archieve through gzip. We can then sepcify the archieve extension as tar.gz or tgz

### To view the contents of the tar file
```bash
tar -tf archieve.tar
```
Here, -t stands for list, -f stands for file

### To extract an archieve
```bash
tar -xvf archieve.tar
```
Here, -z stands for gzip dcomprssion, -x stands for extract, -v stands for verbose, -f stands for file
-v prints the list of files being extracted from the archieve. We can exclude this option if we don't want the list to be printed.
We can also specify -z parameter to decompress tar.gz or tgz files.


### we can use gzip command to compress the tar files
```bash
gzip <name oftar file>
```
But as listed above, instead of speperately using gzip, we can just specify -z parameter to tar to create compress the archieve during creation.


### to uncompress a gzip archieve
```bash
gunzip <tar.gz file>
```

### !$ shows the very last argument of the last command executed
```bash
echo "hello" > directory/file.txt
cat !$
```
In above example, cat !$ will print the contents of directory/file.txt. The command just used the arugments supplied to echo command and did a cat command over it