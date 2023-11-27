#!/usr/bin/env bash

# https://github.com/ncbi/fcs/wiki/FCS-adaptor

# DIR where the current script resides
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

mkdir "${DIR}/fcsadaptor"
cd "${DIR}/fcsadaptor" || exit

# run_fcsadaptor.sh
curl -LO https://github.com/ncbi/fcs/raw/main/dist/run_fcsadaptor.sh
chmod 755 "${DIR}/fcsadaptor/run_fcsadaptor.sh"

# fcsadaptor_prok_test.fa.gz
mkdir "${DIR}/fcsadaptor/inputdir" "${DIR}/fcsadaptor/outputdir"
curl https://github.com/ncbi/fcs/raw/main/examples/fcsadaptor_prok_test.fa.gz -Lo "${DIR}/fcsadaptor/inputdir/fcsadaptor_prok_test.fa.gz"

# For Singularity: fcs-adaptor.sif
curl https://ftp.ncbi.nlm.nih.gov/genomes/TOOLS/FCS/releases/latest/fcs-adaptor.sif -Lo "${DIR}/fcsadaptor/fcs-adaptor.sif"
