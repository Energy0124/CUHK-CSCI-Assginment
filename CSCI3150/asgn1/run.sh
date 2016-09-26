#!/bin/bash

# variables for storing parsed arguments
op_type=
myfiles=""

# variable for storing extra delimiters, we modifying via "grader.sh" across
# test cases
delimiters=,$'\n'.

# parse argument
function argument_parser {
	count=0
	for arg in $@; do
		(( count++ ))
		# place the first argument into variable "op_type"
		if [ $count -eq 1 ]; then 
			op_type=$((arg))
		else
			# separate the files with one space
			myfiles+=" ${arg}"
		fi
	done
}

# determine the operations to run
function run_op {
	case $1 in
	1)
		bash ./histogram.sh $@;;
	2)
		bash ./phrasecount.sh $@;;
	3)
		bash ./phrasefind.sh $@;;
    *) 
        echo "Unknown operation type";;
	esac
}

function main {
    argument_parser $@
    # the parsed arguments are exported to the environment, so you may use it
    # directly
    export ASGN1_OP_TYPE="$op_type"
    export ASGN1_FILES="$myfiles"
    export ASGN1_IFS=${delimiters}
    # the orignal arguments are passed to functions, so you may parse the
    # arguments on your own as well 
	run_op $@
}

main $@
