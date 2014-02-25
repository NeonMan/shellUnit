#!/bin/bash
# See 'COPYING' for copyright info

#Show shunit help
#
# Params:
#     $1 <-- exec name
show_usage () {
	echo "$1: [-h] [-p] [-g] [-f FORMAT|--raw] <SHU_SCRIPT|TEST_DIRECTORY>"
}

#Show long shunit help
#
# Params:
#     $1 <-- exec name
show_help () {
	echo "Usage:"
	show_usage "$1"
	echo "Execute shellUnit unit tests"
	echo ""
	echo "Mandatory arguments to long options are mandatory for short options too."
	echo ""
	echo "  -p, --preprocess  Output generated script to stdout, don't execute"
	echo "  -w, --raw         Output results as CSV, don't format"
	echo "  -f, --format=FMT  Use formateer FMT to process output"
	echo "  -g, --groups=GRP  Test the selected groups, sepparated by commas"
	echo ""
	echo "Available formateers:"
	echo "  pretty    Shows a colorized resume of the executed tests (default)"
	echo "  xml       Outputs a XML document"
	echo "  json      Outputs a JSON document"
	echo "  raw       Equivalent to the --raw option"
	echo ""
	echo "Report bugs at: https://github.com/NeonMan/shellUnit/issues"
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
		echo "shunit-out-pretty"
	elif [ $SHU_OUT_MODE = 'preprocess' ]
	then
		echo 'preprocess'
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
	#Export current file name
	export SHU_TEST_FILE="$1"
	export SHU_GROUPS="$SHU_GROUPS"

	OUT_CMD=`output_cmd`
	pushd "$PWD" >/dev/null
	cd `dirname "$1"`
	#if raw out, preprocess and pipe into the shell
	if [ "$OUT_CMD" = 'preprocess' ]
	then
		shpp "$1"
	elif [ "$OUT_CMD" = '' ]
	then
		shpp "$1" | $SHU_SHELL
	else
		shpp "$1" | $SHU_SHELL | $OUT_CMD
	fi
	#return to the calling dir
	popd >/dev/null
}

#Run all .shu files from a directory
#
# Params:
#     $1 <-- test dir
test_dir () {
	SHU_TEST_COUNT=0
	pushd "$PWD" >/dev/null
	cd "$1"
	SHU_BASE="$PWD"
	popd >/dev/null
	for e in `ls "$1"| grep -i "\.shu$"`
	do
		test_file "$SHU_BASE/$e"
		SHU_TEST_COUNT=`expr $SHU_TEST_COUNT + 1`
	done
}

#Processes and tests the .shu file
#
# Params:
#     $1 <-- test file/test dir
run_test () {
	if [ -d "$1" ]
	then
		test_dir "$1"
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
SHU_GROUPS=''
for p in $*
do
	if [  '(' "$p" = "--raw" ')' -o '(' "$p" = "-w" ')'  ]
	then
		SHU_OUT_MODE='raw'
	elif [ '(' "$p" = "--help" ')' -o '(' "$p" = "-h" ')' ]
	then
		show_help "$0"
		exit
	elif [ '(' "$p" = "--preprocess" ')' -o '(' "$p" = "-p" ')' ]
	then
		SHU_OUT_MODE='preprocess'
	elif [ '(' "`echo "$p" | awk '{print substr($0,0,10)}'`" = "--groups=" ')' -o '(' "`echo "$p" | awk '{print substr($0,0,3)}'`" = "-g" ')' ]
	then
		SHU_GROUPS=`echo "$p" | gema -p '\-\-groups\=*=$1' -p '\-g*=$1'`
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
