#Tests if param 1 (string) matches the param 2 regexp
#
# Params:
#    $1 <-- A regular expression
#    $2 <-- A string
assertMatches () {
        if [[ "$2" =~ $1 ]]
        then
                pass
        else
                fail "expected '$2' to match regular expression '$1'"
        fi
}

#Tests if param 1 (string) does not match the param 2 regexp
#
# Params:
#    $1 <-- A string
#    $2 <-- A regular expression
assertNotMatches () {
        if [[ "$2" =~ $1 ]]
        then
                fail "expected '$2' to NOT match regular expression '$1'"
        else
                pass
        fi
}

#Test if a string is contained onto another
#
# Params:
#     $1 <-- A string
#     $2 <-- A substring
assertStringContains () {
	if [[ "$1" == *"$2"* ]]
	then
		pass
	else
		fail "'$1' does not contain '$2'"
	fi
}

#Test if a string is contained onto another
#
# Params:
#     $1 <-- A string
#     $2 <-- A substring
assertStringNotContains () {
	if [[ "$1" == *"$2"* ]]
	then
		fail "'$1' contais '$2'"
	else
		pass
	fi
}

#Test equality of two strings, ignoring case
#
# Params:
#     $1 <-- String
#     $2 <-- String
assertEqualsIgnoringCase () {
	#Convert parameters to lower case
	SHU_TMPSTR1=`echo "$1" | tr '[:upper:]' '[:lower:]'`
	SHU_TMPSTR2=`echo "$2" | tr '[:upper:]' '[:lower:]'`
	#Test equality
	if [ "$SHU_TMPSTR1" == "$SHU_TMPSTR2" ]
	then
		pass
	else
		fail "'$SHU_TMPSTR1'('$1') does not equal '$SHU_TMPSTR2'('$2')"
	fi
}

#Test inequality of two strings, ignoring case
#
# Params:
#     $1 <-- String
#     $2 <-- String
assertNotEqualsIgnoringCase () {
	#Convert parameters to lower case
	SHU_TMPSTR1=`echo "$1" | tr '[:upper:]' '[:lower:]'`
	SHU_TMPSTR2=`echo "$2" | tr '[:upper:]' '[:lower:]'`
	#Test equality
	if [ "$SHU_TMPSTR1" == "$SHU_TMPSTR2" ]
	then
		fail "'$SHU_TMPSTR1'('$1') equals '$SHU_TMPSTR2'('$2')"
	else
		pass
	fi
}

#Test if two strings are equal ignoring whitespace
#
# Params:
#     $1 <-- String
#     $2 <-- String
assertEqualsIgnoringWhitespace () {
	#Remove whitespace (both vertical and horizontal)
	SHU_TMPSTR1=`echo "$1" | tr -d '[:space:]'`
	SHU_TMPSTR2=`echo "$2" | tr -d '[:space:]'`
	#Test equality
	#Test equality
	if [ "$SHU_TMPSTR1" == "$SHU_TMPSTR2" ]
	then
		pass
	else
		fail "'$SHU_TMPSTR1'('$1') does not equal '$SHU_TMPSTR2'('$2')"
	fi
}

#Test if two strings are not equal ignoring whitespace
#
# Params:
#     $1 <-- String
#     $2 <-- String
assertNotEqualsIgnoringWhitespace () {
	#Remove whitespace (both vertical and horizontal)
	SHU_TMPSTR1=`echo "$1" | tr -d '[:space:]'`
	SHU_TMPSTR2=`echo "$2" | tr -d '[:space:]'`
	#Test equality
	#Test equality
	if [ "$SHU_TMPSTR1" == "$SHU_TMPSTR2" ]
	then
		fail "'$SHU_TMPSTR1'('$1') equals '$SHU_TMPSTR2'('$2')"
	else
		pass
	fi
}

#Test is a strings starts with another
#
# Params:
#     $1 <-- String
#     $2 <-- Expected prefix
assertStringStartsWith () {
	if [[ "$1" == "$2"* ]]
	then
		pass
	else
		fail "'$1' does not start with '$2'"
	fi
}

#Test is a strings does not start with another
#
# Params:
#     $1 <-- String
#     $2 <-- Expected prefix
assertStringNotStartsWith () {
	if [[ "$1" == "$2"* ]]
	then
		fail "'$1' starts with '$2'"
	else
		pass
	fi
}

#Test is a strings ends with another
#
# Params:
#     $1 <-- String
#     $2 <-- Expected suffix
assertStringStartsWith () {
	if [[ "$1" == *"$2" ]]
	then
		pass
	else
		fail "'$1' does not end with '$2'"
	fi
}

#Test is a strings does not start with another
#
# Params:
#     $1 <-- String
#     $2 <-- Expected suffix
assertStringNotStartsWith () {
	if [[ "$1" == *"$2" ]]
	then
		fail "'$1' ends with '$2'"
	else
		pass
	fi
}
