list.files("Data/", pattern = "*.csv", full.names = TRUE)

list.files("Data/", pattern = "*.pdf", full.names = TRUE)
num_csv_files <- length(csv_files)
csv_files <- list.files("Data/", pattern = ".csv", full.names = TRUE)
length(csv_files)
num_csv_files
num_csv_files







## load 'mtcars' dataset
## 1. find cars with a wt greater than 3 and 8 cyl
## save them into a new object
data("mtcars")
vec = mtcars
wt_greater_than_3_and_8_cyl = vec[vec$cyl == 8, ]
wt_greater_than_3_and_8_cyl = vec[vec$wt > 3, ]

## 2. calculate the average mpg of the new object
library(tidyverse)
wt_greater_than_3_and_8_cyl$mpg %>% 
  mean()
## Or just mean(wt_greater_that_3_and_8_cyl$mpg)

## 3. create a new numeric vector object named "hp.cyl"
# calculated by dividing hp by cyl.
names(wt_greater_than_3_and_8_cyl)
wt_greater_than_3_and_8_cyl$hy.cyl = wt_greater_than_3_and_8_cyl$hp/wt_greater_than_3_and_8_cyl$cyl
names(wt_greater_than_3_and_8_cyl)
hy.cyl
## this is listing the names of column in wt_greater vector
# i then created a new column named hy.cyl


## save this as a .csv file on laptop and open it
write(hy.cyl, 'hy_cyl.csv')



## using tidyverse####
mtcars %>% 
  filter(wt > 3 & cyl == 8) %>% 
  mutate(hp.cyl = hp/cyl) %>% 
  write_csv('test.csv')

#option 1
mean(mtcars$mpg) 

#option 2 - pipe
mtcars$mpg %>% 
  mean()

library(palmerpenguins)
View(penguins)
?penguins

penguins %>% # pipe = /
  names()
#same as above
names(penguins)

# or
name = penguins %>% 
  names()

#can do a lot in just one line of code
penguins %>% 
  filter(bill_length_mm > 40 & sex == 'female') %>% 
  View()

dat_bill = penguins %>% 
  filter(bill_length_mm > 40 & sex == 'female')

penguins %>% 
  filter(bill_length_mm > 40 & sex == 'female') %>% 
  View()

mean(dat_bill$body_mass_g)
dat_bill$body_mass_g %>% mean()

penguins %>% 
  filter(bill_length_mm > 40 & sex == 'female') %>% 
  pluck('body_mass_g') %>% 
  mean(na.rm = T) #will calculate the average if there is an error


mtcars %>% 
  filter(wt > 3 & cyl == 8) %>% 
  pluck('mpg') %>% 
  mean()

filtered_penguins = penguins %>% 
  filtered_penguins(bill_length_mm > 40 & sex == 'female') %>% 
  
penguins %>% 
  filter(bill_length_mm > 40 & sex == 'female') %>% 
  group_by(species, island) %>% 
  summarize(mean_body_mass = mean(body_mass_g),
            max_body_mass = max(body_mass_g),
            count = n()) %>% 
  arrange(desc(mean_body_mass)) # sort by large to small

penguins %>% 
  filter(bill_length_mm > 40 & sex == 'female') %>% 
  group_by(species, island) %>% 
  summarize(mean_body_mass = mean(body_mass_g),
            max_body_mass = max(body_mass_g),
            count = n()) %>% 
  arrange(mean_body_mass) # sort by small to large

penguins %>% 
  filter(bill_length_mm > 40 & sex == 'female') %>% 
  group_by(species, island) %>% 
  summarize(mean_body_mass = mean(body_mass_g),
            max_body_mass = max(body_mass_g),
            count = n()) %>% 
  write_csv('penguins-1.csv', row.names = F)

##or 
penguins %>% 
  filter(bill_length_mm > 40 & sex == 'female') %>% 
  group_by(island) %>% 
  summarize(mean_body_mass = mean(body_mass_g),
            max_body_mass = max(body_mass_g),
            count = n()) %>% 
  write_csv('penguins_2.csv')