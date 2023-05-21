import os
configfile: "config/config.yaml"
ref = config["ref_path"] + "ref.fna"
fa_path = config["fa_path"]
data_path = config["data_path"]
rule align:
    input:
        expand(config["fa_path"] + "trimmed/" + "{file}", file=[file for file in os.listdir(fa_path + "trimmed/")])
    run:
        dict = {}
        for file in input:
            file = file.split("/")[-1].split(".")[0]
            if file.endswith("_1"):
                dict[file] = file.split("_1")[0] + "_2"
        for key in dict:
            print(f"bwa mem {ref} {fa_path}trimmed/{key}.fastq {fa_path}trimmed/{dict[key]}.fastq > {data_path}aligned/{key.split('_')[0]}.sam")
            os.system(f"bwa mem {ref} {fa_path}trimmed/{key}.fastq {fa_path}trimmed/{dict[key]}.fastq > {data_path}aligned/{key.split('_')[0]}.sam |"
                      f" samtools view -bS {data_path}aligned/{key.split('_')[0]}.sam > {data_path}aligned/bam/{key.split('_')[0]}.bam")
            #"bwa mem {ref} {file} > {file}.sam"
