
#!/bin/bash

#Take two integers $1 and $2, then add them
addition () {
	return `expr "$1" '+' "$2"`
}

#Multiply $1 and $2
multiplication () {
	return `expr "$1" '*' "$2"`
}

#Show usage
usage () {
	echo "Usage: $0 sum|mul INTEGER_1 INTEGER_2"
}

#Main procedure
if [ $# -ne 3 ]
then
	usage
else
	if [ $1 == 'sum' ]
	then
		addition "$2" "$3"
		echo "$?"
	else
		if [ $1 == 'mul' ]
		then
			multiplication "$2" "$3"
			echo "$?"
		#Uncomment to make the test pass
		#else
		#	usage
		fi
	fi
fi

