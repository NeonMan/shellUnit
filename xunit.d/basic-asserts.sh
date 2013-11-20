#!/bin/bash

#Tests if param 1 and 2 are equal (string)
#
# Params:
#    $1 <-- A string
#    $2 <-- A string
function assertEquals {
	if [ "$1" == "$2" ]
	then
		pass
	else
		fail "$current_test: expected '$1' but found '$2'"
	fi
}

#Tests if param 1 and 2 are NOT equal (string)
#
# Params:
#    $1 <-- A string
#    $2 <-- A string
function assertNotEquals {
	if [ "$1" == "$2" ]
	then
		fail "$current_test: expected NOT to be '$1' but found '$2'"
	else
		pass
	fi
}

#Tests if param 1 is greater than param 2 (integer)
#
# Params:
#    $1 <-- An integer
#    $2 <-- An integer
function assertGreaterThan {
	if [ "$1" -gt "$2" ]
	then
		pass
	else
		fail "$current_test: expect '$2' to be greater than '$1'"
	fi
}

#Tests if param 1 is not greater than param 2 (integer)
#
# Params:
#    $1 <-- An integer
#    $2 <-- An integer
function assertNotGreaterThan {
	if [ "$1" -gt "$2" ]
	then
		fail "$current_test: expect '$2' to NOT be greater than '$1'"
	else
		pass
	fi
}

#Tests if param 1 (string) matches the param 2 regexp
#
# Params:
#    $1 <-- A string
#    $2 <-- A regular expression
function assertMatches {
	if [[ "$2" =~ $1 ]]
	then
		pass
	else
		fail "$current_test: expect '$2' to match regular expression '$1'"
	fi
}

#Tests if param 1 (string) does not match the param 2 regexp
#
# Params:
#    $1 <-- A string
#    $2 <-- A regular expression
function assertNotMatches {
	if [[ "$2" =~ $1 ]]
	then
		fail "$current_test: expect '$2' to NOT match regular expression '$1'"
	else
		pass
	fi
}

#Test if a file contains a line matching a regexp
#
# Params:
#    $1 <-- A file
#    $2 <-- A regular expression
#
# @bug test wether the file exists (and is a normal file) to attempt the test
function assertFileContains {
	if [[ `grep "$2" $1` = "" ]]
	then
		fail "$current_test: expect '$1' to contain '$2'"
	else
		pass
	fi
}
