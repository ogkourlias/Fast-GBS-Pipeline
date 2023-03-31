configfile: "config/config.yaml"

rule preproc:
    input:
        fa=config["fa_path"] + config["srr"] + "_1.fastq"
    output:
        "data/asdf.txt"
    shell:
        "head {input} > data/asdf.txt"