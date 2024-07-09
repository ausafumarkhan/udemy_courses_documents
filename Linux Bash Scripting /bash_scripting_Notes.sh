 SHELL Scripting

Change shell to bash 

	$ chsh -s /bin/bash 	# To get new shell we need to logout and login again, Only superuser can change shell for any user. A user can change own shell only.

What is shell??
	A shell is:
		"Program that interprets the command you type in your terminal and passes them on to the operating system"

What is BASH?
	Bourne Again shell create by stephen Bourne in 1979.
Why BASH?
	Its feature-rich
	Its fast
	Its very common

What is script?
	A shell script is a file containing commands for the shell.

Why use a script?
	Script allows automation 

Exit Code: https://tldp.org/LDP/abs/html/exitcodes.html


Shell script starts with Shebang character which tells about the interpreter.
For example: "#!/bin/bash" OR "#!/usr/bin/python3"  

To create a shell script
	$ nano our_first_script

Check the type of file 
	$ file our_first_script

All bash script has three components
	1. The shebang character
	2. Commands
	3. Exit statements (0=succesful, 1-255=unsuccessful) 
	Remember to give executable permission to your bash script.


Professional components --  To add at the staritng of a script.

	$ nano our_first_script		-- Add the following lines to write a Professional bash script 

1.#!/bin/bash 					-- This is shebang character for a bash as interpreter

2.# Author: "Ausaf Umar Khan"
3.# Date Created : 02-03-2024
4.# Last Modified : 20-03-2024

5.# Description :
6.# Prints "This is my first script" to the terminal

7.# Usage
8.# our_first_script

9. echo "This is my first script"
10. exit 0

Secure Script Permission
	"Chmod calculator" is available at https://chmod-calculator.com/

	- Read and interpret file permission
	- Use chmod to change file permission
	- The recommended file permissions for scripts (744)
	
	$ pwd
	/home/vagrant/bash_course/script

	$ vi backup_script

	#!/bin/bash

	# Author: "Ausaf Umar Khan"
	# Date Created : 2024-03-26
	# Last Modified : 2024-03-26

	# Description :
	# It will create a backup of a home directory with date and time using tar command  

	# Usage
	# ./backup_script 

	echo "**********************************"
	echo "********Creating a backup*********"

	sudo tar -cf ~/bash_course/my_backup_"$(date +%d-%m-%Y_%H-%M-%S)".tar ~/* 3>/dev/null

	echo "*********************************"
	echo "*********End of script***********"

	exit 0

	$ vi ~/.profile

	export PATH=$PATH:$HOME//home/vagrant/bash_course/script

	$ source ~/.profile

	Now we can execute our scripts from anywhere if a script file is in /home/vagrant/bash_course/script. We can make entry of a path in ~/.bashrc as 

		export PATH=$PATH:$HOME/home/vagrant/bash_course/script
		OR
		PATH=$PATH:$HOME/home/vagrant/bash_course/script

		and use source to activate a path without terminating a terminal.

Summary:
	- Explain the difference between the shell and a script
	- Identify the 3 core components of a bash script
	- Use in-line commenting and the 5 professional components to your script.
	- Set secure permission
	- Add script to your path


User-defined variable and parameter expansion
	1. A parameter is an entity that can store values.
		- variables (most common)
		- positional parameters
		- special parameters

	2. Creating a variable: name=value (no space around = sign!)
	3. Retrieving a value: ${parameter}

Shell variable

	The PATH variable contains the list of folders that shell will search for executable files to run as a command names.
	$ echo $PATH

	The HOME variable is used to store the absolute path to the current users home directory.
	$ echo $HOME

	The USER variable contains the username of the current user.
	$ echo $USER

	The HOME and USER variables tell you about the user who is logged in. The HOSTNAME and HOSTTYPE variables tell you about the computer they are using.

	The HOSTNAME variable contains the name of the current computer.
	The HOSTTYPE variable tells you what type of processor architecture the computer is running.

	The PS1 variable conatins the prompt string shown in the terminal before each command.
	$ echo $PS1
	$ PS1="$: "
	$: source ~/.bashrc

	$

Summary
	- Shell variables are variable that, instead of being created by you, are actually created by the shell.
	- That there are two types of shell variable: bourne shell varaibles, and bash shell varaibles.
	- We also took a look at some commonly used shell variables, such as the HOME, PATH, USER, HOSTNAME, HOSTTYPE, and PS1.
	- Shell variables are named in all uppercase.

Parameter Expansion Tricks ----> ${parameter} expansion 

	$ name=ZiYad
	$ echo ${name}
	ZiYad
	$ echo ${name,}
	ziYad
	$ echo ${name,,}
	ziyad
	$ name=ziYad
	$ echo ${name^}
	ZiYad
	$ echo ${name^^}
	ZIYAD
	$ echo ${#name}
	5
	
	$ numbers=0123456789
	 
	 echo ${parameter:offset:length}

	$ echo ${numbers:0:7}
	0123456
	$ echo ${numbers:1:5}
	12345
	$ echo ${numbers:3:}
	3456789
	$ echo ${numbers:-3:2}
	78
	$ echo ${numbers:-3}
	789

Comamnd Substitution ----> $(command) expansion

	$ currentdir=$(pwd)
	$ echo $currentdir

	$ time=$(date +%H:%M:%S)
	$ echo $time

Arithematic Expression ----> $((expression))

	$ echo $(( 4 +3 ))

	$ x=4
	$ y=2
	$ echo $(( x + y ))
	$ echo $(( x - y ))
	$ echo $(( x / y ))
	$ echo $(( x * y ))

	$ echo $(( 2 + 4 * 3 ))
	14
	$ echo $(( (2 + 4) * 3 ))
	20
	$ echo $(( 4 ** 2 ))
	16
	$ echo $(( 4 % 2 ))
	0

Dealing with decimal numbers - the bc command

	bc ---> basic calculator

	$ echo "5/2" | bc
	2
	$ echo "scale=2; 5/2" | bc
	2.50
	$ echo "scale=4; 5/2" | bc
	2.5000
		^^ is used for exponential like 4^^2 = 16 instead of **


Tilde Expansion

	$ echo ~
	/home/ziyad
	$ echo ~tom
	/home/tom
	$ echo ~root
	/root

	if user doesn't exist in your system, ~ won't work for that input, for example if abcd user doesnt exist then,

	$ echo ~abcd
	~abcd

	$ echo $PWD
	/home/ziyad
	$ cd /etc
	$ echo ~+		When you run ~+ in your shell, it expands to the value stored in the PWD variable.
	/etc
	$ echo $PWD
	/etc
	$ echo $OLDPWD
	/home/ziyad

	$ cd ~-
	$ echo $PWD
	/home/ziyad

	$ cd ~-
	$ echo $PWD
	/etc

	"Tilde expansion within the shell is useful when writing scripts that need to work across multiple directories"


Brace Expansion

	$ echo {1,a,19,bazzer,tom}
	1 a 19 bazzer tom

	$ echo {1..10}
	1 2 3 4 5 6 7 8 9 10

	$ echo {10..1}
	10 9 8 7 6 5 4 3 2 1

	$ echo {a..z}
	a b c d e f g h i j k l m n o p q r s t u v w x y z

	$ echo {1..20..2}
	1 3 5 7 9 11 13 15 17 19 

	$ mkdir month{01..12}

	$ touch month{01..12}/day{01..31}.txt

	There are two types of Brace expansion
	 String lists: {1,2,3,sarah,a,19}
	 Range list: {1..1000}

	Expand incrementally using an additional ".." followed by the required increament: {1..20..2}

	We can use more than one Brace expansion to a single command line along with prefixes and postfixes: month{01..12}/day{01..31}.txt




How Bash Processes Command Lines.

	5 steps bash uses to interpret a command line.
	step1: Tokenisation
		Token: "a sequence of characters that is considered as a single unit by the shell"
		Metacharacters:
			|
			&
			;
			()
			< >
			space,tab,and newline
		Word: "a token that does not contain an unquoted metacharacter"
		Operator: "a token that contains at least one unquoted metacharacter"
		The difference between words and operators is: words never contain unquoted metacharacters, operators always contain unquoted metacharacters. 
	
	step2: Command Identification
		Simple commands are just a bunch of individual words, and each simple command is terminated by a control operator.
		Compound commands, on the other hand, provide bash with its programming  constructs, such as if statements, for loops, while loops, etc.

	step3: Expansions

	step4: Quote Removal
		We often add quotes to control how the command is interpreted, so this step will simply remove all those supportive quotes.

	step5: Redirection 

	After executing these 5 steps, bash will then execute the command line that is left over. 

	Summary: 
		That the shell follows 5 steps when processing a command line 
			1. Tokenisation
			2. Command Identification
			3. Shell Expansions
			4. Quote Removal
			5. Redirection
		When the shell has done these 5 steps, it will then execute the result

		Quoting: There are three types of Quoting in bash i.e, backslashes, single quotes, and double quotes. Quoting is about Removing Special Meanings.
			1. Backlash (\):
				Removes special meaning from next character
			2. Single Quotes (''):
				Removes special meaning from all characters inside.
			3. Double Quotes (" "):
				Removes special meaning from all except dollar sign ($) and backticks (`)   

			$ echo John \& Jane
			John & Jane

			$ filepath=C:\Users\vagrant\Documents
			$ echo $filepath
			C:UsersvagrantDocuments

			$ filepath=C:\\Users\\vagrant\\Documents
			$ echo $filepath
			C:\Users\vagrant\Documents

			$ filepath='C:\Users\vagrant\Documents'		Note: there should not be a another single quotes inside a single quotes. 
			$ echo $filepath
			C:\Users\vagrant\Documents

			$ filepath="C:\Users\vagrant\Documents"
			$ echo $filepath
			C:\Users\vagrant\Documents

			$ filepath="C:\Users\\$USER\Documents"		Note: We use extra \ with $ beacuse double quotes removes all sepcial menaing execpt $ and backticks.
			$ echo $filepath
			C:\Users\vagrant\Documents

	STEP_1. Tokenisation
			Metacharacters are like punctuation.
			There are two types of operators.
				1. Control operators
				newline
				|
				||
				&
				&&
				;
				;;
				;&
				;&&
				|&
				(
				)

				2. Redirection operators

				Control + Redirection operators, only mapped if they are unquoted.

			$ echo $name > out.txt
				Here, there are four metacharacters, 3 spcae and 1 redirection (>). Also, there is 3 words: echo, $name and out.txt


	STEP_2. Command Identification
			There are two types of commands: 
				1. Simple comamnds (most common) and 
				2. Compound commands

		Simple commands:
			A simple command is just a list of words separated by spaces and terminated by either a newline or one of the other control operator available in bash. 

			$ echo 1 2 3 echo a b c
				Identified as a single command 

			$ echo 1 2 3 ; echo a b c
				Identified as two commands

			$ echo $name > out.txt
				Identified as a single command 

		Compound Commands:
			Compound Commands are essentially bash programming constructs.
			Each Compound command starts with a reserved word and is terminated by a corresponding reserved word.

			if [[ 2 -gt 1 ]]; then
				#statements
				echo "Hello World"
			fi

			Compound commands can be written over multiple lines.

	STEP_3. Expansion
		4 stages of Expansion
		Stage 1: Brace Expansion
			
		Stage 2: 
				Parameter Expansion
				Arithematic Expansion
				Command Substitution
				Tilde Expansion
			
		Stage 3: Word Splitting 

			"A process the shell performs to split the result of some unquoted expansions into separete words."
			The word Splitting is only performed on the result of unquoted:
				1. Parameter expansions
				2. Comamnd Substitutions
				3. Arithematic expansion

			The characters used to split words are governed by the IFS (Internal Field Separator) variable.
				Space, tab and new line 

			$ echo "${IFS}"

			$ echo "${IFS@Q}"
			$' \t\n'

			$ numbers="1 2 3 4 5"
			$ touch $numbers
				It will create five files because space splits the words as space is governed by IFS variable.

			$ touch "$numbers"
				It will create only only one file because word splitting doesnot perform on quoted expansion.

			$ numbers=1,2,3,4,5

			$ touch $numbers
				It will create one file because comma doesnot governed by IFS variable.

			$ IFS=","
			$ echo "${IFS@Q}"
				Now IFS variable contains only comma it doesnot work for space, tab and newline.

			$ touch $numbers
				Now, it will create five individual files.

			SIMPLE_RULE:
				If you want the output of: a Parameter expansion, Arithematic expansion and A Command Substitutions to be considered as a single word: 
				wrap that expansion in double quotes!
				Word splitting is only performed on the results of UNQUOTED parameter expansions, command substitutions and arithmetic expansions.
		
		Stage 4: Globally

			"The first thing you need to know is that expansions in earlier stages are performed first."
			Example: $ x=5
					 $ echo {1..$x}
			output:  {1..$x}		This is because brace expansion execute first before assigning a value to x

			"The second thing you need to know is that expansions that are in the same stage are all given the same priority, 
			and are simply performed in the order they are found on the command line when it is read from left to right."
			Example:$ name=Varun 
				 	$ echo "$name has $(( 1+2 )) apples"
					 Varun has 3 apples
				 	$ echo "$name has {1..3} apples and $((5+2)) oranges"
				 	Varun has 1 2 3 apples and 7 oranges

					$ ls *

					$ ls *.pdf
					report1.pdf report2.pdf report3.pdf report123.pdf
		
					$ ls file???.txt
					fileabc.txt
		
					$ ls file?.pdf
					report1.pdf report2.pdf report3.pdf
		
					$ ls file[abc][abc][abc].txt
					fileabc.txt
		
					$ ls file [a-g].txt
					filea.txt fileb.txt filec.txt

					$ ls file[0-9].txt

	STEP_4: Quote Removal
		Quote Removal is the process that bash uses to remove redundant quotes from the final command.
		The Shell will remove from the final command any unquoted backslashes, single quote characters, and double quote characters that did not result from an expression.

		Quote removal removes all unquoted occurrences of double quotes, single quotes and backslash that were not the result of an expansion.
		
		$ echo \"Hello World\"
		"Hello World"

		In the above example, the backslashes are “quoting” the double quotes, so the double quotes remain. However, 
		the backlashes themselves are removed because they are unquoted and not the result of an expansion. 

	STEP_5: Redirection 

		Data Streams:
			Stream 0 = Standard Input (stdin)
			Stream 1 = Standard Output (stdout)
			Stream 2 = Standard Error (stderr)

		$ cat < hello.txt
			It will print the content of hello.txt on the screen.

		$ echo "This is some output" > output.txt
			It will create a new file named output.txt

		$ cd /root 2> error.txt
		$ cat error.txt
		cat: error.txt: No such file or directory

		$ cd /root &> /dev/null
			It will redirect standard output and standard error to /dev/null, which truncate the data.

		We can use >> to append the data rather than truncate them.


	There are three examples which are provided in the document. They are crucial examples to understand how bash processes command line.

		$ touch "Daily Report $(date +"%a %d %h %y")"

Positional Parameters 
	
	Positional Parameters Project Brief

Scenario
You have been asked to create a bash script that will serve as a basic calculator and allow you to perform simple arithmetic calculations from the command line.
The calculator needs to be able to do addition, subtraction, multiplication and division, on a maximum of 9 numbers. The first command line argument given to the 
script will contain the operation that is to be performed on the numbers (either + or -). The operation chosen will be applied to all the numbers. 
For example, if the first command line argument is “+”, then all the other command line arguments will be added together. If the user picks “-”, then all the other
command line arguments will be subtracted from each other, and so on. Your script needs to be able to accept the operation as the first command line argument, and also 
accept up to 9 numbers (for a total of 10 command line arguments).

Hint 1: You will need to use the first positional parameter, which is the operator,
multiple times

Hint 2: You can use the echo command to display the result of the arithmetic
expansion

Hint 3:
+ and - , like all binary operators, require there to be an operand before and after the operator. “1 +” and “2 -” on their own don’t make any sense.
Given this, what would you do if the user only wanted to add 4 numbers, for example?
To get around this issue, consider how you might use a parameter expansion trick like ${parameter:-word} to substitute a default value if a given positional parameter
is not provided.

	$ vi calculator.sh

	#!/bin/bash

	echo $(( ${2:-0} $1 ${3:-0} $1 ${4:-0} $1 ${5:-0} $1 ${6:-0} $1 ${7:-0} $1 ${8:-0} $1 ${9:-0} ))

	:wq (save and exit)

	$ chmod 744 calculator.sh

Special Parameters
	The $# and $0 are special parameters. 
	- Special parameters that bash gives special meaning.
	- Value of a special parameter is calculated for us based on our current script.

	$# stores the number of command line arguments provided to the script. 
	$0 stores the script name and can be used to create error messages.

	Use the $* and $@ special parameters to expand to the positional parameters. We will understand the different meanings these special parameters have when they are wrapped
	inside double quotes.

	Unquoted $* is exactly the same as unquoted $@
	"$*" provides all positional parameters as one word, but separated by the first character of the IFS variable. The final word is not subject to further word splitting.
	"$@" expands to each positional parameter as its own word without subsequent word splitting.

	$ vi calculator.sh

	#!/bin/bash

	#echo $(( ${2:-0} $1 ${3:-0} $1 ${4:-0} $1 ${5:-0} $1 ${6:-0} $1 ${7:-0} $1 ${8:-0} $1 ${9:-0} ))

	echo "$@"

	:wq (save and exit)

	$./calculator 3+5
	8

Read and Select Command 

	Example:
		#!/bin/bash

		# Author: "Ausaf Umar Khan"
		# Date Created : 2024-04-26
		# Last Modified : 2024-04-27

		# Description :
		# It will take first name, surname, extenison and access code from user and redirect them to extension.csv file.

		# Usage
		# ./get_extension.sh

		read -p "What is your first name?: " firstname
		read -p "What is your surname/family name?: " lastname
		PS3="What type of phone do you have?: "

		select  phone in headset handheld; do
		echo "Your phone type is $phone"
		break
		done

		PS3="What department do you work in? :"
		select department in finance sales "customer service" engineering; do
		echo "Your department is $department"
		break
		done 

		read -N 4 -p "What is your extension number? (must be 4 digits): " extension
		echo
		read -N 4 -s -p "What access code would you like to use when dialing in?: (must be 4 digits) " access
		echo

		echo "$firstname,$lastname,$phone,$department,$extension,$access" >> extension.csv

		exit 0

Chaining commands with List Operators
	List Operators: & ; && ||

	$ echo 123 & echo 456		-- Runs commands asynchrously 
	$ echo 123 ; echo 456		-- Runs command sequentially

	$ echo 123 && echo 456
	123
	456

	$ echo 123 || echo 456
	123

	$ commandA && commandB || commandC		-- This is called ternary operator which is handy trick to have.

Test Commands + Conditional Operators

	Test command: "a command that can be used in bash to compare different pieces of information". If a test is evaluated to be true, the test will return an exit status of 0.

	Integer test operators:

		$ [ 1 -eq 2 ] ; echo $?
		1
		$ [ 1 -ne 2 ] ; echo $?
		0

	Other options: -gt -lt -geq -leq		

		$ a=hello
		$ b=world
		$ [[ $a = $b ]] ; echo $?
		1
		$ [[ $a != $b ]] ; echo $?
		0

	-z is used to check an empty string.

		$ [[ -z $c ]] ; echo $?

	-n is used to check a non-empty string.
		$ [[ -n $c ]] ; echo $?
	

	File test operators compare files

		$ [[ -e today.txt  ]] ; echo $?		-- This will check file existence in present working directory
		1

		$touch today.txt
		
		$ [[ -e today.txt  ]] ; echo $?
		0

		$ [[ -f today.txt  ]] ; echo $?		-- -f checks for file
		0

		$ [[ -d today.txt  ]] ; echo $?		-- -d checks for directory
		1

		$ [[ -x script  ]] ; echo $?		-- -x checks for script depending on permissions.
		1

		$ chmod 744 script
		$ [[ -x script  ]] ; echo $?
		0

		$ [[ $HOME = ~ ]] ; echo $?
		0

If statements:
	
	If statements start and end using reserved words "if" and "fi". 

	$ nano memory_logger.sh 
	
	#!/bin/bash

	# Author: "Ausaf Umar Khan"
	# Date Created : 2024-05-02
	# Last Modified : 2024-05-02

	# Description :
	# This is used to log memory usage to check performance issue

	# Usage
	# ./memory_logger.sh

	if [[ -d $HOME/performance ]]; then
		echo "Folder $HOME/performance exists"
	else
		mkdir $HOME/performance
		echo "Folder $HOME/performance created"
	fi

	echo $(free -m) >> $HOME/performance/memory.log
	echo "Memory log copied to ~/performamce/memory.log"

	exit 0


	$ chmod 744 memory_logger.sh

Case statements:
	Case statements start and end using the reserved words "case" and "esac"

	$ nano case_switch.sh
	#!/bin/bash

	read -p "Please enter a number: " number

	case "$number" in 
		[0-9]) echo "You have entered a single digit number" ;;
		[0-9][0-9]) echo "You have entered a double digit number" ;; 
		[0-9][0-9][0-9]) echo "You have entered a three digit number" ;;
		*) echo "You have entered more than three  digit number" ;; 
	esac

While Loops
	While loops run a set of commands while a certain condition is true.

	$ nano while.sh
	#!/bin/bash

	read -p "Enter your number: " num

	while [ $num -ge 10 ]; do
		echo "$num"
		num=$(( num-1 ))
	done

Handling Command Line Options 
	getopts command allows a script to run differently according to the options provided. 

	$ nano temp_check.sh

	#!/bin/bash

	while getopts "f:c:" opt; do
	case "$opt" in
		c) 
			result=$(echo "scale=2; ($OPTARG * (9 / 5)) + 32" | bc);;
		f) 
			result=$(echo "scale=2; ($OPTARG - 32) * (5/9)" | bc);;
		\?)
			echo "$opt";;	
	esac
	done
	echo "$result"

	$ nano timer.sh

	#!/bin/bash

	getopts "m:s:" opt

	if [[ $opt ==  m ]]; then
		total_sec=$(( $OPTARG * 60 ))
	else
		total_sec=$OPTARG
	fi
	while [[ total_sec -ne 0 ]]; do
		echo "Remaining time: $total_sec seconds"
		sleep 1s
		total_sec=$(( $total_sec - 1 ))
	done

	$ cat city_check,sh 
	#!/bin/bash

	PS3="Please select from the above cities: "
	select city in Tokyo London "Los Angeles" Moscow Dubai Manchester "New York" Paris Bangalore Johannesburg Istanbul Milan "Abu Dhabi" Pune Nairobi Berlin Karachi; 
	do

	case $city in 
		Tokyo) 
			country="Japan" ;;
		London|Manchester) 
			country="England" ;;
		"Los Angeles"|"New York") 
			country="USA" ;;
		Moscow) 
			country="Russia" ;;
		Paris) 
			country="France" ;;
		Bangalore|Pune)
			country="India" ;;
		Johannesburg)
			country="South Africa" ;;
		Istanbul)
			country="Turkey" ;;
		Milan)
			country="Italy" ;;
		Dubai|"Abu Dhabi")
			country="UAE" ;;
		Nairobi)
			country="Kenya" ;;
		Berlin)
			country="Germany" ;;
		Karachi)
			country="Paksitan" ;;
		*) echo "Not in the list" ;;
	esac
	echo "$city is in $country"
	break
	done


 Iterating over files with read-while loops
 	We can use read-while loops to iterate over the content of files. we can use process substitution along with read-while loop to iterate over the output of commands.
 	Read-while loops are while loops that use the read command as their test command.

 	$ cat read-while.sh
	#!/bin/bash

	while read line; do
		echo "$line"
	done < "$1"


	$ cat read-while.sh
	#!/bin/bash
	# Example of process substitution

	while read line; do
		echo "$line"
	done < <(ls $HOME)


Arrays and For Loops
	- Able to create literal indexed arrays.
	- Able to add, remove, update and extract elements from indexed arrays
	- Able to use the readarray command to easily generate indexed arrays, without having to type the values out manually for yourself
	- Able to use "for" loops to iterate over arrays
	- Able to use "for" loops with logic to perform different actions for each elements of an array

	Working with Indexed Arrays
		Variables can only be used to store one piece of data at a time.
		Arrays can store multiple different values at the same time.

		Declaring an array
			$ numbers=(1 2 3 4)

			$ echo $numbers
			1
			$ echo ${numbers[2]}
			3
		$ echo ${numbers[@]}
		1 2 3 4

		$ echo ${numbers[@]:1:2}
		2 3

	Adding an element to existing array:
		$ numbers+=(5)
		$ echo ${numbers[@]}
		1 2 3 4 5

	Removing an element from existing array:
		$ unset numbers[2]
		$ echo ${numbers[@]}
		1 2 4 5

	To get index of a array:
		$ echo ${!numbers[@]}
		0 1 3 4					-- We can see that index '2' is missing because we just deleted an element 2 so indexed of it was deleted as well.

	Change of zeroth element 
		$ numbers[0]=a
		$ echo ${numbers[@]}


	The readarray command
		- The readarray command is super useful command in Bash because it allows us to generate arrays both the content of a file and from the output of commands.
		- The readarray command converts whatever it reads on its standard input stream into an array

	Creating an array from the content of a file:

		$ nano days.txt
		Monday
		Tuesday
		Wednesday
		Thursday
		Friday
		Saturday
		Sunday

		$ readarray days < days.txt

		$ echo ${days[@]}
		Monday Tuesday Wednesday Thursday Friday Saturday Sunday

		$ echo ${!days[@]}
		0 1 2 3 4 5 6

		$ echo ${days[@]@Q}
		$'Monday\n' $'Tuesday\n' $'Wednesday\n' $'Thursday\n' $'Friday\n' $'Saturday\n' $'Sunday\n'

		$ readarray -t days < days.txt

		$ echo ${days[@]@Q}
		'Monday' 'Tuesday' 'Wednesday' 'Thursday' 'Friday' 'Saturday' 'Sunday'


	Creating an array from the output of commands/process susbstitution:
		In this example, we will create an array with absolute path of the files in a directory.

		$ mkdir ~/test
		$ touch test/file{1..100}.txt

		$ readarray files < <(ls ~/test)
		$ echo ${files[@]}

		$ echo ${files[@]@Q}

		$ readarray -t files < <(ls ~/test)
		$ echo ${files[@]@Q}

	Iterating over arrays with For Loops
		- Use 'for' loops to iterate over lists of elements you write manually 
		- Use 'for' loops to iterate over arrays
		- Use 'for' loops with logic to perform different actios for each element of an array

		A 'for' loop iterates over a list of words or elements and performs a set of commands "for" each element.

		$ nano file_creator.sh
		#!/bin/bash

		readarray -t files < files.txt

		for file in "${files[@]}"; do
			if [ -e "$file" ]; then
				echo "$file already existed"
			else
				touch "$file"
				echo "$file was created"
			fi
		done

Debugging
	Debugging using Shellcheck
		If you get the syntax wrong, your script will not work, Shellcheck picks up on subtle syntax errors you have made in your script.
		Shellcheck makes recommendations on your scripts. It has bith web inteface (www.shellcheck.net) and command inteface.

		$ sudo apt install shellcheck

		$ shellcheck <script_name.sh>

		Shellcheck has one main limitation: Shellcheck cannot detect issues with the environment that the script will be running in.
		Environment issues:
			- If a specific file or folder exists 
			- How permissions are setup
			- If a specific command or application is installed

	Error Message Structure + How to Solve Common Errors

	How to find help
		Internal commands are commands that are built into the bash shell 
		External commands are commands that are external to bash shell 

		$ type -a cd
		cd is a shell builtin
		cd is /usr/bin/cd

		$ help man info

		$ help -d ls

		$ man ls

		$ man -k compress

		$ man -k "list directory content"

		$ info ls


		'help' provides support for commands built into bash (internal commands), whereas 'man' provides support for commands not built into bash (external commands).

Scheduling and Automating 

	The “at” command
		Installation of 'at' command. It doesnot come with ubuntu by default.
			$ sudo apt install at -y

			$ service atd status
			 If service is not running, then we have to start the service

			$ service atd start

			$ service atd stop
			$ service atd restart

			$ at 9:30am
			warning: commands will be executed using /bin/sh
			at> echo "Hello world"
			at> <EOT>							# Press cltr+D  to exit
			job 1 at Fri May 10 09:30:00 2024	# It will give job ID with time of next execution

			$ at -l  			# It lists all jobs with Job ID and time of execution. Here 'a' is a name of queue and 'vagrant' is a username.
			1	Fri May 10 09:30:00 2024 a vagrant
			$ at -r <job_id>	# To remove a job

		To run a script file using 'at'.
			$ at 10am -f at_script.sh

			$ at -l

			$ at 10am Monday -f at_script.sh

			$ at 10am 12/23/2023 -f at_script.sh

			$ at 10am 23.12.2023 -f at_script.sh

			$ at 9am tomorrow -f at_script.sh

			$ at 9am next week -f at_script.sh

			$ at now + 5 minutes -f at_script.sh

			$ at now + 2 days -f at_script.sh

	Using Cron to schedule and automate bash scripts
			$ service cron status

			$ service cron start

				A crontab is basically a text file that contains a table of which commands the user wants cron to run.
			$ crontab -e

			mon 	h 	dom 	mon 	dow 	command
			 *		*	 *		 *		 *		~/bashrc/cronjob.sh


			$ sudo nano /etc/crontab
			$ m   h dom mon dow   user      command
			  *   *  *   *   *  someuser   echo 'foo'

			$ sudo service cron restart

		A tour of Crontab.guru
		 	https://crontab.guru/

		Cron directories
			Cron directories are folders on your system where you can place scripts to run at a particular frequency.

			$ ls /etc/ | grep cron
			cron.d
			cron.daily
			cron.hourly
			cron.monthly
			cron.weekly
			crontab

			schedules of cron.daily, cron.hourly, cron.monthly and cron.weekly are in /etc/crontab file.

			$ sudo nano /etc/crontab 	# crontab is a system config file so we need root privilege to edit the file 

			To copy script file in cron.weekly directory, we need sudo Again

			$ sudo cp ~/backup_script.sh /etc/cron.weekly/backup_script

				Note: Only root has access to run these scripts as we need sudo privilege, we can create our own cron directory. Lets create a cron directory in our home directory

			$ mkdir cron.daily.2am
			$ pwd
			/home/vagrant

			$ crontab -e

			Add the following line at the bottom of a file

			00 02 * * *  running-parts ~/cron.daily.2am --report

			If we place any script or multiple scripts in cron.daily.2am directory to schedule tasks at 2 am everyday. Likewsie, we can create any cron directory to
			execute tasks at particular time.

			
		Project: Cron scheduling
			For more details, Please check it out: Cron+scheduling+Project+Brief.pdf

			$ nano update_script.sh
			#!/bin/bash

			apt -y update
			apt -y upgrade

			if [ -f /var/run/reboot-required ]; then
        			reboot
			fi

			$ chmod 744 update_script.sh  	# This is no need to giving a permission, as it will be executed by root only.

			To make it executable by root user, edit /etc/crontab and add the following line at the bottom of the file.
			$ sudo nano /etc/crontab

			00 00 * * * /home/vagrant/update_script.sh


			$ sudo service cron restart


	Anacron
		'at' allowed us to schedule scripts to run once-off but has no way to repeat this.
		'cron' runs commands on a schedule, but requires the machine to be on at the time.
		'anacron' can recover missed jobs.

		$ sudo nano /etc/anacrontab

		Your boss wants you to use anacron to create a job called daily-routine which will run the script today.sh every day. Which expression would be correct?
		1 5 daily-routine today.sh

		If an anacron is installed on a system, then jobs will be executed by anacron instead of cron because of its ability to recover missed jobs.
		The anacron service stores the log timestamps of when jobs were run in the following.
		$ ls /var/spool/anacron

Working with remote Servers

	How to execute scripts on a remote server (ssh)
		ssh stands for "secure shell"

		$ cd ~/.ssh
		$ ssh-keygen		# to generate ssh key
		$ ls

		$ sh-copy-id <remote_user>@<remote_ip>	# To copy public key on remote server 
			It may ask password of a user

		$ ssh <remote_user>@<remote_ip>
			Now, you logged-in to remote server.

		$ cd ~
		$ nano remote.sh
		#!/bin/bash

		echo "I am far away" >> remote.txt

		$ crontab -e

		*/1 * * * * ~/remote.sh

		$ cat remote.txt

		$ exit


	How to send and receive files from a remote server (scp)
		We can use scp command to push and pull files to and from your remote server. SSCP uses SSH connection for file transfer.

		$ nano ip_script.sh 	# This script saves public ip of a server on which it will be executed.
		#!/bin/bash

		curl ifconfig.co > ip.txt

		$ chmod 744 ip_script.sh

		$ scp ~/ip_script.sh <remote_user>@<remote_ip>:~/	# copy file to remote server

		$ ssh <remote_user>@<remote_ip>		# Connect to remote server

		$ ls ~
		ip_script.sh

		$ ./ip_script.sh
		$ cat ip.txt 		# show ip address of a remote server on which we execute script.
		<remote_ip>

		$ exit

		Now we are at our local system, We have to pull ip.txt file from remote server to our local server.

		$ scp <remote_user>@<remote_ip>:~/ip.txt ~/




New Course on Shell Script

Linux Shell Scripting: A Project-Based Approach to Learning

	$ man test
	To get all the possible test - check file types and compare values

	$ type -a test

	$ id -un		# to get username 

	$ echo ${?}		# to get exit code

To update and set default parameters for new user, we need to edit the following file.
	
	$ nano /etc/login.defs


Use checksum or cyptographic hash functions, 
A checksum is a numeric value computed for a block of data that is relatively unique. 
Checksum were and are used to verify the integrity of data such as files. For example, if we download a file and want to make sure that it is not corrupt in some way, we
can find the published checksums for the file and compare with file we download.

To retrieve checksum of a file:

	$ sha1sum <filename>

	We can download the sha1sum file of a file and compare them to verify integrity of a file.

To check list of checksum file or other checksums

 	$ ls -l /usr/bin/*sum

To retrieve sha256sum of a file:
	
	$ sha256sum <filename>

If we change a file content then it will generate different checksum. We can try it by appending any data into file, for example

	$ echo "1" >> <filename>
	$ sha1sum <filename>
		This time, it will yield different checksum.

To display first 3 lines of a file
	$ head -n3 /etc/passwd


To display first two character of a files

	$ head -c2 /etc/passwd

	
# Random number as password
$ PASSWORD="${RANDOM}"
$ echo "${PASSWORD}"

# Three Random numbers together
$ PASSWORD="${RANDOM}${RANDOM}${RANDOM}"
$ echo "${PASSWORD}"

# Use the current date/time as the basis for the password
$ PASSWORD=$(date +%s)
$ echo "${PASSWORD}"

# Use nanosecond to act as randomization
$ PASSWORD=$(date +%s%N)
$ echo "${PASSWORD}"

# A better password
$ PASSWORD=$(date +%s%N${RANDOM}${RANDOM}${RANDOM} | sha256sum | head -c32)
$ echo "${PASSWORD}"


# Append a special charater to a password
$ SPECIAL_CHARACTER=$(echo '!@#$%^&*()' | fold -w1 | shuf | head -c1)
$ echo "${PASSWORD}${SPECIAL_CHARACTER}"
	
















	






