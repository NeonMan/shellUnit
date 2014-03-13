#Test wether an array contains an item
#
# Params:
#     $1 <-- expectedItem
#     $2 <-- anArray
assertArrayContains () {
	for SHU_E in $2
	do
		if [ "$SHU_E" "=" "$1" ]
		then
			pass
			return 0
		fi
	done
	fail "Array does not contain '$1'"
}

#Test if an array does not contain an item
#
# Params:
#     $1 <-- unexpectedItem
#     $2 <-- anArray
assertArrayNotContains () {
	for SHU_E in $2
	do
		if [ "$SHU_E" "=" "$1" ]
		then
			fail "Array contains '$1'"
			return 0
		fi
	done
	pass
}

#Test array size
#
# Params:
#     $1 <-- expectedSize
#     $2 <-- anArray
assertArraySizeIs () {
	if [ `shu_array_size "$2"` '=' '$1' ]
	then
		pass
	else
		fail "Array size is not '$1'"
	fi
}

#Test is array size is not
#
# Params:
#     $1 <-- unexpectedSize
#     $2 <-- anArray
assertArraySizeIsNot () {
        if [ `shu_array_size "$2"` '=' '$1' ]
        then
                fail "Array size is '$1'"
        else
                pass
        fi
}
