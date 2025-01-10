## Sequence 
library(treeio)
library(ape)
library(ggtree)
library(tidyverse)

#add sequence
setwd("C:/Users/dhihr/OneDrive - London School of Hygiene and Tropical Medicine/mpox/indo")
mybootsdata <- treeio::read.iqtree("modified_alignment.fasta.contree")
mybootsdata
class(mybootsdata)
str(mybootsdata@phylo)
tree <- mybootsdata@phylo

# Assuming your tree is stored in a variable named 'tree'
tree$tip.label <- sub("\\|.*$", "", tree$tip.label)

metadata<-read.csv('metadata_indo.csv')
metadata$date <- as.Date(metadata$date, format = "%m/%d/%Y")
metadata$id <- seq_len(nrow(metadata))
#metadata$id <- paste0('C',metadata$id)

#reroot
lable_reroot <- 'hMpxV/Indonesia/JK-NIHRD-MP0024/2022'
tree <- root(tree, outgroup = lable_reroot, resolve.root = TRUE)

metat_subset <- metadata %>% select(label, date)
write.table(metat_subset, file = "indo_tempest3.txt", sep = "\t", row.names = FALSE, col.names = FALSE, quote = FALSE)
write.tree(tree, file = 'mpox_indo_tempest3.nwk')
