"""
Contains rules for preprocessing of the reference data.
"""

# Imports
configfile: "config/config.yaml"

# Parameters
aligned = config["aligned"]
barcodes = config["barcodes"]
filtered = config["filtered"]
ref_output = config["ref_output"]
final = config["final"]

qual = config["qual"]

barcode_ids = [line.split('\t')[0] for line in open(config["barcodes"], "r")]
ref_id = config["reference"].split("/")[-1]
ref_name = ref_id.split(".")[0]

# Rules
rule quality_control:
    input:
        aligned + "{id}.sam"
    output:
        filtered + "{id}.bam"
    shell:
        "samtools view -h -q {qual} -S -b {input} -o {output}"

    #samtools view -h -q 20 -S -b aligned.sam -o filtered.bam



rule haplotype_caller:
    input:
        filtered + "{id}.bam"
    output:
        final + "{id}.vcf"
    shell:
        "freebayes -f {ref_output}{ref_id} {input} > {output}"


    # rule call:
#     input:
#         expand(data_path + "vcf/" + "{file}", file=[file for file in os.listdir(data_path + "vcf/")])
#
#     run:
#         for file in input:
#             print(f"gatk ReadBackedPhasing -R {ref} -I {file} -V {file} -O {data_path}vcf/called/{file.split('/')[-1].split('.')[0]}_phased.vcf.gz")
#             #os.system(f"gatk GenotypeGVCFs -R {ref} -V {file} -O {data_path}vcf/called/{file.split('/')[-1].split('.')[0]}.vcf.gz")
