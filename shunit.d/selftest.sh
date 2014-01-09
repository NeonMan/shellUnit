#This file implements mock pass  and fail functions to allow self-testing
#of the framework scripts

#Load the framework bare essentials
. tests.sh
. util.sh

#A test passes
#
# Params: None
pass () {
	SHU_SELFTEST='PASS'
}

#A test fails
#
# Params:
#     $1 <-- A fail message
fail () {
	SHU_SELFTEST='FAIL'
}
