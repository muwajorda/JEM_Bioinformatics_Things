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
  common_samples <- intersect(colnames(gene_expression_data3), c(as.character(group1_samples$Run), as.character(group2_samples$Run)))
  
  # Subset gene expression data for the specified groups
  group1_data <- gene_expression_data3[, as.character(common_samples[group1_samples$Run %in% common_samples])]
  group2_data <- gene_expression_data3[, as.character(common_samples[group2_samples$Run %in% common_samples])]
  
  # Print information for troubleshooting
  cat("Length of group1_data:", length(group1_data), "\n")
  cat("Length of group2_data:", length(group2_data), "\n")
  
  # Calculate fold change
  fold_change <- rowMeans(group2_data) / (rowMeans(group1_data) + 1e-10)
  
  # Perform Welch's t-test on matrices
  t_test_result <- t.test(as.matrix(group2_data), as.matrix(group1_data), var.equal = FALSE)
  
  # Create a data frame with gene names, fold change, and p-value
  result_df <- data.frame(Gene = rownames(gene_expression_data3), FoldChange = fold_change, PValue = t_test_result$p.value)
  
  return(result_df)
}

# Example usage:
result <- calculate_fold_change("gene_counts.tsv", "experiment.design.tsv", "normal", "prostate carcinoma")
print(result)

