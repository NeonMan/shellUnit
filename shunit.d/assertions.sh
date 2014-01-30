SHU_NUM_ASSERTS=0
SHU_FAILED_ASSERTS=0

#Increments the numAsserts variable by one
#
# Params: None
countAssert () {
	SHU_NUM_ASSERTS=`expr $SHU_NUM_ASSERTS + 1`
}

#A test that always passes
#
# Params: None
pass () {
	countAssert
	echo "SHU,ASSERT,$SHU_TEST_FILE,$SHU_TEST_NAME,$SHU_TEST_LINE,OK,"
}

#Increment assert count AND error count while showing a message.
#
# Params:
#    $1 <-- The message to print
fail () {
	countAssert
	echo "SHU,ASSERT,$SHU_TEST_FILE,$SHU_TEST_NAME,$SHU_TEST_LINE,FAIL,$1"
	SHU_FAILED_ASSERTS=`expr $SHU_FAILED_ASSERTS + 1`
}
