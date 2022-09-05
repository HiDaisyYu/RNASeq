args <-commandArgs(TRUE)
Sample <- args[1]
File <- paste0(Sample, ".genes.results")
genes_results <- read.table(File, header = T)
log2_tpm_count <- log2(genes_results[,6])
png(file= paste(Sample, ".png", sep = "", collapse = ""), width = 5, height = 5, units = 'in', res = 300)
# frequency histogram
#hist(log2_tpm_count, main = Sample, breaks=100, xlim=c(-5,15), ylim=c(0,1000), col="blue",xlab = "RNAseq expression level(TPM log2)")
#density histogram
hist(log2_tpm_count, main = Sample, breaks=100, , freq = F,xlim=c(-5,15), ylim=c(0,0.25), col="blue",xlab = "RNAseq expression level(TPM log2)")
dev.off()
