#!/bin/bash

# May 31, 2018 - da0017@mix.wvu.edu
# June 04,2017 - da0017@mix.wvu.edu : fixed fof -t 8 to -t 256

if [ "$HOSTNAME" != "notebook.mushroomkingdom" ]
then
    echo "Run this from notebook"
    exit 1
fi

workdir='/20m/GBTrans/triggers'
scrdir='/hyrule/data/users/dagarwal/FLAG/frb_scr'

for each_trigger in $(ls -1d ${workdir}/*)
do
    cd $each_trigger
    fil_file=$(ls -1 *.fil)
    trigger_name=$(echo $each_trigger | cut -d / -f 5)
    echo $trigger_name
    rm -rf ${trigger_name}.cand
    if [ ! -f ${trigger_name}.cand ]; then
        pwd
        rm -rf *.cand
        #heimdall -f $fil_file -dm 2 10000 -detect_thresh 10.0 -dm_tol 1.5 -boxcar_max 256
        cat 2*cand > ${trigger_name}.cands
        echo "preparing for fof'ing cands"
        ${scrdir}/h2f.sh  ${trigger_name}.cands > ${trigger_name}.cand
        rm -rf *.cands
        echo "fof'em"
        ${scrdir}/fof.py ${trigger_name}.cand -t 256 -d 45
    else
       echo "cand file exists, skipping" 
    fi
    cd -
   
done
