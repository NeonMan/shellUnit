numAsserts=0
failedAsserts=0

#Increments the numAsserts variable by one
#
# Params: None
countAssert () {
	numAsserts=`expr $numAsserts + 1`
}

#A test that always passes
#
# Params: None
pass () {
	countAssert
}

#Increment assert count AND error count while showing a message.
#also sets the 'error' variable to 'yes'
#
# Params:
#    $1 <-- The message to print
fail () {
	countAssert
	echo -n "   "
	printColorized red "$1"
	error="yes"
	failedAsserts=`expr $failedAsserts + 1`
}