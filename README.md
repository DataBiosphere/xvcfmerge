# xvcfmerge

Define a WDL workflow to merge jointly called VCF files. Input and output files may be stored locally, or in Google
Storage if prefixed with `gs://`.

### Description

[Samtools](https://samtools.github.io/) is used to perform the merge. Each input VCF should describe a single
chromosome, and should have equivilent headers.

In order to keep hard disk requirements small, and improve performance, when using `gs://`, input/output objects are
streamed directly from Google Storage using FIFO queus (named pipes). An appropriate configuration for workflow
exeuction would have ~16GB RAM, ~8 CPUs, and standard storage.
