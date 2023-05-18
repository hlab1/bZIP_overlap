#!/bin/bash

cd ..
export WD=$PWD
module load r/gcc/4.1.0
mkdir -p $WD/resources/processed_syri

Rscript $WD/scripts/process_syri.r $WD/resources/syri/ $WD/resources/processed_syri/
