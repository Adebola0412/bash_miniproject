#!/usr/bin/bash


echo -n "Protein: "
read Protein

#searching for kinase
grep -i "$Protein" Data/humchrx.txt


# Count matches
grep -ic "$Protein" Data/humchrx.txt
count=$(grep -ic "$Protein" Data/humchrx.txt)

echo "Found $count matching proteins." > results/protein_search_results.txt


#Extract protein ID and description

ID=$(grep -i "$Protein" Data/humchrx.txt | cut -d' ' -f3-)

echo "$ID" >> results/protein_search_results.txt


