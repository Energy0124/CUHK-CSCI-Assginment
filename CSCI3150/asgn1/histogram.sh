#!/bin/bash 

op_type=${ASGN1_OP_TYPE}
myfiles=${ASGN1_FILES}
delimiters=${ASGN1_IFS}
count=()

function histogram {

    for file in ${myfiles[@]};do
        if [ -f ${file} ]; then
            data=$(cat ${file})
            for str in ${data};do
                IFS=${delimiters}
                ((count[${#str}]++))
                IFS=" "$'\n'$'\t'
            done
        else
            echo "File-error: ${file}!"
        fi
    done
    for i in ${!count[@]};do
        echo "${i} ${count[i]}"
    done

}

histogram
