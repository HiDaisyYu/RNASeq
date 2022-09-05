# RNASeq

Scripts within this repository are used to analyze gene expression level of RNA-Seq datasets. 

#### biotype_count.py 
is to count expressed genes' biotypes using 'Excel/sample.xlsx' as the inptut file. 

#### biotype_count_gene.py
is to count genes' number for each biotype using 'Excel/sample.xlsx' as the inptut file.

#### R_RNASeq_extract_TPM_to_table.R
is to extract TPM column from 'RSEM/ sample.genes.results' files and generate a table. 

#### R_RNASeq_plot_TPM.R
is to plot TPM density

#### R_RNASeq_TPM_correlation_plot.R
is to plot TPM correlation of two samples. The test data is 'RNA_TPM_with_biotype.txt', which can be download to test this script. 
