#!/bin/bash

op_type=${ASGN1_OP_TYPE}
myfiles=${ASGN1_FILES}


default_ifs=" "$'\n'$'\t'

files=()
words=()
word_count=()
error="no"
function phrasecount {

    IFS=${default_ifs}
    c=0
    for file in ${myfiles[@]};do
        if [ -f ${file} ]; then
            files[${c}]=${file}
            ((c++))
        else
            echo "File-error: ${file}!"
            error="yes"
        fi
    done

    if [ ${error} = "yes" ]
    then
        return
    fi
#    file0=${files[0]}
#    file1=${files[1]}
#    file2=${files[2]}
    data=$(cat ${files[0]})
    count=0
    IFS=$'\n'
    for line in ${data[@]};do
        IFS=${default_ifs}
        word_count[${count}]=0

        for (( i=1;i<${#files[@]};i++ ));do
            file=${files[${i}]}
#            words=$(cat "${file}"|grep -oh "${line}")
#            for word in ${words[@]};do
#                ((word_count[${count}]++))
#            done
#            echo "$file"
#            echo "$line"
            if [[ ! -z "${file}" ]];then
                words=$(cat "${file}"|grep -oh "${line}")
                for word in ${words[@]};do
                    ((word_count[${count}]++))
                done
            fi
        done
        ((count++))
        IFS=$'\n'
    done
    IFS=${default_ifs}
    for i in ${!word_count[@]};do
        echo "${word_count[i]}"
    done

}

phrasecount $@