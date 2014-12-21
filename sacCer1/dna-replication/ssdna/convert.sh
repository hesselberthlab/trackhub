#! /usr/bin/env bash

chroms=$HOME/ref/genomes/sacCer1/sacCer1.chrom.sizes

for wigfile in *.wig; do
    fbase=$(basename $wigfile .wig)
    bigwig="$fbase.bw"
    wigToBigWig $wigfile $chroms $bigwig
done
