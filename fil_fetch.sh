#!/bin/bash

# 31 May, 2018 - da0017@mix.wvu.edu

# this script makes the dir str for all the incoming files

basedir='/20m/GBTrans'
workdir='/20m/GBTrans/triggers'

for folder in $(cat dir_list)
do
    for each_trigger in $(ls -1d ${basedir}/${folder}/out*)
    do
        trigger_name=$(echo $each_trigger | cut -d / -f 5)
        mkdir -p ${workdir}/${trigger_name}
        ln -s ${each_trigger}/*.fil ${workdir}/${trigger_name}/.
    done 
done
