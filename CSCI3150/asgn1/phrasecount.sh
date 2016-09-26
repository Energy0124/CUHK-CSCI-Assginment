#!/bin/bash

op_type=${ASGN1_OP_TYPE}
myfiles=${ASGN1_FILES}


default_ifs=" "$'\n'$'\t'

files=()
words=()
word_count=()
function phrasecount {

    IFS=${default_ifs}
    c=0
    for file in ${myfiles[@]};do
        files[${c}]=${file}
        ((c++))
    done
    file0=${files[0]}
    file1=${files[1]}
    file2=${files[2]}
    data=$(cat ${file0})
    count=0
    IFS=$'\n'
    for line in ${data[@]};do
        IFS=${default_ifs}
        word_count[${count}]=0
        words=$(cat "${file1}"|grep -oh "${line}")
        for word in ${words[@]};do
            ((word_count[${count}]++))
        done
        if [[ ! -z "${file2}" ]];then
            words=$(cat "${file2}"|grep -oh "${line}")
            for word in ${words[@]};do
                ((word_count[${count}]++))
            done
        fi
        ((count++))
        IFS=$'\n'
    done
    IFS=${default_ifs}
    for i in ${!word_count[@]};do
        echo "${word_count[i]}"
    done

}

phrasecount $@