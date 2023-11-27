#!/usr/bin/env bash

# https://github.com/ncbi/fcs/wiki/FCS-GX

# DIR where the current script resides
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Check the integrity of the database
# Expecting: /app/db/gxdb is up-to-date with https://ftp.ncbi.nlm.nih.gov/genomes/TOOLS/FCS/database/latest.
export FCS_DEFAULT_IMAGE="${DIR}/fcsgx/fcs-gx.sif"
LOCAL_DB="${DIR}/fcsgx/db"
SOURCE_DB_MANIFEST="https://ftp.ncbi.nlm.nih.gov/genomes/TOOLS/FCS/database/latest/all.manifest"
python3 "${DIR}/fcsgx/fcs.py" db check --mft "${SOURCE_DB_MANIFEST}" --dir "${LOCAL_DB}/gxdb"

# Verify functionality: 'test-only' database
python3 "${DIR}/fcsgx/fcs.py" screen genome --fasta "${DIR}/fcsgx/fcsgx_test.fa.gz" --out-dir "${DIR}/fcsgx/gx_out/" --gx-db "${LOCAL_DB}/test-only"  --tax-id 6973
head -n 5 "${DIR}/fcsgx/gx_out/fcsgx_test.fa.6973.taxonomy.rpt"
head "${DIR}/fcsgx/gx_out/fcsgx_test.fa.6973.fcs_gx_report.txt"

# Verify functionality: 'gxdb' database
#bsub -n 2 -M 524288 -q bigmem python3 "${DIR}/fcsgx/fcs.py" screen genome --fasta "${DIR}/fcsgx/fcsgx_test.fa.gz" --out-dir "${DIR}/fcsgx/gx_out/" --gx-db "${LOCAL_DB}/gxdb" --tax-id 6973
#head -n 5 "${DIR}/fcsgx/gx_out/fcsgx_test.fa.6973.taxonomy.rpt"
#head "${DIR}/fcsgx/gx_out/fcsgx_test.fa.6973.fcs_gx_report.txt"

# TODO combine the last two in the same job
#bsub -n 2 -M 524288 -q bigmem zcat "${DIR}/fcsgx/fcsgx_test.fa.gz" | python3 "${DIR}/fcsgx/fcs.py" clean genome --action-report "${DIR}/fcsgx/gx_out/fcsgx_test.fa.6973.fcs_gx_report.txt" --output "${DIR}/fcsgx/gx_out/clean.fasta" --contam-fasta-out "${DIR}/fcsgx/gx_out/contam.fasta"

function run_fcs_py {
  python3 "${DIR}/fcsgx/fcs.py" screen genome --fasta "${DIR}/fcsgx/fcsgx_test.fa.gz" --out-dir "${DIR}/fcsgx/gx_out/" --gx-db "${LOCAL_DB}/gxdb" --tax-id 6973
  head -n 5 "${DIR}/fcsgx/gx_out/fcsgx_test.fa.6973.taxonomy.rpt"
  head "${DIR}/fcsgx/gx_out/fcsgx_test.fa.6973.fcs_gx_report.txt"
  zcat "${DIR}/fcsgx/fcsgx_test.fa.gz" | python3 "${DIR}/fcsgx/fcs.py" clean genome --action-report "${DIR}/fcsgx/gx_out/fcsgx_test.fa.6973.fcs_gx_report.txt" --output "${DIR}/fcsgx/gx_out/clean.fasta" --contam-fasta-out "${DIR}/fcsgx/gx_out/contam.fasta"
}

bsub -n 2 -M 524288 -q bigmem run_fcs_py