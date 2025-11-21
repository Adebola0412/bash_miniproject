#!/usr/bin/bash

min_length=10000
min_cov=5.0

> results/high_quality_scaffolds.txt

headers=$(grep '>' Data/IP-004_S38_L001_scaffolds.fasta)

for header in $headers; do

    length=$(echo "$header" | cut -d'_' -f4)
    cov=$(echo "$header" | cut -d'_' -f6)


    if [ "$length" = "" ] || [ "$cov" = "" ]; then
        continue
    fi

    cov_first=$(echo "$cov" | cut -c1)


    if [ "$length" -ge "$min_length" ]; then

        if [ "$cov_first" -ge 5 ]; then
            echo "$header" >> results/high_quality_scaffolds.txt
        fi
    fi
done

count=$(wc -l < results/high_quality_scaffolds.txt)
echo "Found $count high-quality scaffolds"

