## Tasks:
#Create a plaintext document named “final_project_idea.txt”
#In it, describe your idea for a data analysis final project
#Also, Describe the sort of data you will use, potential sources, and what the data might look like
#(If you already have data, skip this task) Create fake data that simulates what your final project data set might look like. Preferrably a csv file
#Generate a plot (using ggplot) using either your real or fake data that shows at least one expected result

### 1. For my final project, I would like to view the different species of butterflies and moths, and to see 
# traits that make them different. Both evolved from a common ancestor and I would like to see what biological traits that
# they have in common.

### 2. I will use the "Traits data for the butterflies and macro-moths of Great Britain and Ireland, 2022"
# that I had found when searching for datasets that I could use. While it is more specific than I'd like,
# there are about 160,000 species of moths and 17,500 butterflies, so I believe that my computer would blow up
# if I were to use that many variables. With this dataset, I could see the difference between their lifespans, 
# if they are native to Great Britain and/or Ireland, and even their evolutionary biology, as the authors mention.
# I would like to explore their evolutionary biology further, but that may require some more outside research.

### 3. ggplot data

library(tidyverse)
library(ggplot2)

dataaa = read.csv("ecological_traits_2022.csv")

colnames("dataaa")
str("dataaa")

colnames(dataaa) <- as.character(dataaa[1, ])

dataaa <- dataaa[-1, ]

rownames(dataaa) <- NULL

View(dataaa)

colnames(dataaa)[duplicated(colnames(dataaa))]
colnames(dataaa) <- make.names(colnames(dataaa), unique = TRUE) 
print(colnames(dataaa))

dataaa %>% 
  ggplot(aes(
             x = rarirty_gb)) +
  geom_bar()

## This graph shows the current rarity of butterflies and moths in Great Britain and Ireland. 
# I think that this is an interesting statistic. The bar that is not named is what I am guessing is "common."
