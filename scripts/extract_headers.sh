#!/usr/bin/bash

# Extract headers
grep '>' Data/IP-004_S38_L001_scaffolds.fasta | cut -d"_" -f1-2 | cut -f2 -d">" > results/sequence_ids.txt

# Count sequences
COUNT=$(grep -c '>' Data/IP-004_S38_L001_scaffolds.fasta)

# Print message
echo "Extracted $COUNT sequence identifiers"
