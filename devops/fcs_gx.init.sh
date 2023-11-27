#!/usr/bin/env bash

# https://github.com/ncbi/fcs/wiki/FCS-GX

# DIR where the current script resides
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

mkdir "${DIR}/fcsgx"
cd "${DIR}/fcsgx" || exit

# fcs.py and fcsgx_test.fa.gz
curl -LO https://github.com/ncbi/fcs/raw/main/dist/fcs.py
curl -LO https://github.com/ncbi/fcs/raw/main/examples/fcsgx_test.fa.gz

# For Singularity: fcs-gx.sif
curl https://ftp.ncbi.nlm.nih.gov/genomes/TOOLS/FCS/releases/latest/fcs-gx.sif -Lo "${DIR}/fcsgx/fcs-gx.sif"
export FCS_DEFAULT_IMAGE="${DIR}/fcsgx/fcs-gx.sif"

# test-only
LOCAL_DB="${DIR}/fcsgx/db"
SOURCE_DB_MANIFEST="https://ftp.ncbi.nlm.nih.gov/genomes/TOOLS/FCS/database/test-only/test-only.manifest"
python3 "${DIR}/fcsgx/fcs.py" db get --mft "${SOURCE_DB_MANIFEST}" --dir "${LOCAL_DB}/test-only"

# gxdb
SOURCE_DB_MANIFEST="https://ftp.ncbi.nlm.nih.gov/genomes/TOOLS/FCS/database/latest/all.manifest"
python3 "${DIR}/fcsgx/fcs.py" db get --mft "${SOURCE_DB_MANIFEST}" --dir "${LOCAL_DB}/gxdb"
