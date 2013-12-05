#Test if a file contains a line matching a regexp
#
# Params:
#    $1 <-- A file
#    $2 <-- A regular expression
#
# @bug test wether the file exists (and is a normal file) to attempt the test
assertFileContains () {
	if [[ `grep "$2" $1` = "" ]]
	then
		fail "$current_test: expect '$1' to contain '$2'"
	else
		pass
	fi
}
