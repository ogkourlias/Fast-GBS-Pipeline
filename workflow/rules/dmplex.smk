configfile: "config/config.yaml"
input_path = config["fast_path"]

rule dmplex:
    input:
        "{input_path}/SRR2073085_1.fastq"
    output:
        "data/asdf.txt"
    shell:
        "head {input} > data/asdf.txt"