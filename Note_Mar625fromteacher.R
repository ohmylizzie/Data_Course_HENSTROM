dat <- read_xlsx('Data/messy_bp.xlsx', skip = 3)
View(dat)



for (i in 2:nrow(dat)) {
  if(dat$pat_id[i] == dat$pat_id[i - 1]) {
    dat$pat_id[i] <- dat$pat_id[i] + 1
  }
}

View(dat)


duplicated()

id <- c(1, 2, 3, 4, 4, 5)
duplicated(id)

dat %>% 
  mutate(id_fix = pat_id + cumsum(duplicated(pat_id))) %>% 
  View()

dat %>% 
  mutate(id_fix = pat_id + 1) %>% 
  View()


dat %>% 
  arrange(`Year birth`) %>% 
  View()


dat %>% 
  clean_names() %>% 
  arrange(year_birth) %>% 
  View()


bp <- dat %>% 
  select(-starts_with('HR')) 

bp <- bp %>% 
  pivot_longer(starts_with('BP'),
               names_to = 'visit',
               values_to = 'bp') %>%
  mutate(visit = case_when(visit == 'BP...8' ~ 1,
                           visit == 'BP...10' ~ 2,
                           visit == 'BP...12' ~ 3)) %>% 
  separate(bp, into = c('systolic', 'diastolic'))  


hr <- dat %>% 
  select(-starts_with('BP')) 

hr <- hr %>% 
  pivot_longer(starts_with('HR'),
               names_to = 'visit',
               values_to = 'hr') %>%
  mutate(visit = case_when(visit == 'HR...9' ~ 1,
                           visit == 'HR...11' ~ 2,
                           visit == 'HR...13' ~ 3)) 

View(bp)
View(hr)

dat_join <- full_join(bp, hr)
write_csv(dat_join, 'dat_join.csv')

new_read <- read_csv('dat_join.csv')
View(new_read)

View(dat_join)

dat_join$Race %>% unique()



dat_join %>% 
  mutate(Race_new = case_when(Race == 'Caucasian' ~ 'White',
                              Race == 'WHITE' ~ 'White',
                              TRUE ~ Race)) %>% View()


dat_join %>% 
  mutate(Race_new_3 = case_when(Race == 'Asian' & Sex == 'Female' ~ 'Asian_female',
                                TRUE ~ Race)) %>% View()

| # or
  & # and
  
  
  
  dat_join %>% 
  mutate(Race = case_when(Race == 'Caucasian' ~ 'White',
                          Race == 'WHITE' ~ 'White',
                          TRUE ~ Race)) %>% 
  str()

df <- dat_join %>% 
  mutate(Race = case_when(Race == 'Caucasian' ~ 'White',
                          Race == 'WHITE' ~ 'White',
                          TRUE ~ Race)) 

df$systolic <- as.numeric(df$systolic)



dat_join %>% 
  clean_names() %>% 
  mutate(race = case_when(race == 'Caucasian' ~ 'White',
                          race == 'WHITE' ~ 'White',
                          TRUE ~ race)) %>% 
  mutate(systolic = as.numeric(systolic),
         diastolic = as.numeric(diastolic)) %>% 
  mutate(birthday = paste(year_birth, month_of_birth, day_birth, sep = '-')) %>% 
  select(-year_birth, -month_of_birth, -day_birth) %>% 
  View()


names(dat_join)

## make a graph to show blood pressure changes throughtout visits

df_2 <- dat_join %>% 
  clean_names() %>% 
  mutate(race = case_when(race == 'Caucasian' ~ 'White',
                          race == 'WHITE' ~ 'White',
                          TRUE ~ race)) %>% 
  mutate(systolic = as.numeric(systolic),
         diastolic = as.numeric(diastolic)) %>% 
  mutate(birthday = paste(year_birth, month_of_birth, day_birth, sep = '-')) %>% 
  select(-year_birth, -month_of_birth, -day_birth) 

View(df_2)

df_2 %>% 
  ggplot(aes(x = visit, y = ))


df_3 <- df_2 %>% 
  pivot_longer(cols = c('systolic', 'diastolic'),
               names_to = 'bp_type', values_to = 'bp') 

df_3 %>% 
  ggplot(aes(x = visit, y = bp, color = bp_type)) +
  geom_path() +
  #facet_wrap(~ bp_type) +
  facet_grid(hispanic ~ race)


df_3 %>% 
  ggplot(aes(x = visit, y = bp, color = bp_type)) +
  geom_path() +
  facet_wrap(~ hispanic) 


## 

dat <- read.csv('Data/Bird_Measurements.csv')
View(dat)
dim(dat)

library(skimr)
skim(dat)
?skim



## 



