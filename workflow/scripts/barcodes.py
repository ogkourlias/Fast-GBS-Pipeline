import yaml
import sys
import os

# def read_config(config_file):
#     """Read the configuration file and return a dictionary of the contents"""
#     with open(config_file, 'r') as f:
#         config = yaml.safe_load(f)
#         path = config["barcode_path"]
#     barcodes_f = open(f"{path}/barcodes.txt", 'r')
#     return barcodes_f
#
# def read_barcodes():
#     """Make the barcode file for sabre"""
#     barcode_dict = {}
#     barcodes_f = read_config("/home/orfeas/Documents/Fast-GBS-Pipeline/config/config.yaml")
#     barcodes = [x.strip() for x in barcodes_f]
#     for entry in barcodes:
#         barcode_dict[entry.split()[0]] = entry.split()[1]
#     return barcode_dict

def read_barcodes(config_file):
    with open(config_file, 'r') as f:
        config = yaml.safe_load(f)
        fa_path = config["fa_path"]
    samples = [file for file in os.listdir(fa_path) if file.endswith("dmplx.fastq")]
    return samples
def main():
    x = read_barcodes("/home/orfeas/Documents/Fast-GBS-Pipeline/config/config.yaml")
    print(x)

if __name__ == "__main__":
    main()