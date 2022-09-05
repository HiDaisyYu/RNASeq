# Extract the "TPM" column from RSEM/ ".genes.results" and combine as a table
# Sample name:
# MGI-GX121-TF
# Illumina-GX121-TF
# MGI-GX123-T1F
# Illumina-GX123-T1F


Sample_list <- c("MGI-GX121-TF", "Illumina-GX121-TF", "MGI-GX123-T1F", "Illumina-GX123-T1F")
Sample <- Sample_list[1]

Sample_data_path <- paste0(Sample, ".genes.results")
Sample_data <- read.table(Sample_data_path, header = T, sep = "\t")
gene_id <- Sample_data["gene_id"]
combined_TPM <- data.frame(gene_id)

for (Sample in Sample_list) {
  Sample_data_path <- paste0(Sample, ".genes.results")
  Sample_data <- read.table(Sample_data_path, header = T, sep = "\t")
  Sample_TPM <- Sample_data["TPM"]
  combined_TPM[,Sample] <- Sample_TPM
}

write.table(combined_TPM, file="RNA_TPM.txt", sep = "\t", row.names = F, quote = F)
