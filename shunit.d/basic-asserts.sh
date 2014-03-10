#Tests if the expression returns true
#The return value of the expression must be nonzero for this assert to
#succeed. Refer to the implementation below.
#
# Params:
#    $1 <-- A expression.
assertTrue () {
	if eval "$1"
	then
		pass
	else
		fail "expression '$1' is false"
	fi
}

#Tests if the expression returns false
#The return value of the expression must be zero for this assert to
#succeed. Refer to the implementation below.
#
# Params:
#    $1 <-- A expression.
assertFalse () {
	if eval "$1"
	then
		fail "expression '$1' is true"
	else
		pass
	fi
}

#Always passes, used for custom asserts
#
# Params: None
assertSuccess () {
	pass
}

#Always fails, used for custom asserts
#
# Params: None
assertFail () {
	fail "assertFail called"
}

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
		fail "expected '$1' but found '$2'"
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
		fail "expected NOT to be '$1' but found '$2'"
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
		fail "expected '$2' to be greater than '$1'"
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
		fail "expected '$2' NOT to be greater than '$1'"
	else
		pass
	fi
}

#Tests if param 1 is greater or equal to param 2
#
# Params:
#    $1 <-- An integer
#    $2 <-- An integer
assertGreaterThanOrEqual () {
	assertNotLessThan $1 $2
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
                fail "expected '$2' to be less than '$1'"
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
                fail "expected '$2' NOT to be less than '$1'"
        else
                pass
        fi
}

#Tests if param 1 is less thann or equal to param 2(integer)
#
# Params:
#    $1 <-- An integer
#    $2 <-- An integer
assertLessThanOrEqualTo () {
	assertNotGreaterThan $1 $2
}

#Tests if a number is close to another
#
# Params:
#    $1 <-- A number to be tested
#    $2 <-- Expected value
#    $3 <-- Error margin
assertCloseTo () {
	lower_bound=`expr $2 - $3`
	upper_bound=`expr $2 + $3`
	if [ '(' "$1" -ge "$lower_bound" ')' -a '(' "$1" -le "$upper_bound" ')' ]
	then
		pass
	else
		fail "$1 not in range [ $lower_bound - $upper_bound ]"
	fi
}

#Tests if a number is NOT close to another
#
# Params:
#    $1 <-- A number to be tested
#    $2 <-- Expected value
#    $3 <-- Error margin
assertNotCloseTo () {
        lower_bound=`expr $2 - $3`
        upper_bound=`expr $2 + $3`
        if [ '(' "$1" -ge "$lower_bound" ')' -a '(' "$1" -le "$upper_bound" ')' ]
        then
		fail "$1 in range [ $lower_bound - $upper_bound ]"
        else
		pass
        fi
}

