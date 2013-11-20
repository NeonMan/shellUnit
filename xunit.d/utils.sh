#!bin/bash

#Normalize path, evaluating and removing the . and .. directories
#
# Params:
#    $1 <-- a path
# Echoes:
#    The normalized path
function normalizePath {
	echo $( cd "$( dirname $1 )" && pwd )/$( basename $1 )
}
