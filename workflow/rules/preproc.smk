configfile: "config/config.yaml"
data_path = config["data_path"]
fa_path = config["fa_path"]

rule BwaIndex:
    input:
        config["ref_path"] + "ref.fna"
    output:
        config["ref_path"] + "ref.amb",
        config["ref_path"] + "ref.ann",
        config["ref_path"] + "ref.bwt",
        config["ref_path"] + "ref.pac",
        config["ref_path"] + "ref.sa"
    shell:
        "bwa index -a bwtsw {input}"

rule SamtoolsIndex:
    input:
        config["ref_path"] + "ref.fna"
    output:
        config["ref_path"] + "ref.fai"
    shell:
        "samtools faidx {input}"

rule Dmplex:
    input:
        fr=(config["fa_path"] + config["srr"] + "_1.fastq"),
        rr=(config["fa_path"] + config["srr"] + "_2.fastq"),
        br=(config["barcode_path"] + "barcodes.txt")
    # output:
    #     r1=(config["fa_path"] + "%_1dmplx.fastq"),
    #     r2=(config["fa_path"] + "%_2dmplx.fastq")
    log:
        config["log_path"] + config["srr"] + "_dmplx.log"
    shell:
        "fastq-multx -b {input.br} {input.fr} {input.rr} -o {fr}%_1.fastq -o {rr}%_.fastq"
