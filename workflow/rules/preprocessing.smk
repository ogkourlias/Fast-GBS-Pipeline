"""
Contains rules for preprocessing of the reference data.
"""

# Imports

# Parameters
configfile: "config/config.yaml"
ref_output = config["ref_output"]
ref_id = config["reference"].split("/")[-1]
ref_name = ref_id.split(".")[0]

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
    shell:
        """cp {input} {ref_output}{ref_id}
        bwa index -p {ref_output}{ref_name} -a bwtsw {ref_output}{ref_id}
        """

        # samtools faidx {ref_output}{ref_id} -o {ref}.fai

