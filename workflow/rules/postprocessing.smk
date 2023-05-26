# This script contains rules for preprocessing of the reference data.

# Parameters
configfile: "config/config.yaml"
aligned = config["aligned"]
barcodes = config["barcodes"]
filtered = config["filtered"]
ref_output = config["ref_output"]
final = config["final"]
qual = config["qual"]
barcode_ids = [line.split('\t')[0] for line in open(config["barcodes"], "r")]
ref_id = config["reference"].split("/")[-1]
ref_name = ref_id.split(".")[0]

# Rules
rule quality_control:
    """
    Rule to filter the SAM file for alignments with a certain m inimum quality.
    """
    input:
        aligned + "{id}.sam"
    output:
        filtered + "{id}.bam"
    shell:
        """
        samtools view -h -q {qual} -S -b {input} -o {output}
        """

rule haplotype_caller:
    """
    Rule to call haplotypes using FreeBayes.
    """
    input:
        filtered + "{id}.bam"
    output:
        final + "{id}.vcf"
    shell:
        """
        freebayes -f {ref_output}{ref_id} {input} > {output}
        """
