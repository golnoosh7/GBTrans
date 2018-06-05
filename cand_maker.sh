#!/bin/bash

# June 01, 2018 - da0017@mix.wvu.edu : first commit
# June 04, 2018 - da0017@mix.wvu.edu : don't exceed the lenght of tile


inname=$1
snr=$2
s_time=$4
DM=$7
outname=${DM}_${snr}_${s_time}

echo ${outname}

tsamp=0.000131
bin=`python -c "print int(2*8.3e3*${DM}*336.0*(1465.0**(-3))/${tsamp})+1"`
#bin=1024
length=`python -c  "print $tsamp * $bin"`
offset=`python -c "print $length/2.0"`

timeoff=`python -c "print float($s_time) - float($tsamp * $bin/2.0)"`

#echo "this"
#echo "($length + $timeoff) > 13.1"
#echo "that"

if [ `echo "($length + $timeoff) > 13.1" | bc -l` -eq 1 ]
then
	length=$(echo "13.1 - $timeoff" | bc -l)
fi


dspsr -c $length -S $timeoff -cepoch=start -T $length -b $bin -D $DM -O $outname $inname

psrplot -jDT -pfreq+ ${outname}.ar -D /PNG
mv pgplot.png $outname.png
