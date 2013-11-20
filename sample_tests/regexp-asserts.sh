#!/bin/bash

function testMatches {
	assertMatches ".*" "aaa"
	assertMatches "abc" "abc"
	assertMatches "a[bc]" "ab"
	assertMatches "a[bc]" "ac"
}
