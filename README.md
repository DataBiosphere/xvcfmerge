# xvcfmerge

Define a WDL workflow to merge jointly called VCF files. This workflow accepts input as array of reference URIs. The
reference URIs should be either Google Storage URLs or
[DRS](https://support.terra.bio/hc/en-us/articles/360039330211-Data-Access-with-the-GA4GH-Data-Repository-Service-DRS-)
URIs.

### Description

[Samtools](https://samtools.github.io/) is used to perform the merge. Each input VCF should describe a single
chromosome and should have equivilent headers.

In order to keep hard disk requirements small and improve performance, input/output objects are streamed directly from
cloud storage using FIFO queus (named pipes).

An appropriate workflow configuration is ~16GB RAM, ~8 CPUs, and standard storage.
