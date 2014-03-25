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
assertNotExists () {
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

#Test if two paths point to the same inode (soft and hard links)
#
# Params:
#     $1 <-- A path
#     $2 <-- Another path
assertSameInode () {
	if [ "$1" -ef "$2" ]
	then
		pass
	else
		fail "'$1' and '$2' point to different inodes"
	fi
}

#Test if two paths do NO point to the same inode (soft and hard links)
#
# Params:
#     $1 <-- A path
#     $2 <-- Another path
assertNotSameInode () {
	if [ ! '(' "$1" -ef "$2" ')' ]
	then
		pass
	else
		fail "'$1' and '$2' point to the same inode"
	fi
}

#Test if a file is owned by a user, either by name or UID
#
# Params:
#     $1 <-- A path
#     $2 <-- a user name | UID
assertOwnerIs () {
	SHU_FDIR=`dirname "$1"`
	SHU_TEMP=`find "$SHU_FDIR" -user "$2" | grep -F "$1"`
	if [ "$SHU_TEMP" = "" ]
	then
		fail "Expected user <$2>"
	else
		pass
	fi
}

#Test if a file is NOT owned by a user, either by name or UID
#
# Params:
#     $1 <-- A path
#     $2 <-- a user name | UID
assertOwnerIsNot () {
	SHU_FDIR=`dirname "$1"`
	SHU_TEMP=`find "$SHU_FDIR" -user "$2" | grep -F "$1"`
	if [ "$SHU_TEMP" = "" ]
	then
		pass
	else
		fail "Expected user not to be <$2>"
	fi
}

#Test if a file is owned by a group, either by name or GID
#
# Params:
#     $1 <-- A path
#     $2 <-- a group name | GID
assertGroupIs () {
	SHU_FDIR=`dirname "$1"`
	SHU_TEMP=`find "$SHU_FDIR" -group "$2" | grep -F "$1"`
	if [ "$SHU_TEMP" = "" ]
	then
		fail "Expected group <$2>"
	else
		pass
	fi
}

#Test if a file is owned by a group, either by name or GID
#
# Params:
#     $1 <-- A path
#     $2 <-- a group name | GID
assertGroupIsNot () {
	SHU_FDIR=`dirname "$1"`
	SHU_TEMP=`find "$SHU_FDIR" -group "$2" | grep -F "$1"`
	if [ "$SHU_TEMP" = "" ]
	then
		pass
	else
		fail "Expected group <$2>"
	fi
}

#Test if file permissions match
#
# Params:
#     $1 <-- path
#     $2 <-- permissions
assertPermissionsAre () {
	SHU_FDIR=`dirname "$1"`
	SHU_TEMP=`find "$SHU_FDIR" -perm "$2" | grep -F "$1"`
	if [ "$SHU_TEMP" = "" ]
	then
		fail "Expected permissions to match <$2>"
	else
		pass
	fi
}

#Test if file permissions don't match
#
# Params:
#     $1 <-- path
#     $2 <-- permissions
assertPermissionsAreNot () {
	SHU_FDIR=`dirname "$1"`
	SHU_TEMP=`find "$SHU_FDIR" -perm "$2" | grep -F "$1"`
	if [ "$SHU_TEMP" = "" ]
	then
		pass
	else
		fail "Expected permissions not to match <$2>"
	fi
}
