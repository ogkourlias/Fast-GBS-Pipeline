configfile: "config/config.yaml"
adap = config["adap"]
readlen = config["readlen"]

rule dmplex:
    input:
        "{input_path}/{srr}_1.fastq"
    output:
        fa = "{srr}_cut.fastq",
        fq = "{srr}_cut.fq"
    shell:
        "cutadapt -a {adap} -m ${readlen} -o {srr}_cut.fastq {srr}_cut.fq"