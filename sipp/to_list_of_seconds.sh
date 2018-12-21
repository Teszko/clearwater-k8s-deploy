#!/bin/bash

# Script for translating sipp shortmsg traces to plottable files.
# Author: Henryk Iwaniuk

file="postscale_sipp_register_basic_28018_shortmessages.log"
outfile="scaled_register.log"
marker1="SIP/2.0 200"
marker2="SIP/2.0 5"


norm_val=$(cat "$file" | grep -P "SIP/2.0" | grep -Po "20[0-9]{2}-[0-9]{2}-[0-9]{2}\s[0-9]{2}:[0-9]{2}:[0-9]{2}" | xargs -I {} date -d {} +%s | head -n 1)


list1=$(cat "$file" | grep -P "$marker1" | grep -Po "20[0-9]{2}-[0-9]{2}-[0-9]{2}\s[0-9]{2}:[0-9]{2}:[0-9]{2}" | xargs -I {} date -d {} +%s)


list2=$(cat "$file" | grep -P "$marker2" | grep -Po "20[0-9]{2}-[0-9]{2}-[0-9]{2}\s[0-9]{2}:[0-9]{2}:[0-9]{2}" | xargs -I {} date -d {} +%s)

norm_list=""

while read p; do
    nval="$(($p - $norm_val))"
    if [ ! -z "$nval" ]; then
        norm_list="$norm_list$nval"$'\n';
    fi
#    echo $nval
done <<< "$list1"

echo "$norm_list" > "1_$outfile";

cat "1_$outfile" | head -n -1 | uniq -c | awk ' { t = $1; $1 = $2; $2 = t; print; } ' > "1_uniq_$outfile"


norm_list2=""

while read p; do
    nval="$(($p - $norm_val))"
    if [ ! -z "$nval" ]; then
        norm_list2="$norm_list2$nval"$'\n';
    fi
done <<< "$list2"

echo "$norm_list2" > "2_$outfile";

cat "2_$outfile" | head -n -1 | uniq -c | awk ' { t = $1; $1 = $2; $2 = t; print; } ' > "2_uniq_$outfile"


echo "" > "$outfile"
for i in `seq 1 180`;
do
    val1=$(cat "1_uniq_$outfile" | grep -P "^$i [0-9]*" | grep -Po " [0-9]*")
    if [ -z "$val1" ]; then val1=0; fi
    val2=$(cat "2_uniq_$outfile" | grep -P "^$i [0-9]*" | grep -Po " [0-9]*")
    if [ -z "$val2" ]; then val2=0; fi
    echo "$i $val2 $val1" >> "$outfile"
done  

rm "1_uniq_$outfile";
rm "2_uniq_$outfile";
rm "1_$outfile";
rm "2_$outfile";
