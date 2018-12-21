#!/bin/bash

# Script for repeatedly measuring latency values to three httpd reachable on the same ip.
# the measured values are written to a CSV

# Author: Henryk Iwaniuk

IP="10.200.2.234"
repeats=1000

file="400M_combined_2.csv"


echo "" > "./$file";

for ((n=0;n<10;n++))
do
for i in "80" "6001" "6002"
do

    { time curl -I "$IP:$i"; } 2>&1 | grep real | grep -oP "[0-9].[0-9]{3}"
done
done

for ((n=0;n<$repeats;n++))
do
val=""
for i in "80" "6001" "6002"
do
    echo "$i"
    out=$({ time curl -I "$IP:$i"; } 2>&1 | grep real | grep -oP "[0-9].[0-9]{3}")
    val="$val$out   "
done
echo "$val" >> "./$file";
done
