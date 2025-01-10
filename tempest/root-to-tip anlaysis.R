# Load necessary libraries
library(ape)
library(ggplot2)
library(ggtree)
library(ggpubr)

## Without Imputation

setwd("C:/Users/dhihr/OneDrive/mpox/asean_seq")
# Step 2: Read the tree
tree <- read.tree('mpox_asean_tempest.nwk')

# Step 3: Define dummy sampling times for the tips
data <- read.table("table_tempest_asean", header = TRUE)


ggplot(data, aes(x = date, y = distance)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Root-to-Tip Regression",
    x = "Sampling Time",
    y = "Root-to-Tip Distance"
  ) +
  theme_minimal()


# Step 6: Plot root-to-tip regression
r <- ggplot(data, aes(x = date, y = distance)) +
  geom_point(size = 4, alpha = 0.5) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Without Imputation",
    x = "Time",
    y = "Root-to-Tip Divergence"
  )  + guides(size = 'none')+
  theme_classic() + stat_cor(aes(label=..rr.label..), digits = 4, label.x=2019, label.y=0.0004)
r

## With Imputation
tree <- read.tree('mpox_asean_tempest2.nwk')

# Step 3: Define dummy sampling times for the tips
data <- read.table("table_tempest_asean2", header = TRUE)


ggplot(data, aes(x = date, y = distance)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Root-to-Tip Regression",
    x = "Sampling Time",
    y = "Root-to-Tip Distance"
  ) +
  theme_minimal()


# Step 6: Plot root-to-tip regression
r2 <- ggplot(data, aes(x = date, y = distance)) +
  geom_point(size = 4, alpha = 0.5) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "With Imputation",
    x = "Time",
    y = "Root-to-Tip Divergence"
  )  + guides(size = 'none')+
  theme_classic() + stat_cor(aes(label=..rr.label..), digits = 4, label.x=2019, label.y=0.0004)
r2

library(patchwork)
r+r2

## Indonesia

setwd("C:/Users/dhihr/OneDrive/mpox/indo")
# Step 2: Read the tree
tree <- read.tree('mpox_indo_tempest2.nwk')

# Step 3: Define dummy sampling times for the tips
data <- read.table("table_tempest_indo2", header = TRUE)


ggplot(data, aes(x = date, y = distance)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Root-to-Tip Regression",
    x = "Sampling Time",
    y = "Root-to-Tip Distance"
  ) +
  theme_minimal()


# Step 6: Plot root-to-tip regression
r3 <- ggplot(data, aes(x = date, y = distance)) +
  geom_point(size = 4, alpha = 0.5) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "",
    x = "Time",
    y = "Root-to-Tip Divergence"
  )  + guides(size = 'none')+
  theme_classic() + stat_cor(aes(label=..rr.label..), digits = 4, label.x=2022.6, label.y=0.0004)
r3

