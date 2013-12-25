#Test if parameter is a existing regular file
#
# Params:
#     $1 <-- A file path
assertIsFile () {
	if [ -f "$1" ]
	then
		pass
	else
		fail "'$1' is not a regular file or does not exist"
	fi
}

#Test if parameter is NOT a regular file (but esists)
#
# Params:
#     $1 <-- A path
assertIsNotFile () {
	if [ '(' ! '(' -f "$1" ')' ')' -a '(' -e "$1" ')' ]
	then
		pass
	else
		fail "'$1' is a file or does not exist"
	fi
}

#Test if parameter is a existing directory
#
# Params:
#     $1 <-- A dir path
assertIsDir () {
	if [ -d "$1" ]
	then
		pass
	else
		fail "'$1' not a directory"
	fi
}

#Test if parameter is not a directory (but exists)
#
# Params:
#     $1 <-- A path
assertIsNotDir () {
	if [ '(' ! '(' -d "$1" ')' ')' -a '(' -e "$1" ')' ]
	then
		pass
	else
		fail "'$1' is a directory or does not exists"
	fi
}

#Test if parameter exists (file, directory, node, whatev)
#
# Params:
#     $1 <-- A path
assertExists () {
	if [ -e "$1" ]
	then
		pass
	else
		fail "'$1' does not exist"
	fi
}

#Test if parameter does not exist
#
# Params:
#     $1 <-- A path
asserNotExists () {
	if [ -e "$1" ]
	then
		fail "'$1' exists"
	else
		pass
	fi
}

#Test if path is a existing link
#
# Params:
#     $1 <-- A path
assertIsLink () {
	if [ -L "$1" ]
	then
		pass
	else
		fail "'$1' is not a link or does not exist"
	fi
}

#Test if path is NOT a link, but exists
#
# Params:
#	$1 <-- A path
assertIsNotLink () {
	if [ '(' ! '(' -L "$1" ')' ')' -a '(' -e "$1" ')' ]
	then
		pass
	else
		fail "'$1' is a link or does not exist"
	fi
}

