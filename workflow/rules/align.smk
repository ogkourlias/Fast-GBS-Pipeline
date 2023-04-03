configfile: "config/config.yaml"
adap = config["adap"]
readlen = config["readlen"]

rule dmplex:
    input:
        "{srr}_cut.fastq"
    output:
        fa = "{srr}_cut.fastq",
        fq = "{srr}_cut.fq"
    shell:
        "cutadapt -a {adap} -m ${readlen} -o {srr}_cut.fastq {srr}_cut.fq"