#!/bin/bash

cd ..
export WD=$PWD
cd $WD/scripts
module load bedtools/intel/2.29.2

mkdir -p $3
sed -i 's/\r$//' $1

while IFS=$'\t' read peak TF; do
	for syri in $2/*syri.out.bed; do
		out=$3$TF\_$(echo $syri | sed -e 's/^.*\///' -e 's/\..*//').overlap.out
		bedtools intersect \
			-a $peak \
			-b $syri \
			-wao > $out
		echo $out
	done
done < $1

