import os
configfile: "config/config.yaml"
ref = config["ref_path"] + "ref.fna"
fa_path = config["fa_path"]
data_path = config["data_path"]
rule platy:
    input:
        expand(config["fa_path"] + "trimmed/" + "{file}", file=[file for file in os.listdir(fa_path + "trimmed/")])
