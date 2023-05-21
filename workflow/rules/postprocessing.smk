import os
configfile: "config/config.yaml"
ref = config["ref_path"] + "ref.fna"
fa_path = config["fa_path"]
data_path = config["data_path"]
qs = config["qual"]

rule quality_control:
    input:
        expand(data_path + "aligned/bam/" + "{file}", file=[file for file in os.listdir(data_path + "aligned/bam/")])
    run:
        for file in input:
            print(f"samtools view -bh -q {qs} {file} > {data_path}/aligned/filtered/{file.split('/')[-1]}")
            os.system(f"samtools view -bh -q {qs} {file} > {data_path}/aligned/filtered/{file.split('/')[-1]}")

rule create_dict:
    input:
        ref
    output:
        ref.split('.')[0] + ".dict"
    shell:
        "gatk CreateSequenceDictionary -R {input} -O {output}"

rule haplotype:
    input:
        expand(data_path + "aligned/filtered/" + "{file}", file=[file for file in os.listdir(data_path + "aligned/filtered/")])
    output:
        config["data_path"] + "vcf/" + "summary.vcf.gz"

    run:
        for file in input:
            print(f"gatk HaplotypeCaller -R {ref} -I {file} -O {data_path}vcf/{file.split('/')[-1].split('.')[0]}.vcf.gz")
            os.system(f"gatk HaplotypeCaller -R {ref} -I {file} -O {data_path}vcf/{file.split('/')[-1].split('.')[0]}.vcf.gz")
        open(f'{data_path}vcf/summary.vcf.gz', "w").close()

            #DIT WERKT NOG NIET
            # DIT WERKT NOG NIET
            # DIT WERKT NOG NIET
            # DIT WERKT NOG NIET

# rule haplo_check:
#     output:
#         "{data}"

# rule call:
#     input:
#         expand(data_path + "vcf/" + "{file}", file=[file for file in os.listdir(data_path + "vcf/")])
#
#     run:
#         for file in input:
#             print(f"gatk ReadBackedPhasing -R {ref} -I {file} -V {file} -O {data_path}vcf/called/{file.split('/')[-1].split('.')[0]}_phased.vcf.gz")
#             #os.system(f"gatk GenotypeGVCFs -R {ref} -V {file} -O {data_path}vcf/called/{file.split('/')[-1].split('.')[0]}.vcf.gz")
