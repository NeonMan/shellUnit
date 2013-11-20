#!bin/bash

function testDir {
	while read file
	do
		printColorized yellow "$file:"
		testFile $1/$file
	done < <(ls -l $1 | awk '{ print $NF }' | grep ".sh$")
}
