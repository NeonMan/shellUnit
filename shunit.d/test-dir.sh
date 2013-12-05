testDir () {
	while read file
	do
		printColorized yellow "$file:"
		testFile $1/$file
	#@bug this line is not SH compatible
	done < <(ls -l $1 | awk '{ print $NF }' | grep ".sh$")
}
