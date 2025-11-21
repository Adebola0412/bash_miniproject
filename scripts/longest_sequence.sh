#!/usr/bin/bash

# Identifies which scaffold which has the longest sequence

grep '>' Data/IP-004_S38_L001_scaffolds.fasta | cut -f2 -d">" | cut -d"_" -f4 | sort -n | tail -1

longest=$(grep '>' Data/IP-004_S38_L001_scaffolds.fasta | cut -f2 -d">" | cut -d"_" -f4 | sort -n | tail -1)

#Longest sequence
Longest=$(grep "length_$longest" Data/IP-004_S38_L001_scaffolds.fasta | cut -d'>' -f2 | cut -d'_' -f1,2)

#lenght
Length=$(grep "length_$longest" Data/IP-004_S38_L001_scaffolds.fasta | cut -d'>' -f2 | cut -d'_' -f4)

#coverage
coverage=$(grep "length_$longest" Data/IP-004_S38_L001_scaffolds.fasta | cut -d'>' -f2 | cut -d'_' -f6)

echo "Longest sequence: $Longest" > results/longest_sequence.txt
echo "Length: $Length bases" >> results/longest_sequence.txt
echo "Coverage : $coverage" >> results/longest_sequence.txt
