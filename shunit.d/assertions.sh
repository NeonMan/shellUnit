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
# Env:
#    SHU_TEST_FILE
#    SHU_TEST_NAME
#    SHU_TEST_LINE
#    SHU_TEST_INIT_TIME
#    SHU_TEST_END_TIME
pass () {
	SHU_TEST_END_TIME=`date +"%s%3N"`
	countAssert
	echo "SHU,ASSERT,$SHU_TEST_FILE,$SHU_TEST_NAME,$SHU_TEST_LINE,$SHU_TEST_INIT_TIME,$SHU_TEST_END_TIME,OK,"
}

#Increment assert count AND error count while showing a message.
#
# Params:
#    $1 <-- The message to print
# Env:
#    SHU_TEST_FILE
#    SHU_TEST_NAME
#    SHU_TEST_LINE
#    SHU_TEST_INIT_TIME
#    SHU_TEST_END_TIME
fail () {
	SHU_TEST_END_TIME=`date +"%s%3N"`
	countAssert
	echo "SHU,ASSERT,$SHU_TEST_FILE,$SHU_TEST_NAME,$SHU_TEST_LINE,$SHU_TEST_INIT_TIME,$SHU_TEST_END_TIME,FAIL,$1"
	SHU_FAILED_ASSERTS=`expr $SHU_FAILED_ASSERTS + 1`
}
