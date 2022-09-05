#!/usr/bin/env python3

###############################################################
# For counting the number of genes in different gene biotypes #
###############################################################



import os, sys
import subprocess
import argparse
import csv
import pandas as pd
import glob
import string
import random
from shutil import copyfile
import smtplib
from email.mime.text import MIMEText

workdir = os.getcwd()

help_text = 'number of genes of different gene biotype'

parser = argparse.ArgumentParser(description=help_text)

parser.add_argument(
    dest='file_name',
    action='store',
    type=str,
    help='file (required)',
    metavar='file_name'
    )

arguments = parser.parse_args()
file_name = arguments.file_name

Excelname = glob.glob(workdir+'/'+file_name+'.xlsx')[0]
Excel = Excelname
xl = pd.ExcelFile(Excel)
#sheet0 = xl.parse('Sheet1')
sheet1 = xl.parse('Sheet1')
#subset = sheet1.drop(columns='chr')
subset = sheet1
col_len = len(subset.columns)
col_end = col_len + 1
###Select the columns needed
biotype_df = subset.iloc[:,3:col_end]
biotype_bygene = pd.DataFrame()
###Select the grouping
group_variable = "gene_group"
biotype_index = sorted(biotype_df[group_variable].unique().tolist())
biotype_bygene[group_variable] = biotype_index

#read counts>0
for n in range(1, len(biotype_df.columns)):
    temp_df = biotype_df.iloc[:,[0,n]][biotype_df.iloc[:,n] > 0].groupby(group_variable).count()
    biotype_bygene = biotype_bygene.merge(temp_df, how='left', left_on=group_variable, right_index=True)

#TPM >1
#for n in range(1, len(biotype_df.columns)):
#    temp_df = biotype_df.iloc[:,[0,n]][biotype_df.iloc[:,n] > 1].groupby('gene_biotype').count()
#    biotype_bygene = biotype_bygene.merge(temp_df, how='left', left_on='gene_biotype', right_index=True)


biotype_bygene = biotype_bygene.fillna(0) 
biotype_bygene.to_csv("GeneNo_"+group_variable+"_"+file_name+'.csv', index=False)
