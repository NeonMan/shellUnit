#Test if a file contains a line matching a regexp
#
# Params:
#    $1 <-- A file
#    $2 <-- A regular expression
assertContains () {
	if grep -q -F "$2" "$1"
	then
		pass
	else
		fail "Expected file to contain <$2>"
	fi
}

#Test if a file contains a line matching a regexp
#
# Params:
#    $1 <-- A file
#    $2 <-- A regular expression
assertNotContains () {
	if grep -q -F "$2" "$1"
	then
		fail "Expected file to contain <$2>"

	else
		pass
	fi
}
