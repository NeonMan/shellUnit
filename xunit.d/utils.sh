#!bin/bash

function normalizePath {
	echo $( cd "$( dirname $1 )" && pwd )/$( basename $1 )
}
