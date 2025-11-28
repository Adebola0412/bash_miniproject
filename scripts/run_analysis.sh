#!/usr/bin/bash

# 1. Check that at least one argument is given
if [ $# -lt 1 ]; then
    echo "ERROR: No data directory provided."
    echo "Usage: $0 <data_directory>"
    exit 1
fi

DATA_DIR="$1"


# 2. Check required files

FASTA="$DATA_DIR/IP-004_S38_L001_scaffolds.fasta"
PROTEIN_DB="$DATA_DIR/humchrx.txt"

if [ ! -f "$FASTA" ]; then
    echo "ERROR: FASTA file not found: $FASTA"
    exit 1
fi

if [ ! -f "$PROTEIN_DB" ]; then
    echo "ERROR: Protein database file not found: $PROTEIN_DB"
    exit 1
fi


# 4. FASTA EXPLORATION

echo "FASTA EXPLORATION"

grep -c "^>" "$FASTA" > results/sequence_count.txt
TOTAL_SEQ=$(cat results/sequence_count.txt)

echo "Total sequences: $TOTAL_SEQ"
echo "[DONE] FASTA exploration complete"

# 4. Sequence Filtering

echo "Filtering high-quality scaffolds"
scripts/filter_by_length.sh
echo "[DONE] High-quality scaffolds generated"

HQ_COUNT=$(wc -l < results/high_quality_scaffolds.txt)


# 5. Protein database analysis

echo "PROTEIN ANALYSIS"

grep -c "^" "$PROTEIN_DB" > results/protein_count.txt
PROTEIN_TOTAL=$(cat results/protein_count.txt)

echo "Total proteins: $PROTEIN_TOTAL"
echo "[DONE] Protein analysis complete"


# 6. Final Summary

echo "WRITING SUMMARY"

SUMMARY_FILE="results/analysis_summary.txt"
DATE_NOW=$(date)

echo "Analysis Summary" > "$SUMMARY_FILE"
echo "" >> "$SUMMARY_FILE"
echo "Total sequences in FASTA file: $TOTAL_SEQ" >> "$SUMMARY_FILE"
echo "High-quality scaffolds: $HQ_COUNT" >> "$SUMMARY_FILE"
echo "Total protein entries: $PROTEIN_TOTAL" >> "$SUMMARY_FILE"
echo "-------------------------" >> "$SUMMARY_FILE"
echo "Date: $DATE_NOW" >> "$SUMMARY_FILE"

echo "[DONE] Summary written to $SUMMARY_FILE"

echo
echo "===== Analysis complete! ====="

