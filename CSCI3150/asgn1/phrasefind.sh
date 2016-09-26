#!/bin/bash

op_type=${ASGN1_OP_TYPE}
myfiles=${ASGN1_FILES}

default_ifs=" "$'\n'$'\t'
files=()
words=()
word_count=()
char_count1=()
char_count2=()
char_count1[0]=0
char_count2[0]=0

function phrasefind {


    IFS=${default_ifs}
    c=0
    for file in ${myfiles[@]};do
        files[${c}]=${file}
        ((c++))
    done
    file0=${files[0]}
    file1=${files[1]}
    file2=${files[2]}
#    data=$(cat ${file0})



    counter=0
    pcounter=-1
    while read line; do
        (( counter ++ ))
        (( pcounter ++ ))
        chars=$(echo "${line}" | wc -c)
        char_count1[${counter}]=$((${char_count1[${pcounter}]}+${chars}))
#        echo "line:${counter}, chars: ${chars}, c_chars: ${char_count1[${counter}]}"
    done < "${file1}"

    if [[ ! -z "${file2}" ]];then
        counter=0
        pcounter=-1
        while read line; do
            (( counter ++ ))
            (( pcounter ++ ))
            chars=$(echo  "${line}" | wc -c)
            char_count2[${counter}]=$((${char_count2[${pcounter}]}+${chars}))
    #        echo "line:${counter}, chars: ${chars}, c_chars: ${char_count2[${counter}]}"
        done < "${file2}"
    fi

    count=0
    IFS=$'\n'
    while read line;do
        IFS=${default_ifs}
        echo "${line}"
        word_count[${count}]=0
        words=$(cat "${file1}"|grep -bno "${line}")
#        echo ${words}
        IFS=$'\n'
        for word in ${words[@]};do
            IFS=':'
            line_number=0
            offset=0
            part=()
            a=0
            for p in ${word[@]};do
                part[${a}]=${p}
                ((a++))
            done
            line_number=${part[0]}
            offset=$((${part[1]}-${char_count1[$((${line_number}-1))]}))
            echo "${file1}:${line_number}:${offset}"
            IFS=$'\n'
        done
        IFS=${default_ifs}
        if [[ ! -z "${file2}" ]];then
            words=$(cat "${file2}"|grep -bno "${line}")
            IFS=$'\n'
            for word in ${words[@]};do
                IFS=':'
                line_number=0
                offset=0
                part=()
                a=0
                for p in ${word[@]};do
                    part[${a}]=${p}
                    ((a++))
                done
                line_number=${part[0]}
                offset=$((${part[1]}-${char_count2[$((${line_number}-1))]}))
                echo "${file2}:${line_number}:${offset}"
                IFS=$'\n'
            done
            IFS=${default_ifs}
        fi
        ((count++))
        IFS=$'\n'
    done < ${file0}
    IFS=${default_ifs}
#    for i in ${!word_count[@]};do
#        echo "${word_count[i]}"
#    done
}

phrasefind $@

