#!/bin/bash 

op_type=${ASGN1_OP_TYPE}
myfiles=${ASGN1_FILES}
delimiters=${ASGN1_IFS}
new_ifs=" "$'\n'$'\t'
default_ifs=" "$'\n'$'\t'
count=()
IFS=${default_ifs}

function histogram {
    new_ifs=" "$'\n'$'\t'
    for de in ${delimiters};do
        new_ifs+=${de}
    done
    for file in ${myfiles[@]};do
        if [ -f ${file} ]; then
            data=$(cat ${file})
            IFS=${new_ifs}
            for str in ${data};do
                ((count[${#str}]++))
            done
            IFS=${default_ifs}
        else
            echo "File-error: ${file}!"
        fi
    done
    for i in ${!count[@]};do
        echo "${i} ${count[i]}"
    done

}

histogram
