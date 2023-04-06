import os
configfile: "config/config.yaml"
data_path = config["data_path"]
fa_path = config["fa_path"]

rule ref_prep:
    input:
        config["ref_path"] + "/ref.fna"
    output:
        config["ref_path"] + "/ref.fna.amb",
        config["ref_path"] + "/ref.fna.ann",
        config["ref_path"] + "/ref.fna.bwt",
        config["ref_path"] + "/ref.fna.pac",
        config["ref_path"] + "/ref.fna.sa"
    shell:
        "bwa index -a bwtsw {input}"

rule index:
    input:
        config["ref_path"] + "/ref.fna"
    output:
        config["ref_path"] + "/ref.fna.fai"
    shell:
        "samtools faidx {input}"

rule dmplex:
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
        "fastq-multx -b {input.br} {input.fr} {input.rr} -o {fr}%_1dmplx.fastq -o {rr}%_2dmplx.fastq"

rule dmplex_check:
    input:
        expand(config["fa_path"] + "{file}", file=[file for file in os.listdir(fa_path) if file.endswith("dmplx.fastq")])
