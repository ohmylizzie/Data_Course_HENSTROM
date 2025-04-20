library(ggplot2)
library(tidyverse)
library(readxl)

dat <- read_xlsx('Data/messy_bp.xlsx', skip = 3)
View(dat)


bp <- dat %>% 
  select(-starts_with('HR')) 

bp %>% 
  pivot_longer(starts_with('BP'),
               names_to = 'visit',
               values_to = 'bp') %>% 
  View()

bp %>% 
  pivot_longer(starts_with('BP'),
               names_to = 'visit',
               values_to = 'bp') %>%
  mutate(visit = case_when(visit == 'BP...8' ~ 1,
                           visit == 'BP...10' ~ 2,
                           visit == 'BP...12' ~ 3)) %>% 
  View()


bp <- bp %>% 
  pivot_longer(starts_with('BP'),
               names_to = 'visit',
               values_to = 'bp') %>%
  mutate(visit = case_when(visit == 'BP...8' ~ 1,
                           visit == 'BP...10' ~ 2,
                           visit == 'BP...12' ~ 3)) %>% 
  separate(bp, into = c('systolic', 'diastolic')) %>% 
  View()



hr <- dat %>% 
  select(-starts_with('BP')) 
View(hr)

hr <- hr %>% 
  pivot_longer(starts_with('HR'),
               names_to = 'visit',
               values_to = 'hr') %>%
  mutate(visit = case_when(visit == 'HR...9' ~ 1,
                           visit == 'HR...11' ~ 2,
                           visit == 'HR...13' ~ 3)) %>% 
  View()

View(bp)
View(hr)

dat_join <- full_join(bp, hr)
View(dat_join)

head(dat_join)
colnames(dat_join)

dat_join$`Month of birth`

colnames(dat_join) <- c('pat_id', 'Month_of_birth', ...)

library(janitor)
clean_names()
make_clean_names()


make_clean_names('# of bacteria')
make_clean_names('% of growth')
make_clean_names(c('# of bacteria', '% of growth'))

dat_join %>% clean_names()

dat = read_xlsx('Data/messy_bp.xlsx', skip = 3)
View(dat)

for (i in 2:nrow(dat)) {
  if(dat$pat_id[i] == dat$pat_id[i-1]) {
    dat$pat_id[i] = dat$pat_id[i] +1
  }
}
View(dat)


duplicated()


id = c(1, 2, 3, 4, 4, 5)
duplicated(id)

dat %>% 
  mutate(id_fix = pat_id + cumsum(duplicated(pat_id))) %>% 
  View()

dat %>% 
  arrange(`Year birth`) %>% 
  View()

dat %>% 
  clean_names() %>% 
  arrange(year_birth) %>% 
  View()



dat_join = full_join(bp, hr)
View(dat)

dat_join %>% 
  mutate(Race = case_when(Race == 'Caucasian' ~ 'White',
                          Race == 'WHITE' ~ 'White',
                          TRUE ~ Race)) %>% 
  View()



## | = or, & = and

dat_join %>% 
  mutate(Race = case_when(Race == 'Caucasian' | Race == 'WHITE' ~ 'White',
                          TRUE ~ Race)) %>% 
  View()
  
dat_join %>% 
mutate(Race_new_3 = case_when(Race == 'Asian'& Sex == 'Female',
                          TRUE ~ Race)) %>% 
  View()


df$systolic = as.numeric(df$systolic)

df_2 = dat_join %>% 
  mutate(race = case_when(race == 'Caucasian' ~ 'White',
                          race == 'WHITE' ~ 'White',
                          TRUE ~ race)) %>% 
  mutate(systolic = as.numeric(systolic),
         diastolic = as.numeric(diastolic)) %>% 
  mutate(birthday = paste(year_birth, month_birth, day_birth, sep = '-')) %>% 
  select(-year_birth, -month_birth, -day_birth) %>% 
  View()


names(dat_join)


## make a graph to show blood pressure changes throughout visits

df_2 %>% 
  ggplot(aes(x = visit, y = ))

df_3 = df_2 %>% 
  pivot_longer(cols = c('systolic', 'diastolic'),
               names_to = 'bp_type', values_to = 'bp')

df_3 %>% 
  ggplot(aes(x = visit, y = bp, color = bp_type)) +
  geom_path() +
  facet_wrap(~ bp_type) +
  facet_grid(hispanic ~ race)


df_3 %>% 
  ggplot(aes(x = visit, y = bp, color = bp_type)) +
  geom_path() +
  facet_grid(~ hispanic)



##

bird_dat = read.csv('Data/Bird_Measurements.csv')
View(bird_dat)
dim(bird_dat)


library(skimr)
skim(bird_dat)
