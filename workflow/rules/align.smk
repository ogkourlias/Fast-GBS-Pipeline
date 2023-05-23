"""
Contains rules for preprocessing of the reference data.
"""

# Imports
configfile: "config/config.yaml"

# Parameters
aligned = config["aligned"]
barcodes = config["barcodes"]
barcode_ids = [line.split('\t')[0] for line in open(config["barcodes"], "r")]

ref_output = config["ref_output"]
ref_id = config["reference"].split("/")[-1]
ref_name = ref_id.split(".")[0]

# Rules
rule align:
    input:
        fr = config["trimmed"] + "{id}_1.fastq",
        rr = config["trimmed"] + "{id}_2.fastq",
        amb = config["ref_output"] + "ref.amb",
        ann = config["ref_output"] + "ref.ann",
        bwt = config["ref_output"] + "ref.bwt",
        pac = config["ref_output"] + "ref.pac",
        sa = config["ref_output"] + "ref.sa",
    output:
        aligned + "{id}.sam"
    shell:
        """mkdir -p {aligned}
        bwa mem {ref_output}{ref_name} {input.fr} {input.rr} > {output}"""

            #"bwa mem <path-to-reference> <path-to-read1.fq> <path-to-read2.fq> > <path-to-output.sam>

