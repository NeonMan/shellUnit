#!bin/bash

numTests=0

#Imcrements the numTests variable
#
# Params: none
function countTest {
	numTests=`expr $numTests + 1`
}
