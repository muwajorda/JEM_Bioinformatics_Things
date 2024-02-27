# Load your function script
source("Calculate_Gene_expression_direction_n_Change.R")  # Replace with the actual filename of your script

# Define paths to test files
gene_counts_file <- "path/to/gene_counts.tsv"
exp_design_file <- "path/to/experiment.design.tsv"

# Specify conditions
condition_group1 <- "normal"
condition_group2 <- "cancer"

# Call the function
result <- calculate_fold_change(gene_counts_file, exp_design_file, condition_group1, condition_group2)

# Print the result
print(result)
