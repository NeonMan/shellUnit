#Tests if param 1 and 2 are equal (string)
#
# Params:
#    $1 <-- A string
#    $2 <-- A string
assertEquals () {
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
assertNotEquals () {
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
assertGreaterThan () {
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
assertNotGreaterThan () {
	if [ "$1" -gt "$2" ]
	then
		fail "$current_test: expect '$2' NOT to be greater than '$1'"
	else
		pass
	fi
}

#Tests if param 1 is lesser than param 2 (integer)
#
# Params:
#    $1 <-- An integer
#    $2 <-- An integer
assertLessThan () {
        if [ "$1" -lt "$2" ]
        then
                pass
        else
                fail "$current_test: expect '$2' to be less than '$1'"
        fi
}

#Tests if param 1 is not lesser than param 2 (integer)
#
# Params:
#    $1 <-- An integer
#    $2 <-- An integer
assertNotLessThan () {
        if [ "$1" -lt "$2" ]
        then
                fail "$current_test: expect '$2' NOT to be less than '$1'"
        else
                pass
        fi
}

#Tests if param 1 (string) matches the param 2 regexp
#
# Params:
#    $1 <-- A regular expression
#    $2 <-- A string
assertMatches () {
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
assertNotMatches () {
	if [[ "$2" =~ $1 ]]
	then
		fail "$current_test: expect '$2' to NOT match regular expression '$1'"
	else
		pass
	fi
}
