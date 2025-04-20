library(tidyverse)
library(ggplot2)
library(gganimate)

table1
table4a
table4b

## make table4a and table4b tidy (like table1)


better_table4a = table4a %>% 
  pivot_longer(-country,
               names_to = 'year',
               values_to = 'cases') 

better_table4b = table4b %>% 
  pivot_longer(-country,
               names_to = 'year',
               values_to = 'population')

fully_better_table = full_join(better_table4a, better_table4b)

## make table5 tidy
table5

bettertable5 = table5 %>% 
  separate(rate, c('cases', 'population'), convert = T) %>% ##telling that they are numeric values
  mutate(Year = paste0(table5$century, table5$year)) %>% ##make a new column using the combination of two columns
  select(-century) ## Can use c(blah, blah2) to select multiple things ####
 # you may have to change the name of the new column if the previous one does not exist


setwd('Exercises')
getwd()

text = read_delim('Data_Entry_Case_Study.txt')


library(readxl)

setwd('~/Desktop/BIOL3100/Data_Course_HENSTROM/Data')
dat = read_xlsx('Messy_bp.xlsx', skip = 3) ### Skips 3 rows
View(dat)

dat$Race %>% 
  unique()
## create a new column called "visit"
## change caucasian and WHITE to 'White" (case if if white and nonhispanic then white and if white and hispanic then black)
## separate the two values in BP