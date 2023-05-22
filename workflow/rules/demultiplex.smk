"""
Contains rules for preprocessing of the reference data.
"""

# Imports
configfile: "config/config.yaml"

# Parameters
demultiplexed = config["demultiplexed"]
barcodes = config["barcodes"]
barcode_ids = [line.split('\t')[0] for line in open(config["barcodes"], "r")]

print(barcode_ids)
# Rules
rule demultiplex:
    input:
        fr=(config["fr"]),
        rr=(config["rr"]),
        barcodes=(config["barcodes"])
    output:
        expand(demultiplexed + "{id}_1.fastq", id = barcode_ids),
        expand(demultiplexed + "{id}_2.fastq", id = barcode_ids),
        demultiplexed + "unmatched_1.fastq",
        demultiplexed + "unmatched_2.fastq"
    shell:
        """fastq-multx -b {barcodes} {input.fr} {input.rr} -o {demultiplexed}%_1.fastq -o {demultiplexed}%_2.fastq
        """