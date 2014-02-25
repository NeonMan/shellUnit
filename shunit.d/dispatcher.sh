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
		#get the function groups
		SHU_REGEXP=`echo "$SHU_GROUPS" | gema -p '\#*\n=$1' | sed 's/\,/\\\\|/'`
		SHU_FILTERED=`echo "$1" | grep "\#.*$SHU_REGEXP.*$"`
		eval "$SHU_FILTERED"
	fi
}
