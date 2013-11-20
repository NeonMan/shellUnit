#!bin/bash

numAsserts=0
failedAsserts=0

function countAssert {
	numAsserts=`expr $numAsserts + 1`
}

function pass {
	countAssert
}

function fail {
	countAssert
	echo -n "   "
	printColorized red "$1"
	error="yes"
	failedAsserts=`expr $failedAsserts + 1`
}

