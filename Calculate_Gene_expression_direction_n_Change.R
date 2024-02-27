#This script will get the  log fold change and standard deviation together providing 
#a more comprehensive view of the differential expression analysis,
#capturing both the direction and consistency of gene expression changes.

#Log Fold Change (logFC):
#Measures the proportional change in expression levels between two groups.
#A log fold change of 0 indicates no change, positive values indicate upregulation, and negative values indicate downregulation.

#Standard Deviation (SD):
#Measures the amount of variation or dispersion of data points within a group.
#A higher standard deviation indicates greater variability in expression levels within the group.
#It provides insights into the consistency or variability of gene expression within each condition
  

calculate_fold_change <- function(gene_expression_file, exp_data_file, condition_group1, condition_group2) {
  # Read data files
  gene_expression_data <- readr::read_tsv(gene_expression_file)
  exp_data <- readr::read_tsv(exp_data_file)
  
  # Extract relevant columns and remove duplicates
  gene_expression_data2 <- gene_expression_data[!duplicated(gene_expression_data$`Gene Name`), ]
  gene_expression_data2 <- gene_expression_data2[!is.na(gene_expression_data2$`Gene Name`), ]
  gene_expression_data3 <- gene_expression_data2[, -1]
  
  # Set gene names as row names
  rownames(gene_expression_data3) <- gene_expression_data2$`Gene Name`
  
  # Specify the groups you want to compare
  group1_samples <- exp_data[exp_data$`Sample Characteristic[disease]` == condition_group1, "Run"]
  group2_samples <- exp_data[exp_data$`Sample Characteristic[disease]` == condition_group2, "Run"]
  
  # Ensure that sample names are common between gene expression and experimental design
  #common_samples <- intersect(colnames(gene_expression_data3), c(as.character(group1_samples$Run), as.character(group2_samples$Run)))
  
  # Subset gene expression data for the specified groups
  group1_data <- gene_expression_data3[, as.character(group1_samples$Run)]
  group2_data <- gene_expression_data3[, as.character(group2_samples$Run)]
  
  # Print information for troubleshooting
  cat("Length of group1_data:", length(group1_data), "\n")
  cat("Length of group2_data:", length(group2_data), "\n")
  print(group1_data)
  #print(group2_data)
  
  # Calculate fold change
  fold_change <- rowMeans(group2_data) / (rowMeans(group1_data) + 1e-10)
  
  # Calculate standard deviation for each group
  sd_group1 <- apply(group1_data, 1, sd)
  sd_group2 <- apply(group2_data, 1, sd)
  
  # Create a data frame with gene names, fold change, standard deviation, and p-value
  result_df <- data.frame(
    Gene = rownames(gene_expression_data3),
    FoldChange = log2(fold_change),
    SD_group1 = sd_group1,
    SD_group2 = sd_group2 
  )
  
  return(result_df)
}



# Example usage:
result <- calculate_fold_change("gene_counts.tsv", "experiment.design.tsv", "normal", "prostate carcinoma")
print(result)


#The positive log fold change suggests upregulation in the second group compared to the first.
#The higher standard deviation in Group 2 (SD2) indicates more variability in expression levels within Group 2 compared to Group 1 (SD1
