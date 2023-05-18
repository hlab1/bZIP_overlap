#!/bin/bash

cd ..
export WD=$PWD

for file in $(ls /scratch/cgsb/huang/dap/analysis.v4/dap_data_v4/peaks/bZIP_tnt/*/chr1-5/chr1-5_GEM_events.narrowPeak | grep -v amp); do
	out="$WD/resources/narrowPeak/$(echo $file | sed -e 's/.*tnt\///' -e 's/_.*//').chr1-5_GEM_events.narrowPeak"
	cp $file $out
done
