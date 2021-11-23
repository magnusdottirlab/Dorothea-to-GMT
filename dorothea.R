### DoRothEA to GMT 
# Takes latest DoRothEA database of Transcription Factor-Target interactions and transposes it into
# a .gmt file suitable for The Broad/UCSD's GSEA program. GSEA is used as an alternative to the 
# authors preferred program VIPER. 

# https://saezlab.github.io/dorothea/


###
### 0. Load Libraries
###

# install from bioconductor
#if (!requireNamespace("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")

#BiocManager::install("dorothea")

# install the development version from GitHub if you want
# install.packages("devtools")
# devtools::install_github("saezlab/dorothea")

library(dorothea)
library(dplyr)

###
### 1. Access (mouse) Regulons
###

#Change to human if desired
#data(dorothea_hs, package = "dorothea")

data(dorothea_mm, package = "dorothea")

#Filter by Confidence
#Range from A (highest confidence) to E (lowest confidence)
# A: Interactions that are supported by all four lines of evidence (literature, ChIP-seq Peaks, Inference from gene expression, and TF binding motifs on promoters) - considered to be highly reliable
# B-D: Curated and/or ChIP-seq interactions with different levels of additional evidence. 
# E: Interactions that are only supported by computational predictions

#Change depending on mouse or human and what confidence levels you want
#regulons = dorothea_hs
#  filter(confidence %in% c("A", "B", "C", "D"))
regulons = dorothea_mm %>%
  filter(confidence %in% c("A", "B", "C", "D"))

###
### 2. Convert format
###

# https://stackoverflow.com/questions/70071847/rearranging-data-from-tibble-into-a-dataframe-in-r/70071923?noredirect=1#comment123868985_70071923
regulons = as.data.frame(regulons %>% 
  group_by(tf) %>% 
  summarise(Targets = list(target)) )

#Split the list-column
# https://stackoverflow.com/questions/50881440/split-a-list-column-into-multiple-columns
library(tidyr)
regulons = regulons %>% unnest_wider(Targets)

# Add column that would be description in the GMT but will just be the row number here
# Might replace with a real description later
number_of_rows <- nrow(regulons)
number_of_rows

row_num <- tibble(x = 1:number_of_rows)

library(tibble)
regulons <- regulons %>% add_column(row_num, .after = "tf")

###
### 3. Convert regulon table to GMT
###

# https://software.broadinstitute.org/cancer/software/gsea/wiki/index.php/Data_formats

write.table(regulons,"dorothea.gmt.txt",sep="\t", na = "", row.names=FALSE, col.names = FALSE, quote = FALSE)



