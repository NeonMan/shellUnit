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
	echo "$SHU_TEST_FILE,$SHU_TEST_NAME,$SHU_TEST_LINE,OK" >> "$SHU_TMP_DIR/result.csv"
}

#Increment assert count AND error count while showing a message.
#also sets the 'error' variable to 'yes'
#
# Params:
#    $1 <-- The message to print
fail () {
	countAssert
	echo "$SHU_TEST_FILE,$SHU_TEST_NAME,$SHU_TEST_LINE,FAIL,$1" >> "$SHU_TMP_DIR/result.csv"
	#printColorized red "Line $SHU_TEST_LINE: $1"
	error="yes"
	failedAsserts=`expr $failedAsserts + 1`
}
