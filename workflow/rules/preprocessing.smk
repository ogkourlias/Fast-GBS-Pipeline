# This script contains rules for preprocessing of the reference data.

# Parameters
configfile: "config/config.yaml"
ref_output = config["ref_output"]
ref_id = config["reference"].split("/")[-1]
ref_name = ref_id.split(".")[0]
ref_file_new = ref_output + ref_name

# Rules
rule Index:
    """
    Uses reference genome file to create index files with bwa and samtools.
    """
    input:
        config["reference"]
    output:
        ref_file_new + ".amb",
        ref_file_new + ".ann",
        ref_file_new + ".bwt",
        ref_file_new + ".pac",
        ref_file_new + ".sa",
    shell:
        """cp {input} {ref_output}{ref_id}
        bwa index -p {ref_output}{ref_name} -a bwtsw {ref_output}{ref_id}
        """
