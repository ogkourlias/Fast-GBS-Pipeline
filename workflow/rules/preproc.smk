configfile: "config/config.yaml"

rule prepref:
    input:
        ref=config["ref"]
    output:
        config["ref"] + ".amb",
        config["ref"] + ".ann",
        config["ref"] + ".bwt",
        config["ref"] + ".pac",
        config["ref"] + ".sa"
    shell:
        "bwa index -a bwtsw {input}"

rule index:
    input:
        ref=config["ref"]
    output:
        config["ref"] + ".fai"
    shell:
        "samtools faidx {input}"
