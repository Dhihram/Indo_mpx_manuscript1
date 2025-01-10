library(ape)
library(ggtree)
setwd("C:/Users/dhihr/OneDrive - London School of Hygiene and Tropical Medicine/mpox/treetime/mpox_timetree")
nexus_tree <- read.nexus("timetree.nexus")
plot(nexus_tree)

#reroot
#lable_reroot <- 'NC_063383.1'
#tree <- root(nexus_tree, outgroup = lable_reroot, resolve.root = TRUE)
#plot(tree)

setwd("C:/Users/dhihr/OneDrive - London School of Hygiene and Tropical Medicine/mpox/asean_seq")
metadata<-read.csv('metadata_asean.csv')
metadata$date <- as.Date(metadata$date, format = "%m/%d/%Y")
metadata$id <- sub("^[^/]+/[^/]+/([^/]+).*$", "\\1", metadata$label)
#metadata$id <- seq_len(nrow(metadata))
#metadata$id <- paste0('C',metadata$id)

most_recent_date <- max(lubridate::as_date(metadata$date))
ggtree(nexus_tree, mrsd=most_recent_date) + geom_tiplab() + theme_tree2()

#tree <- drop.tip(nexus_tree, 'NC_063383.1')
t <- ggtree(nexus_tree, mrsd=most_recent_date) + theme_tree2()
#by clade
t %<+% metadata + geom_tippoint(aes(color = clade), size = 2) + 
  geom_tiplab(aes(label=id), size = 1.7)+  labs(color = "Clade") +
  theme(legend.position = c(0.2, 0.5))
#by country
t %<+% metadata + geom_tippoint(aes(color = location), size = 2) + 
  geom_tiplab(aes(label=id), size = 1.7)+  labs(color = "Country") +
  theme(legend.position = c(0.2, 0.5))

#Indonesia
drop <- metadata %>% filter(location != 'Indonesia')
ina <- metadata %>% filter(location == 'Indonesia')
#reroot
lable_reroot <- 'hMpxV/Indonesia/JK-NIHRD-MP0024/2022'
tree <- root(tree, outgroup = lable_reroot, resolve.root = TRUE)
most_recent_date <- max(lubridate::as_date(ina$date))
tree <- drop.tip(tree, drop$label)
t <- ggtree(tree, mrsd=most_recent_date) + theme_tree2()
t %<+% metadata + geom_tippoint(aes(color = clade), size = 2) + 
  geom_tiplab(aes(label=id), size = 2)+  labs(color = "Clade") +
  theme(legend.position = c(0.2, 0.5))

#non time tree
setwd("C:/Users/dhihr/OneDrive - London School of Hygiene and Tropical Medicine/mpox/indo")
tree <- read.tree("mpox_indo_tempest2.nwk")
t <- ggtree(tree) + theme_tree2() + labs(caption="Substitution rate")

metadata<-read.csv('metadata_indo.csv')
metadata$date <- as.Date(metadata$date, format = "%m/%d/%Y")
metadata$id <- sub("^[^/]+/[^/]+/([^/]+).*$", "\\1", metadata$label)
t %<+% metadata + geom_tippoint(aes(color = clade), size = 2) + 
  geom_tiplab(aes(label=id), size = 1.7)+  labs(color = "clade") 
  theme(legend.position = c(0.1, 0.7)) + geom_treescale(fontsize=6, linesize=2)
  
t <- ggtree(tree) + 
    theme_tree2() + 
    labs(caption = "Substitution rate") +
    labs(color = "clade") +
    geom_treescale(x=0.00015, y=2, fontsize = 5, linesize = 1.5) +
    theme(legend.position = c(0.1, 0.7))
t %<+% metadata + geom_tippoint(aes(color = clade), size = 2.5) + 
    geom_tiplab(aes(label=id), size = 1.7) + 
  labs(color = "Clade") +
    theme(legend.position = c(0.1, 0.7))

