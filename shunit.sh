#!/bin/bash

#Show shunit help
#
# Params:
#     $1 <-- exec name
show_usage () {
	echo "$1: [-raw] [SHU_SCRIPT|TEST_DIRECTORY]"
}

#Returns the command to pipe-into the script results
#
# Params: None
# Env:
#     SHU_OUT_MODE <-- Selects the output mode
# Echoes:
#     The command to pass the script output
output_cmd () {
	if [ $SHU_OUT_MODE = 'raw' ]
	then
		echo ""
	elif [ $SHU_OUT_MODE = 'pretty' ]
	then
		echo "shunit-pretty"
	else
		echo ""
	fi
}


#Processes and tests the .shu file
#
# Params:
#     $1 <-- test file
# Env:
#     SHU_SHELL
test_file () {
	OUT_CMD=`output_cmd`
	pushd "$PWD" >/dev/null
	cd `dirname "$1"`
	#if raw out, preprocess and pipe into the shell
	if [ "$OUT_CMD" = '' ]
	then
		shpp "$1" | $SHU_SHELL
	else
		shpp "$1" | $SHU_SHELL | $OUT_CMD
	fi
	#return to the calling dir
	popd >/dev/null
}

#Processes and tests the .shu file
#
# Params:
#     $1 <-- test file/test dir
run_test () {
	if [ -d "$1" ]
	then
		echo "Directory unsupported yet"
	elif [ -f "$1" ]
	then
		test_file "$1"
	else
		echo "<$1> not a file or directory"
	fi
}

#Parse cli options
SHU_OUT_MODE='pretty'
SHU_TARGET=''
SHU_SHELL="/bin/bash"
for p in $*
do
	if [ "$p" = "--raw" ]
	then
		SHU_OUT_MODE='raw'
	elif [ '(' "$p" = "--help" ')' -o '(' "$p" = "-h" ')' ]
	then
		show_usage "$0"
		exit
	else
		SHU_TARGET="$p"
	fi
done

if [ "$SHU_TARGET" != "" ]
then
	run_test "$SHU_TARGET"
else
	show_usage "$0"
fi