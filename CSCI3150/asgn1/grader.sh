#!/bin/bash

##############################################################################
# Test cases

INPUT_DIR=./testcases/data
OUTPUT_DIR=./output
ANS_DIR=./testcases/expected

tests=("0" "1a" "1b" "1c" "2a" "2b" "2c" "3a" "3b" "3c")

function use_only_default_delimiters {
	# leave extra delimiter set empty, i.e. no extra delimiters
    # by modifying the variable "delimiters" in run.sh
	sed -i "s/\(delimiters=\).*/\1/g" run.sh
}

function use_extra_delimiters {
	# add comma (,) and full-stop (.) as extra delimiters
    # by modifying the variable "delimiters" in run.sh
	sed -i "s/\(delimiters=\).*/\1,\$\'\\\n\'./g" run.sh
}

#
# Check if all file exist and are regular
#
# Input:
#  - operation type = 1
#  - files: non_exists, haha
# Process:
#  - check if all files exists and are regular
# Expected: 
#  - detect that both non_exists and haha do not exist
#  - report error
#
function testcase0 {
    ./run.sh 1 non_exists haha > ${OUTPUT_DIR}/$1.txt
}

#
# Build a word length histogram for a single file
#
# Input:
#  - operation type = 1
#  - files: ${INPUT_DIR}/data1.txt
# Process:
#  - go through ${INPUT_DIR}/data1.txt and build a histogram
# Expected: 
#  - output the histogram, as a list of "<word length> <count>", ordered by
#  word length
#
function testcase1a {
    use_only_default_delimiters
    ./run.sh 1 ${INPUT_DIR}/data1.txt > ${OUTPUT_DIR}/$1.txt
    # restore the delimiters for example on operation 1 in specification
    use_extra_delimiters
}

#
# Build a word length histogram for multiple files
#
# Input:
#  - operation type = 1
#  - files: ${INPUT_DIR}/data1.txt, ${INPUT_DIR}/data2.txt
# Process:
#  - go through ${INPUT_DIR}/data1.txt and ${INPUT_DIR}/data2.txt to build a
#    histogram
# Expected: 
#  - output the histogram, as a list of "<word length> <count>", ordered by
#    word length
#
function testcase1b {
	# no additional delimiters
    use_only_default_delimiters
    ./run.sh 1 ${INPUT_DIR}/data1.txt ${INPUT_DIR}/data2.txt > ${OUTPUT_DIR}/$1.txt
    # restore the delimiters for example on operation 1 in specification
    use_extra_delimiters
}

#
# Build a word length histogram for multiple files, with extra delimiters
# specified
#
# Input:
#  - operation type = 1
#  - files: ${INPUT_DIR}/data1.txt, ${INPUT_DIR}/data2.txt
# Process:
#  - account for extra delimiters, full-stop (.) and comma (,)
#  - go through ${INPUT_DIR}/data1.txt and ${INPUT_DIR}/data2.txt to build a
#    histogram
# Expected: 
#  - output the histogram, as a list of "<word length> <count>", ordered by
#    word length
#
function testcase1c {
	# add extra delimiters
    use_extra_delimiters
    ./run.sh 1 ${INPUT_DIR}/data1.txt ${INPUT_DIR}/data2.txt > ${OUTPUT_DIR}/$1.txt
    # restore the delimiters for example on operation 1 in specification
    use_extra_delimiters
}

#
# Count single phrase appearance in a single file
#
# Input:
#  - operation type = 2
#  - files: ${INPUT_DIR}/phrase1.txt, ${INPUT_DIR}/data3.txt
# Process:
#  - look into ${INPUT_DIR}/phrase1.txt for the phrase to count
#  - go through ${INPUT_DIR}/data3.txt and count the appearance of the phrase
# Expected: 
#  - output the count for the phrase
#
function testcase2a {
    ./run.sh 2 ${INPUT_DIR}/phrase1.txt ${INPUT_DIR}/data3.txt > ${OUTPUT_DIR}/$1.txt
}

#
# Count multiple phrase appearance in a single file
#
# Input:
#  - operation type = 2
#  - files: ${INPUT_DIR}/phrase2.txt, ${INPUT_DIR}/data3.txt
# Process:
#  - go through ${INPUT_DIR}/phrase2.txt for phrases to count
#  - go through ${INPUT_DIR}/data3.txt and count the appearance of phrases
# Expected: 
#  - output the count of each phrase, in the order which the phrases appear in
#    ${INPUT_DIR}/phrase2.txt
#
function testcase2b {
    ./run.sh 2 ${INPUT_DIR}/phrase2.txt ${INPUT_DIR}/data3.txt > ${OUTPUT_DIR}/$1.txt
}

#
# Count multiple phrase appearance in multiple files
#
# Input:
#  - operation type = 2
#  - files: ${INPUT_DIR}/phrase3.txt, ${INPUT_DIR}/data3.txt, ${INPUT_DIR}/data4.txt
# Process:
#  - go through ${INPUT_DIR}/phrase3.txt for phrases to count
#  - go through ${INPUT_DIR}/data3.txt and ${INPUT_DIR}/data4.txt count the appearance of phrases
# Expected: 
#  - output the count of each phrase, in the order which the phrases appear in
#    ${INPUT_DIR}/phrase3.txt
#
function testcase2c {
    ./run.sh 2 ${INPUT_DIR}/phrase3.txt ${INPUT_DIR}/data3.txt ${INPUT_DIR}/data4.txt > ${OUTPUT_DIR}/$1.txt
}

#
# Locate single phrases in a single file
#
# Input:
#  - operation type = 3
#  - files: ${INPUT_DIR}/phrase1.txt, ${INPUT_DIR}/data3.txt
# Process:
#  - look into ${INPUT_DIR}/phrase1.txt for the phrase to locate
#  - go through ${INPUT_DIR}/data3.txt and locate the appearance of the phrase
# Expected: 
#  - output the locations of the phrase, in the order of
#    + line number 
#    + position in the line 
#
function testcase3a {
    ./run.sh 3 ${INPUT_DIR}/phrase1.txt ${INPUT_DIR}/data3.txt > ${OUTPUT_DIR}/$1.txt
}

#
# Locate multiple phrases in a single file
#
# Input:
#  - operation type = 3
#  - files: ${INPUT_DIR}/phrase2.txt, ${INPUT_DIR}/data3.txt
# Process:
#  - go through ${INPUT_DIR}/phrase2.txt for phrases to locate
#  - go through ${INPUT_DIR}/data3.txt and locate the appearance of phrases
# Expected: 
#  - output the location of each phrase, in the order of
#    + phrases appear in ${INPUT_DIR}/phrase2.txt
#    + line number 
#    + position in the line 
#
function testcase3b {
    ./run.sh 3 ${INPUT_DIR}/phrase2.txt ${INPUT_DIR}/data3.txt > ${OUTPUT_DIR}/$1.txt
}

#
# Locate multiple phrases in multiple files
#
# Input:
#  - operation type = 3
#  - files: ${INPUT_DIR}/phrase3.txt, ${INPUT_DIR}/data3.txt, ${INPUT_DIR}/data4.txt
# Process:
#  - go through ${INPUT_DIR}/phrase3.txt for phrases to locate 
#  - go through ${INPUT_DIR}/data3.txt and ${INPUT_DIR}/data4.txt locate the appearance of phrases
# Expected: 
#  - output the location of each phrase, in the order of
#    + phrases appear in ${INPUT_DIR}/phrase3.txt
#    + files appear as input arguments 
#    + line number 
#    + position in the line 
#
function testcase3c {
    ./run.sh 3 ${INPUT_DIR}/phrase3.txt ${INPUT_DIR}/data3.txt ${INPUT_DIR}/data4.txt > ${OUTPUT_DIR}/$1.txt
}

##############################################################################
# Reporting results

# have fun with colors and styles :) 
# ref: http://misc.flogisoft.com/bash/tip_colors_and_formatting

BD="\033[1m"
BDED="\033[21m"
RED="\033[31m"
GREEN="\033[92m"
ED="\e[0m"
diff_flags="-Z -b -B"

function main {
	if [ ! -d ${OUTPUT_DIR} ]; then
		mkdir -p ${OUTPUT_DIR} || { echo -e "${BD}${RED}Cannot create output directory \"${OUTPUT_DIR}\"${ED}"; exit -1; }
	fi

    rm -rf ${OUTPUT_DIR}/*

	total=${#tests[@]}
	pass=0

	for i in ${tests[@]}; do
		testcase${i} ${i}
		diff ${diff_flags} ${OUTPUT_DIR}/${i}.txt ${ANS_DIR}/${i}.txt \
1>/dev/null 2>/dev/null || { echo -e "${BD}${RED}""Failed case ${i} \
(left: your answer, right: correct answer)${ED}" \
&& diff -y ${diff_flags} ${OUTPUT_DIR}/${i}.txt ${ANS_DIR}/${i}.txt; } && { \
(( pass ++ )); }
	done

	echo -e "${GREEN}""[Result] ${pass}/${total} test cases passed${ED}"
}


main
