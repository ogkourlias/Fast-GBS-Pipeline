import os
configfile: "config/config.yaml"
data_path = config["data_path"]
fa_path = config["fa_path"]
ads = open(config["adapter_path"] + "adapter.txt").read().strip()

rule cut:
    input:
        expand(config["fa_path"] + "dmplx/" + "{file}", file=[file for file in os.listdir(fa_path + "dmplx/")])
    run:
        for file in input:
            os.system(f"cutadapt -a {ads} -o {fa_path}trimmed/{file.split('/')[-1]} {file}")

