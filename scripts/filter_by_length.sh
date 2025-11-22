#!/usr/bin/bash

min=5000

# extract all lengths
lengths=$(grep '>' Data/IP-004_S38_L001_scaffolds.fasta | cut -d'_' -f4)


> results/filtered_sequences.txt

for length in $lengths
do

    if [ -z "$length" ]; then
        continue
    fi

# extract all lenghts -ge 5000
    if [ "$length" -ge "$min" ]; then

# get ONLY headers whose length equals this to number
        grep "length_${length}_cov" Data/IP-004_S38_L001_scaffolds.fasta >> results/filtered_sequences.txt
    fi
done

count=$(wc -w < results/filtered_sequences.txt)

echo "Found $count sequences with length >= $min bases"

