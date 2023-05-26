# This script contains rules for preprocessing of the reference data.

# Parameters
configfile: "config/config.yaml"
demultiplexed = config["demultiplexed"]
barcodes = config["barcodes"]
barcode_ids = [line.split('\t')[0] for line in open(config["barcodes"], "r")]

# Rules
rule demultiplex:
    """
    Rule to demultiplex paired-end FASTQ files using the barcodes.
    """
    input:
        fr=config["fr"],
        rr=config["rr"],
        barcodes=config["barcodes"]
    output:
        demultiplexed + "{id}_1.fastq",
        demultiplexed + "{id}_2.fastq"
    shell:
        """fastq-multx -b {barcodes} {input.fr} {input.rr} -o {demultiplexed}%_1.fastq -o {demultiplexed}%_2.fastq"""