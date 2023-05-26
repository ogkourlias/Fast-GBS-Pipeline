#!/usr/bin/env python3

"""
Python module to be used at the end of the fast-gbs workflow to generate
a histogram of quality scores from the VCF file.
"""

# METADATA VARIABLES
__author__ = "Orfeas Gkourlias"
__status__ = "Release Version"
__version__ = "1.0"

# IMPORTS
import allel
import argparse
import matplotlib.pyplot as plt

def argparser():
    """Argument parser function"""
    parser = argparse.ArgumentParser(description='Plot a histogram of quality scores')
    parser.add_argument('-i', '--input', type=str, required=True, help='Input VCF file')
    parser.add_argument('-id', '--id', type=str, required=True, help='Sample ID')
    args = parser.parse_args()
    return args

def create_histogram(args):
    """Function to create a histogram of quality scores"""
    # Read the VCF file
    callset = allel.read_vcf(args.input)

    # Extract quality scores
    qual = callset['variants/QUAL']

    # Plot a histogram of quality scores
    plt.hist(qual, bins=30, edgecolor='black')
    plt.xlabel('Quality Score')
    plt.ylabel('Count')
    plt.title('Distribution of Quality Scores')

    # Save the plot
    plt.savefig(f'output/final/{args.id}.png', dpi=300)

def main():
    args = argparser()
    create_histogram(args)

if __name__ == '__main__':
    main()