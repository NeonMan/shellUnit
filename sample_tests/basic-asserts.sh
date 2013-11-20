#!/bin/bash

#This script will test the validity of the asserts themselves

function testEquals {
	assertEquals 2 2
	assertEquals "a" "a"
	assertEquals "a" a
	assertEquals "2" 2
}

function testNotEquals {
	assertNotEquals 1 2
	assertNotEquals "A" "B"
	assertNotEquals "3" 4
	assertNotEquals "A" Z
}

function testGreaterThan {
	assertGreaterThan 3 2
	assertGreaterThan "5" 1
}

function testNotGreaterThan {
	assertNotGreaterThan 3 5
	assertNotGreaterThan "3" 7
	assertNotGreaterThan 3 3
}

function testLessThan {
	assertLessThan 3 5
	assertLessThan "3" 5
}

function testNotLessThan {
	assertNotLessThan 5 4
	assertNotLessThan "5" 4
	assertNotLessThan 5 5
}

function testMatches {
	assertMatches "[0-9]-[A-Z]" "1234-ASDF"
}

function testNotMatches {
	assertNotMatches "[0-9]-[A-Z]" "ASDF-1234"
}
