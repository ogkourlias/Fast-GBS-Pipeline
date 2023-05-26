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
ref_file_new = ref_output + ref_name
print(ref_file_new)


# Rules
rule align:
    input:
        fr = config["trimmed"] + "{id}_1.fastq",
        rr = config["trimmed"] + "{id}_2.fastq",
        amb = ref_file_new + ".amb",
        ann = ref_file_new + ".ann",
        bwt = ref_file_new + ".bwt",
        pac = ref_file_new + ".pac",
        sa = ref_file_new + ".sa",
    output:
        aligned + "{id}.sam"
    shell:
        """mkdir -p {aligned}
        bwa mem {ref_output}{ref_name} {input.fr} {input.rr} > {output}"""

            #"bwa mem <path-to-reference> <path-to-read1.fq> <path-to-read2.fq> > <path-to-output.sam>

