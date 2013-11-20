#!bin/bash

function testFile {
	. $1
	while read lineAndFunc
	do
		numLine=$( echo $lineAndFunc | awk '{ print $1 }' | awk 'BEGIN {FS=":"} { print $1 }' )
		testFunction=$( echo $lineAndFunc | awk '{ print $2 }' )
		previousLine=$( head -n $numLine $1 | tail -n 2 | head -n 1 )
		[ "$( type -t $testFunction )" == "function" ] && {
			[ "$( echo $previousLine | grep "^# @dataProvider " )" == "" ] && {
				setUp 2> /dev/null
				doTest $testFunction
				tearDown 2> /dev/null
			} || {
				currentTest=$testFunction
				$( echo $previousLine | awk '{print $3}' )
			}
		}
	done < <(grep -n 'function test' $1)
}

function data {
	setUp 2> /dev/null
	doTest $currentTest $@
	tearDown 2> /dev/null
}

function doTest {
	countTest
	current_test=$1
	error="no"
	$@
	if [ "$error" = "no" ]
	then
		echo -n "   "
		printColorized green "$current_test passes"
	fi
}

function printResults {
	echo
	if [ $failedAsserts = 0 ]
	then
		printColorized green "OK ($numTests tests, $numAsserts assertions)"
	else
		printColorized red "FAILURES!"
		printColorized red "Tests: $numTests, Assertions: $numAsserts, Failures: $failedAsserts."
	fi
}

