setwd("C:/Users/dhihr/OneDrive - London School of Hygiene and Tropical Medicine/mpox/treetime")
# Load the required package
library(readr)

# Read the metadata CSV
metadata <- read_csv("mpox_metadata2.csv")

# Load the required package
library(seqinr)

# Read the FASTA file
fasta_data <- read.fasta("treetime_mpox2.fasta", seqtype = "DNA")

# Extract the sequence names from the FASTA file
fasta_names <- names(fasta_data)

# Load the required package
library(ape)

# Read the Newick tree
nwk_tree <- read.tree("mpox_asean_tempest3.nwk")

# Extract the tree tip labels
tree_labels <- nwk_tree$tip.label

# Find common names between metadata and FASTA
common_names_fasta <- intersect(metadata$strain, fasta_names)
# Find common names between metadata and tree labels
common_names_nwk <- intersect(metadata$strain, tree_labels)
# Find common names between FASTA and Newick
common_names_fasta_nwk <- intersect(fasta_names, tree_labels)

# Ensure both metadata and fasta_data are ordered by the common names
metadata_subset <- metadata[metadata$strain %in% common_names_fasta_nwk, ]
metadata_subset <- metadata_subset[match(common_names_fasta_nwk, metadata_subset$strain), ]

fasta_data_subset <- fasta_data[names(fasta_data) %in% common_names_fasta_nwk]
fasta_data_subset <- fasta_data_subset[match(common_names_fasta_nwk, names(fasta_data_subset))]

write.csv(metadata_subset, "aligned_metadata2.csv", row.names = FALSE)

library(seqinr)
write.fasta(sequences = fasta_data_subset,
            names = names(fasta_data_subset),
            file.out = "aligned_fasta_sequences2.fasta")

head(metadata_subset$strain)
head(names(fasta_data_subset))
