"""
Contains rules for preprocessing of the reference data.
"""

# Imports

# Parameters
configfile: "config/config.yaml"
ref = config["ref_output"]

# Rules
rule Index:
    """
    Uses reference genome file to create index files with bwa and samtools.
    """
    input:
        config["reference"]
    output:
        config["ref_output"] + "ref.amb",
        config["ref_output"] + "ref.ann",
        config["ref_output"] + "ref.bwt",
        config["ref_output"] + "ref.pac",
        config["ref_output"] + "ref.sa",
        config["ref_output"] + "ref.fai"
    shell:
        """bwa index -p {ref}ref -a bwtsw {input}
        samtools faidx {input} -o {ref}ref.fai"""
