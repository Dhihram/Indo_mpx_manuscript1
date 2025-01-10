# Load Biostrings library
library(Biostrings)
setwd("C:/Users/dhihr/OneDrive - London School of Hygiene and Tropical Medicine/mpox")

# Read your FASTA file
sequences <- readDNAStringSet("gisaid_pox_2024_06_15_05.fasta")
# ASEAN 
setwd("C:/Users/dhihr/OneDrive/asean_seq")
sequences <- readDNAStringSet("gisaid_pox_singapore.fasta")

reference <- readDNAStringSet("NC_063383.1 ref.fasta.txt")
  
# Calculate the lengths of each sequence
sequence_lengths <- width(sequences)

# (Optional) Provide a reference genome length (if known)
reference_genome_length <- width(reference)  # Replace with your genome size in bp

# Calculate the total sequence length
total_sequence_length <- sum(width(sequences))

# Calculate sequence depth
sequence_depth <- total_sequence_length / reference_genome_length
cat("Sequence Depth:", sequence_depth, "X\n")

# per seq depth
per_sequence_depth <- width(sequences) / reference_genome_length
names(per_sequence_depth) <- names(sequences)  # Assign sequence names
print(per_sequence_depth)

# Calculate the mean length
mean(sequence_lengths)
cat("Sequence Depth:", sequence_depth, "X\n")

# Convert named vector to a dataframe
depth_df <- data.frame(
  Sequence = names(per_sequence_depth),  # Extract sequence names
  Depth = as.numeric(per_sequence_depth) # Extract depth values
)

# Display the dataframe
mean(depth_df$Depth)


#Read Aligned FASTA
sequences <- readDNAStringSet("gisaid_pox_aligned_ali.fasta")

# Function to rename sequence labels
rename_sequence_labels <- function(sequences) {
  # Extract the current names
  original_names <- names(sequences)
  
  # Modify the names by splitting at the "|" character and taking the first part
  new_names <- sapply(original_names, function(x) strsplit(x, "\\|")[[1]][1])
  
  # Assign the modified names back to the sequences
  names(sequences) <- new_names
  
  # Return the modified DNAStringSet
  return(sequences)
}

# Apply the function to rename the labels
sequences <- rename_sequence_labels(sequences)

# View the modified names
names(sequences)

# Export the DNAStringSet to a FASTA file
writeXStringSet(sequences, filepath = "beast_gisaid_pox_aligned_ali.fasta")

# Read your FASTA file
sequences <- readDNAStringSet("beast_gisaid_pox_aligned_ali.fasta")

# Calculate the lengths of each sequence
sequence_lengths <- width(sequences)

# Calculate the median length
mean(sequence_lengths)

# Calculate the total number of base pairs
total_base_pairs <- sum(width(sequences))
