
# Gene Expression Analysis: Calculating Log Fold Change and Standard Deviation
This repository is dedicated to streamlining the analysis of common bioinformatics datasets, aiming to enhance the quality of code and deepen understanding of the underlying data. The primary focus is on fold change and gene expression analysis.

## Motivation
I developed this script to facilitate my understanding of how to manually calculate log fold change. Additionally, I was intrigued by exploring gene variability, leading me to utilize standard deviation. While I independently crafted most of the code, I received valuable assistance from ChatGPT to enhance code efficiency. My objective is to explore the significance of gene expression changes without relying on t-tests, and this script represents my progress so far.

The provided script aims to enhance understanding and streamline the assessment of gene expression changes, capturing both the direction and consistency of alterations in biological datasets. 

### Usage
You must specify the input files.

 Input Files:
Ensure you have the gene expression data file (`gene_counts.tsv`) and the experimental design file (`experiment.design.tsv`) in the appropriate format.

#### Specify Conditions
Define the conditions you want to compare (`condition_group1` and `condition_group2`).

### Run the Script;
`Run_calculate gene_change.R` 
Execute the script to obtain log fold change and standard deviation for a more comprehensive understanding of differential expression analysis.

### Acknowledgments
I would like to express my gratitude to ChatGPT for providing guidance and support in refining the code. This collaborative effort has contributed to the development of more efficient and insightful bioinformatics analyses.

Feel free to explore and contribute to further improvements in this repository!
