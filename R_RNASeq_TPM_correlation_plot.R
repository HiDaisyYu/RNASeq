#Take in the comparsion list as argument to plot correlation
library(ggplot2)

# Change the input file name 
args <-'MGI-GX121-TF-VS-Illumina-GX121-TF'
group_info <- args[1]
group1name <- unlist(strsplit(group_info, "-VS-"))[1]
group2name <- unlist(strsplit(group_info, "-VS-"))[2]
group1name_modified <- gsub("-",".",group1name)
group2name_modified <- gsub("-",".",group2name)

# Change the input file name 
final_merged_data <- read.table("RNA_TPM_with_biotype.txt", header = T, sep = "\t")
temp_data_frame <- final_merged_data[,c(group1name_modified,group2name_modified)]
data_matrix <- log2(temp_data_frame + 1)
data_matrix$gene_name <- final_merged_data$Geneid
data_matrix$gene_biotype <- final_merged_data$gene_biotype

#data_matrix_1 <- data_matrix[data_matrix[,1] > 3 & data_matrix[,1] < 20 & data_matrix[,2] > 0.7,]   #select those HMR > 5 & < 10
#data_matrix_2 <- data_matrix_1[(data_matrix_1[,1]-data_matrix_1[,2]) > 2 ,]

#hsa
#data_matrix_3 <- data_matrix[data_matrix[,4]=="miRNA" | data_matrix[,4]=="miRNA (hsa)", ]
data_matrix_3 <- data_matrix[data_matrix[,3]=="mature miRNA (miRBase)", ]

#mmu
#data_matrix_3 <- data_matrix[data_matrix[,4]=="miRNA" | data_matrix[,4]=="miRNA (mmu)", ]

#rno
#data_matrix_3 <- data_matrix[data_matrix[,4]=="miRNA" | data_matrix[,4]=="miRNA (rno)", ]


png(file= paste(group_info, ".png", sep = "", collapse = ""), width = 5, height = 5, units = 'in', res = 300)

p <- ggplot(data = data_matrix, aes(x =data_matrix[,1], y =data_matrix[,2])) +
  ggtitle(group_info)+ xlab(group1name_modified) + ylab(group2name_modified)+
  theme(plot.title = element_text(hjust = 0.5, size = 9))+
  #geom_smooth(method = "lm", se=FALSE, color="blue", formula = y ~ x) +
  geom_point(colour = "grey60", size = 1) +
  xlim(NA, 20) +
  ylim(NA, 20) +
  geom_point(data = data_matrix_2, aes(x =data_matrix_2[,1], y =data_matrix_2[,2]), colour="red")    #deviated genes
  # geom_point(data = data_matrix_3, aes(x =data_matrix_3[,1], y =data_matrix_3[,2]), colour="blue")  #miRNA

m <- lm(data_matrix[,2] ~ data_matrix[,1])
a <- round(coef(m)[1],3)
b <- round(coef(m)[2],3)
r1 <- round(sqrt(summary(m)$r.squared),4)
r2 <- round(summary(m)$r.squared,4)
gene_count <- nrow(data_matrix_3)
eq1 <- paste0("R = ", r1)
eq2 <- paste0("R2 = ", r2)
eq3 <- paste0("Count = ", gene_count)
correlation_graph <- p + annotate("text", label = eq1, x = 17.5, y = 17.5) + annotate("text", label = eq2, x = 17.5, y = 16.5) + annotate("text", label = eq3, x = 17.5, y = 15.5)
print(correlation_graph)
dev.off()


# write.csv(data_matrix_2, "mouse_seq_qia_dev_list.csv", row.names = F)
