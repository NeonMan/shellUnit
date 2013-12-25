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
		fail "expected '$1' to contain '$2'"
	else
		pass
	fi
}

#Test if a file is owned by a user, either by name or UID
#
# Params:
#     $1 <-- A path
#     $2 <-- a user name | UID
assertOwnerIs () {
	SHU_USER=""
	if [[ "$2" =~ [0-9][0-9]* ]]
	then
		SHU_USER=`shu_getUser "$2"`
	else
		SHU_USER="$2"
	fi
	SHU_FOWNER=`shu_fileOwner "$1"`

	if [ "$SHU_FOWNER" = "$SHU_USER" ]
	then
		pass
	else
		fail "Expected user <$SHU_USER> but found <$SHU_FOWNER>"
	fi
}

#Test if a file is NOT owned by a user, either by name or UID
#
# Params:
#     $1 <-- A path
#     $2 <-- a user name | UID
assertOwnerIsNot () {
	SHU_USER=""
	if [[ "$2" =~ [0-9][0-9]* ]]
	then
		SHU_USER=`shu_getUser "$2"`
	else
		SHU_USER="$2"
	fi
	SHU_FOWNER=`shu_fileOwner "$1"`

	if [ "$SHU_FOWNER" = "$SHU_USER" ]
	then
		fail "Expected user not to be <$SHU_USER>"
	else
		pass
	fi
}
