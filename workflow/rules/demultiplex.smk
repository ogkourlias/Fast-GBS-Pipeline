"""
Contains rules for preprocessing of the reference data.
"""

# Imports

# Parameters
configfile: "config/config.yaml"

# Rules
rule Demultiplex:
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
