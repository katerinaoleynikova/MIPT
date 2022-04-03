#!/usr/bin/env bash

set -eou pipefail
set -o nounset
set -o errexit

INPUT_FOLDER="$1"
INPUT_FILE="$2"
REF_FOLDER="$3"
REF_FILE="$4"
EXCLUDE_REGIONS_BED="$5"
GFF_FILE="$6"
OUTPUT_FOLDER="$7"
NUM_THREADS="$8"
NAME="${INPUT_FILE%.*}"
mkdir "$OUTPUT_FOLDER"

echo Step 1: structural variants calling

docker run \
 --rm \
 -v "${INPUT_FOLDER}":/work/ \
 -v "${REF_FOLDER}":/refs/ \
 -v "${OUTPUT_FOLDER}":/outputs/ \
 --name SV_calling_$(date +'%Y%m%d-%H%M') \
 brentp/smoove smoove call \
 --name "$NAME" \
 --exclude /refs/"${EXCLUDE_REGIONS_BED}" \
 --fasta /refs/"${REF_FILE}" \
 -p "$NUM_THREADS" \
 --genotype /work/"${INPUT_FILE}" \
 --outdir /outputs/

 echo Step 2: annotation of calling results

 docker run \
 --rm \
 -v "${OUTPUT_FOLDER}":/work/ \
 -v "${REF_FOLDER}":/refs/ \
 --name SV_calling_annotation_$(date +'%Y%m%d-%H%M') \
 brentp/smoove smoove annotate \
 --gff /refs/"${GFF_FILE}" /work/"${NAME}-smoove.genotyped.vcf.gz" |
bgzip -c > "${OUTPUT_FOLDER}"/"${NAME}.smoove.square.anno.vcf.gz"
