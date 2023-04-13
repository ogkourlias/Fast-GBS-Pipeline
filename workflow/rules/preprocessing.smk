"""
Contains rules for preprocessing of the reference data.
"""

# Imports

# Parameters
configfile: "config/config.yaml"

# Rules
rule Index:
    """
    Uses reference genome file to create index files with bwa and samtools.
    """
    input:
        config["reference"]
    output:
        config["ref"] + "ref.amb",
        config["ref"] + "ref.ann",
        config["ref"] + "ref.bwt",
        config["ref"] + "ref.pac",
        config["ref"] + "ref.sa",
        config["ref"] + "ref.fai"
    shell:
        "bwa index -a bwtsw {input}"
        "samtools faidx {input}"
