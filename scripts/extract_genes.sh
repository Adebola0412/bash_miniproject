#!/usr/bin/bash

#Extracts all unique gene names from the file
cut -d' ' -f1 Data/humchrx.txt
#filter only the real gene names
cut -d' ' -f1 Data/humchrx.txt     | grep -E '[A-Z][A-Z0-9]+'

#Sorts them alphabetically
cut -d' ' -f1 Data/humchrx.txt     | grep -E '[A-Z][A-Z0-9]+'     | sort -u

#saving the output
cut -d' ' -f1 Data/humchrx.txt     | grep -E '[A-Z][A-Z0-9]+'     | sort -u > results/gene_names_sorted.txt
