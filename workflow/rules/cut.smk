"""
Contains rules for cutting the samples.
"""

# Imports
configfile: "config/config.yaml"

# Parameters
demultiplexed = config["demultiplexed"]
ads = config["adapter"]
trimmed = config["trimmed"]
barcodes = config["barcodes"]
barcode_ids = [line.split('\t')[0] for line in open(config["barcodes"], "r")]

# Rules
rule cut:
    """
    Rule to cut adapters from demultiplexed paired-end FASTQ files.
    """
    input:
        demultiplexed + "{id}_1.fastq",
        demultiplexed + "{id}_2.fastq"
    output:
        trimmed + "{id}_1.fastq",
        trimmed + "{id}_2.fastq"
    shell:
        """
        cutadapt -a file:{ads} -o {output[0]} -p {output[1]} {input[0]} {input[1]}
        """
