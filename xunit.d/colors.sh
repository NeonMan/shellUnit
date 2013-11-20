#!bin/bash

#Shortcut to the ANSI scape for green color
function green {
	echo "37;42"
}

#Shortcut to the ANSI scape for red color
function red {
	echo "37;41"
}

#Shortcut to the ANSI scape for yellow color
function yellow {
	echo "33;40"
}

#Print a string, colorized
#
# Params:
#    $1 <-- A colour pair in the form [FOREGROUND];[BACKGROUND]
#    $2 <-- A string
function printColorized {
	echo -en '\E['`$1`'m'"\033[1m"
	echo -en $2
	echo -e "\033[0m";
	tput sgr0
}
