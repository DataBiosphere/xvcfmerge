#!/usr/bin/env python
import os
import argparse

import gs_chunked_io
from terra_notebook_utils import vcf, gs

parser = argparse.ArgumentParser()
parser.add_argument("bucket", type=str, help="")
parser.add_argument("output_key", type=str, help="")
parser.add_argument("input_keys", help="GS bucket locations of '.vcf.gz' files.")
args = parser.parse_args()

client = gs.get_client()

bucket = client.bucket(args.bucket)

blobs = list()
for key in args.input_keys.split(","):
    blob = bucket.get_blob(key)
    print("vcf.gz size:", blob.size)
    blobs.append(blob)

vcf.combine(blobs, bucket.name, args.output_key)

# files/merge_vcfs.py fc-9169fcd1-92ce-4d60-9d2d-d19fd326ff10 combined.vcf.gz consent1/HVH_phs000993_TOPMed_WGS_freeze.8.chr7.hg38.vcf.gz phg001280.v1.TOPMed_WGS_Amish_v4.genotype-calls-vcf.WGS_markerset_grc38.c2.HMB-IRB-MDS/Amish_phs000956_TOPMed_WGS_freeze.8.chr7.hg38.vcf.gz
