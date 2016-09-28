#!/bin/bash

op_type=${ASGN1_OP_TYPE}
myfiles=${ASGN1_FILES}

default_ifs=" "$'\n'$'\t'
files=()
words=()
word_count=()
#char_count1=()
#char_count2=()
#char_count1[0]=0
#char_count2[0]=0
error="no"
function phrasefind {

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

    file0=${files[0]}

    count=0
    IFS=$'\n'
    while read line;do
        IFS=${default_ifs}
        echo "${line}"
        last_grep_temp=""

        for (( i=1;i<${#files[@]};i++ ));do
            file=${files[${i}]}


            words=$(cat "${file}"|grep -bno "${line}")
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
                byte_offset=${part[1]}

                nline=$(sed -n "${line_number}"p "${file}")
                offset_temp=$(echo "${nline}"|grep -bo "${line}")

    #            echo $line : $line_number : $nline
    #            echo "${offset_temp}"

                if [  "${last_grep_temp}" != "${offset_temp}" ];then

                    IFS=$'\n'
                    for t in ${offset_temp[@]};do
                        IFS=':'
                        part=()
                        a=0
                        for p in ${t[@]};do
                            part[${a}]=${p}
            #                echo line_offset: ${p}
                            ((a++))
                        done
                        line_offset=${part[0]}

            #            echo "${line_offset}"

            #            offset=$((${byte_offset}-${char_count1[$((${line_number}-1))]}))
                        echo "${file}:${line_number}:${line_offset}"
                        IFS=$'\n'
                    done
                fi
                last_grep_temp=${offset_temp}
                IFS=$'\n'
            done
        done


        IFS=${default_ifs}

        ((count++))
        IFS=$'\n'
    done < ${file0}
    IFS=${default_ifs}

}

phrasefind $@

