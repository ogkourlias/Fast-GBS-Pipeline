"""
Contains rules for preprocessing of the reference data.
"""

# Imports
configfile: "config/config.yaml"

# Parameters
aligned = config["aligned"]

barcodes = config["barcodes"]
barcode_ids = [line.split('\t')[0] for line in open(config["barcodes"], "r")]

# Rules
rule align:
    input:
        fr = config["trimmed"] + "{id}_1.fastq",
        rr = config["trimmed"] + "{id}_2.fastq",
        ref = config["reference"]
    output:
        aligned + "{id}.sam"
    shell:
        "bwa mem {input.ref} {input.fr} {input.rr} > {output}"

            #"bwa mem <path-to-reference> <path-to-read1.fq> <path-to-read2.fq> > <path-to-output.sam>

