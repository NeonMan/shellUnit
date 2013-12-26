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
	SHU_USER=""
	if [[ "$2" =~ [0-9][0-9]* ]]
	then
		SHU_USER=`shu_userName "$2"`
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
		SHU_USER=`shu_userName "$2"`
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

#Test if a file is owned by a group, either by name or GID
#
# Params:
#     $1 <-- A path
#     $2 <-- a group name | GID
assertGroupIs () {
	SHU_GROUP=""
	if [[ "$2" =~ [0-9][0-9]* ]]
	then
		SHU_GROUP=`shu_userGroup "$2"`
	else
		SHU_GROUP="$2"
	fi
	SHU_FGRP=`shu_fileGroup "$1"`

	if [ "$SHU_FOWNER" = "$SHU_USER" ]
	then
		pass
	else
		fail "Expected group <$SHU_USER> but found <$SHU_FOWNER>"
	fi
}

#Test if a file is owned by a group, either by name or GID
#
# Params:
#     $1 <-- A path
#     $2 <-- a group name | GID
assertGroupIsNot () {
	SHU_GROUP=""
	if [[ "$2" =~ [0-9][0-9]* ]]
	then
		SHU_GROUP=`shu_userGroup "$2"`
	else
		SHU_GROUP="$2"
	fi
	SHU_FGRP=`shu_fileGroup "$1"`

	if [ "$SHU_FOWNER" = "$SHU_USER" ]
	then
		fail "Expected group not to be <$SHU_USER>"
	else
		pass
	fi
}

#Test if file permissions match
#
# Params:
#     $1 <-- path
#     $2 <-- permissions
assertPermissionsAre () {
	#Check permissions format, either a number, 10-character code, prefix-operand-[rwx] (ToDo)
	#Numeric permissions
	if [[ "$2" =~ ^[0-7][0-7][0-7][0-7]? ]]
	then
		#Get permissions in numeric format
		SHV_PERM=`stat --format="%a"  "$1"`
		if [ "$SHV_PERM" -eq "$1" ]
		then
			pass
		else
			fail "Permissions are <$SHV_PERM> expected <$1>"
		fi
		return
	fi
	
	#Ten-char permissions
	if [[ "$2" =~ ^[d-][r-][w-][x-][r-][w-][x-][r-][w-][x-] ]]
	then
		SHV_PERM=`stat --format="%A"  "$1"`
		if [ "$SHV_PERM" -eq "$1" ]
		then
			pass
		else
			fail "Permissions are <$SHV_PERM> expected <$1>"
		fi
		return
	fi

	#fail case
	fail "Incorrect permission format"
}

#Test if file permissions don't match
#
# Params:
#     $1 <-- path
#     $2 <-- permissions
assertPermissionsAreNot () {
	#Check permissions format, either a number, 10-character code, prefix-operand-[rwx] (ToDo)
	SHV_PERMISSIONS=""
	
	#Numeric permissions
	if [[ "$2" =~ ^[0-7][0-7][0-7][0-7]? ]]
	then
		#Get permissions in numeric format
		SHV_PERM=`stat --format="%a"  "$1"`
		if [ "$SHV_PERM" -eq "$1" ]
		then
			fail "Permissions are <$SHV_PERM> expected <$1>"
		else
			pass
		fi
		return
	fi
	
	#Ten-char permissions
	if [[ "$2" =~ ^[d-][r-][w-][x-][r-][w-][x-][r-][w-][x-] ]]
	then
		SHV_PERM=`stat --format="%A"  "$1"`
		if [ "$SHV_PERM" -eq "$1" ]
		then
			fail "Permissions are <$SHV_PERM> expected <$1>"
		else
			pass
		fi
		return
	fi

	#fail case
	fail "Incorrect permission format"
}
