#!/bin/bash

cd ..
export WD=$PWD
module load r/gcc/4.1.0
cd $WD/scripts
mkdir -p $2

Rscript $WD/scripts/split_motif.r $1 $2