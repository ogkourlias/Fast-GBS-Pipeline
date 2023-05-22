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

print(barcode_ids)

# Rules
rule cut:
    input:
        fr= demultiplexed + "{id}_1.fastq",
        rr= demultiplexed + "{id}_2.fastq"
    output:
        tr_fr= trimmed + "{id}_1.fastq",
        tr_rr= trimmed + "{id}_2.fastq"
    shell:
        """
        cutadapt -a file:{ads} -o {output.tr_fr} -p {output.tr_fr} {input.fr} {input.rr}
        """

        #cutadapt -a file:/media/orfeas/AE9E01139E00D5AD/data/adapters/adapter.txt
    # -o output/trimmed/test_1.fastq -p output/trimmed/test_2.fastq output/demultiplexed/Sample1_1.fastq output/demultiplexed/Sample1_2.fastq