#!/bin/bash

# June 01, 2018 - da0017@mix.wvu.edu
# June 04, 2018 - da0017@mix.wvu.edu : don't plot crab



basedir='/20m/GBTrans/triggers'
srcdir='/20m/GBTrans/GBTranspipe'

for each_folder in $(ls -1d ${basedir}/out*)
do
	if [ -f ${each_folder}/*.fof ]; then
		cd ${each_folder}
		fof_file=$(ls -1 *.fof)
		fil_file=$(ls -1 *.fil)
		ncand=$(cat ${fof_file} | grep -v "#" | wc -l)
		echo ${each_folder} $ncand
		if [ "$ncand" -lt "50" ]
		then
			while read cand
			do
				dm=$(echo $cand | awk '{print $6}')
				sn=$(echo $cand | awk '{print $1}')
				st=$(echo $cand | awk '{print $3}')
				rm -rf dm_55_58
				echo $dm
				if [ ` echo "$dm < 58 &&  $dm > 55" | bc -l` -eq 0 ]
				then
					${srcdir}/cand_maker.sh $fil_file $cand
				else
					touch dm_55_58
					echo "touched dm_55_58"
				fi
			done < <(cat ${fof_file} | grep -v "#")
		else
			touch to_be_yapped
			echo "touched to_be_yapped"
		fi
		cd -
	fi
done
