#Normalize path, evaluating and removing the . and .. directories
#
# Params:
#    $1 <-- a path
# Echoes:
#    The normalized path
normalizePath () {
	echo $1 #$( cd "$( dirname $1 )" && pwd )/$( basename $1 )
}

#Return a file owner
#
# Params:
#     $1 <-- A path
# Echoes:
#     File's owner
shu_fileOwner () {
	SHU_FOWNER=`ls -lash "$1" | awk '{print $3}'`
	echo "$SHU_FOWNER"
}

#Return a file group
#
# Params:
#     $1 <-- A path
# Echoes:
#     File's group
shu_fileGroup () {
        SHU_FGROUP=`ls -lash "$1" | awk '{print $4}'`
        echo "$SHU_FGROUP"
}

#Return the user ID from its name
#
# Params:
#     $1 <-- a user name
# Echoes:
#     The user ID, empty if not found
shu_userId () {
	SHU_UID=`getent passwd "$1" | awk 'BEGIN { FS = ":" }; {print $3}'`
	echo "$SHU_UID"
}

#Returns the user name from its UID
#
# Params:
#     $1 <-- A user ID (UID)
# Echoes:
#     The user name
shu_userName () {
        SHU_UNAME=`getent passwd "$1" | awk 'BEGIN { FS = ":" }; {print $1}'`
        echo "$SHU_UNAME"
}

#Return the group id from its name
#
# Params:
#     $1 <-- a group name
# Echoes:
#     The group id
shu_groupId () {
	SHU_GID=`getent group "$1" | awk 'BEGIN { FS = ":" }; {print $3}'`
	echo "$SHU_GID"
}

#Return the group name from its GID
#
# Params:
#     $1 <-- a group id (GID)
# Echoes:
#     The group name
shu_groupName () {
	SHU_GNAME=`getent group "$1" | awk 'BEGIN { FS = ":" }; {print $1}'`
	echo "$SHU_GNAME"
}
