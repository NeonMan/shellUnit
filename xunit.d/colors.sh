#!bin/bash

function green {
	echo "37;42"
}

function red {
	echo "37;41"
}

function yellow {
	echo "33;40"
}

function printColorized {
	echo -en '\E['`$1`'m'"\033[1m"
	echo -en $2
	echo -e "\033[0m";
	tput sgr0
}
