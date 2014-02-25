# This function runs the needed tests
#
# Params:
#    $1 <-- The test functions
# Environment:
#    SHU_GROUPS <-- A ',' separated list of groups, or an empty string for all
shu_dispatcher () {
	if [ "$SHU_GROUPS" = "" ]
	then
		eval "$1"
	else
		echo "FIXME!"
		echo "groups: $SHU_GROUPS"
		echo "functions: $1"
	fi
}
