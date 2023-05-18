#!/bin/bash

cd ..
export WD=$PWD
module load r/gcc/4.1.0
cd $WD/scripts
mkdir -p $WD/results/

Rscript $WD/scripts/summarize_variation.r $1 $2 $3 $4