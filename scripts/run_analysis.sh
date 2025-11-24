#!/usr/bin/bash

# 1. Check that at least one argument is given

if [ $# -lt 1 ]; then
    echo "ERROR: No data directory provided."
    echo "Usage: $0 <data_directory>"
    exit 1
fi

DATA_DIR="$1"

# 2. Check that required data files exist

FASTA="$DATA_DIR/IP-004_S38_L001_scaffolds.fasta"
PROTEIN_DB="$DATA_DIR/humchrx.txt"   # REAL FILE

if [ ! -f "$FASTA" ]; then
    echo "ERROR: FASTA file not found: $FASTA"
    exit 1
fi

if [ ! -f "$PROTEIN_DB" ]; then
    echo "ERROR: Protein database file not found: $PROTEIN_DB"
    exit 1
fi


# 3. FASTA Exploration

echo "Running FASTA exploration"
grep -c "^>" "$FASTA" > results/sequence_count.txt
echo "[DONE] FASTA exploration complete"

TOTAL_SEQ=$(cat results/sequence_count.txt)


# 4. Sequence Filtering

echo "Filtering high-quality scaffolds"
scripts/filter_by_length.sh > results/high_quality_scaffolds.txt
echo "[DONE] High-quality scaffolds generated"

HQ_COUNT=$(wc -l < results/high_quality_scaffolds.txt)


# 5. Protein Database Analysis

echo "Running protein analysis"
grep -c "^" "$PROTEIN_DB" > results/protein_count.txt
echo "[DONE] Protein analysis complete"

PROTEIN_TOTAL=$(cat results/protein_count.txt)


# 6. Create Final Summary

SUMMARY_FILE="results/analysis_summary.txt"
DATE_NOW=$(date)

echo "Writing final summary..."

echo "Analysis Summary" > "$SUMMARY_FILE"
echo "-------------------------" >> "$SUMMARY_FILE"
echo "Date: $DATE_NOW" >> "$SUMMARY_FILE"
echo "" >> "$SUMMARY_FILE"
echo "Total sequences in FASTA file: $TOTAL_SEQ" >> "$SUMMARY_FILE"
echo "High-quality scaffolds: $HQ_COUNT" >> "$SUMMARY_FILE"
echo "Total protein entries: $PROTEIN_TOTAL" >> "$SUMMARY_FILE"

echo "[DONE] Summary written to $SUMMARY_FILE"


# 7. End
echo "Analysis complete!"

