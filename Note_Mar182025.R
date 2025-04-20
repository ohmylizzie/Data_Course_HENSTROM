## This is a script for BIOL3100 class 19

## Date: March 18, 2025
## Yuya Liang

library(skimr)
library(tidyverse)
library(janitor)


dat <- read.csv('Data/Bird_Measurements.csv')
View(dat)
dim(dat)

skim(dat)

## clean bird measurement data
## keep: Family	Species_number	Species_name	English_name
## clutch size, egg mass, mating system

keep = c("Family", 	"Species_number",	"Species_name",	
         "English_name", "Clutch_size", "Egg_mass", "Mating_System") %>% 
  str_to_lower()

names(dat)


male <- dat %>% 
  select(keep, starts_with('M_'), -ends_with('_N')) %>% 
  mutate(sex = 'male') 


female <- dat %>% 
  select(keep, starts_with('F_'), -ends_with('_N')) %>% 
  mutate(sex = 'female') 


unsexed <- dat %>% 
  select(keep, starts_with('unsexed_'), -ends_with('_N')) %>% 
  mutate(sex = 'unsexed') 


View(unsexed)


join_dat <- full_join(male, female)

join_dat_2 <- full_join(join_dat, unsexed)


names(male)

names(male) %>% str_remove('M_')



male <- dat %>% 
  select(keep, starts_with('M_'), -ends_with('_N')) %>% 
  mutate(sex = 'male') 

names(male) <- names(male) %>% str_remove('M_')


female <- dat %>% 
  select(keep, starts_with('F_'), -ends_with('_N')) %>% 
  mutate(sex = 'female') 

names(female) <- names(female) %>% str_remove('F_')


unsexed <- dat %>% 
  select(keep, starts_with('unsexed_'), -ends_with('_N')) %>% 
  mutate(sex = 'unsexed') 

names(unsexed) <- names(unsexed) %>% str_remove('unsexed_')
names(unsexed) <- names(unsexed) %>% str_remove('Unsexed_')


clean_dat <- 
  male %>% 
  full_join(female) %>% 
  full_join(unsexed)

View(clean_dat)

identical(names(male), names(female))
identical(letters[1:3], c('a','b', 'c'))

library(readxl)

path = '/Users/yu-yaliang/Desktop/BIOL3100/Data_Course_LASTNAME/Worst Data Storage Ever.xlsx'
dat <- read_xlsx(path)

dat <- read_csv('Data/Bird_Measurements.csv')

file = 'Data/Bird_Measurements.csv'
dat <- read_csv(file)



dat <- read_xlsx(path, sheet = 2)
dat <- read_xlsx(path, sheet = 2, range = 'A1:G10')


## function

everything()
mean()
sd()
read.csv(argument1, argument2, ...)


weather <- function(){
  print('it is cold')
}

weather()




clean_bird_data <- function(dat){
  keep = c("Family", 	"Species_number",	"Species_name",	
           "English_name", "Clutch_size", "Egg_mass", "Mating_System") 
  
  male <- dat %>% 
    select(keep, starts_with('M_'), -ends_with('_N')) %>% 
    mutate(sex = 'male') 
  
  names(male) <- names(male) %>% str_remove('M_')
  
  
  female <- dat %>% 
    select(keep, starts_with('F_'), -ends_with('_N')) %>% 
    mutate(sex = 'female') 
  
  names(female) <- names(female) %>% str_remove('F_')
  
  
  unsexed <- dat %>% 
    select(keep, starts_with('unsexed_'), -ends_with('_N')) %>% 
    mutate(sex = 'unsexed') 
  
  names(unsexed) <- names(unsexed) %>% str_remove('unsexed_')
  names(unsexed) <- names(unsexed) %>% str_remove('Unsexed_')
  
  
  clean_dat <- 
    male %>% 
    full_join(female) %>% 
    full_join(unsexed)
  
  return(clean_dat)
}

clean_bird_data()
dat
dat <- read.csv('Data/Bird_Measurements.csv')

library(tidyverse)
clea <- clean_bird_data(dat)
View(clea)





