# xvcfmerge

Definitions and utilities to create and publish a Docker container to merge jointly called VCF files stored on Google
Storage.

## Usage

Before running commands, execute `source environment` in the repo root.

Create the image:
```
make image
```

Publish:
```
make publish
```

Start and shell into the container:
```
make publish
```

## Image

The primary purpose of this image is execution in the [Terra](https://terra.biodatacatalyst.nhlbi.nih.gov/) workflow
environment, as part of the [BioData Catalyst](https://biodatacatalyst.nhlbi.nih.gov/) project. However, it may be
generally useful for VCF merges.

This workflow is published, and available for use, on the
[UCSC Dockstore](https://dockstore.org/workflows/github.com/xbrianh/xvcfmerge:master?tab=info).

### Description

Google Storage object URLs are expected as inputs (one for each input VCF, and an additional URL for the output VCF).
[Samtools](https://samtools.github.io/) is used to perform the merge. Each input VCF should describe a single
chromosome, and should have equivilent headers.

In order to keep hard disk requirements small, and improve performance, input/output objects are streamed directly from
Google Storage using FIFO queus (named pipes). An appropriate configuration for workflow exeuction would have ~16GB RAM,
~8 CPUs, and standard storage.
