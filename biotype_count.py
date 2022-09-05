#!/usr/bin/env python3

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

help_text = 'sum the total count of gene biotype'

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
###Select the columns needed
biotype_df = subset.iloc[:,1:14]
###Select the grouping
group_variable = "gene_group"
biotype_sum = biotype_df.groupby(group_variable).sum()
biotype_sum.to_csv("Sum_"+group_variable+'_'+file_name+'.csv', index=True)
