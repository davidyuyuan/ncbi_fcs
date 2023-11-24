#!/usr/bin/env bash

#https://github.com/ncbi/fcs/wiki/FCS-adaptor

# DIR where the current script resides
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# For Docker
#"${DIR}/fcsadaptor//run_fcsadaptor.sh" --fasta-input "${DIR}/fcsadaptor/inputdir/fcsadaptor_prok_test.fa.gz" --output-dir "${DIR}/fcsadaptor/outputdir" --prok

bsub -n 2 -M 4096 -q production "${DIR}/fcsadaptor/run_fcsadaptor.sh" --fasta-input "${DIR}/fcsadaptor/inputdir/fcsadaptor_prok_test.fa.gz" \
  --output-dir "${DIR}/fcsadaptor/outputdir" --prok --container-engine singularity --image "${DIR}/fcsadaptor/fcs-adaptor.sif"
