#!/bin/bash

# This script allows for the creation of environments on different platforms.
# Two different environments are needed to avoid program incompatibilities.

# This script will install the most current and compatible programs available.
# Use conda_create_versions.sh if specific versions are required.

# To use this script, source it in the project directory:

# source conda_create.sh

# Setup
cli="conda/cli/"
r="conda/r/"
conda remove -p $cli --all
conda remove -p $r --all
> .Rprofile
rm -fr renv
mkdir conda

# Create an environment for command line programs
conda create -p $cli
conda activate $cli
conda config --add channels bioconda
conda config --add channels anaconda
conda install -c bioconda pheniqs=2.0.6 cutadapt=2.6 ngs-bits=2019_09 \
itsx=1.1.3 vsearch=2.18.0 diamond=0.9.24 megan=6.12.3
conda deactivate

# Create an environment for R and R packages
conda create -p $r
conda activate $r
conda config --add channels conda-forge
conda install -c conda-forge r-base=4.2.2 r-rstudioapi=0.14 r-renv=0.16.0 pkg-config=0.29.2
conda deactivate

# Download all R packages specified in renv.lock
conda run -p $r Rscript code/build.R
