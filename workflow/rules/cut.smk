"""
Contains rules for preprocessing of the reference data.
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

        #cutadapt -a file:/media/orfeas/AE9E01139E00D5AD/data/adapters/adapter.txt
    # -o output/trimmed/test_1.fastq -p output/trimmed/test_2.fastq output/demultiplexed/Sample1_1.fastq output/demultiplexed/Sample1_2.fastq