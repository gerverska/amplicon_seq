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
conda install -c bioconda pheniqs cutadapt ngs-bits itsx vsearch diamond megan
conda deactivate

# Create an environment for R packages
conda create -p $r
conda activate $r
conda config --add channels conda-forge
conda install -c conda-forge r-base r-rstudioapi r-renv pkg-config
conda deactivate

# Download all R packages specified in renv.lock
conda run -p $r Rscript code/build.R
