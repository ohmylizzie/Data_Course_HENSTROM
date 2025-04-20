library(tidyverse)
library(janitor)
library(ggplot2)
dat = read.csv('Data/BioLog_Plate_Data.csv')
View(dat)

##clean names
##create a new col = time, pivot longer
##create a new col = type (soil or water)



dat_clean = dat %>% 
  pivot_longer(col = starts_with('Hr_'),
               names_to = 'time',
               values_to = 'abs') %>% 
  mutate(time = as.numeric(str_remove(time, 'Hr_')))

View(dat_clean)
  
dat_clean$Sample.ID %>% 
  unique()

dat_clean_v2 = dat_clean %>% 
  mutate(type = case_when(
    Sample.ID %in% c("Clear_Creek", "Waste_Water") ~ 'Water',
    TRUE ~ 'Soil'
  )) 

dat_plot = dat_clean_v2 %>% 
  filter(Dilution == 0.1)

dim(dat_plot)

dat_plot$Dilution %>%  unique()

dat_plot %>% 
  ggplot(aes(x = time, y = abs, color = type)) +
  geom_smooth(se = F) +
  facet_wrap(~ Substrate) +
  labs(title = 'Just dilution 0.1',
       x = 'Time',
       y = 'Absorbance',
       color = 'Type') +
  theme_minimal()


itaconic_dat = dat_clean_v2 %>% 
  filter(Substrate =='Itaconic Acid')

View(itaconic_dat)

mean_abs = itaconic_dat %>% 
  group_by(Sample.ID, Dilution, time) %>% 
  summarise(mean_abs = mean(abs))

mean_abs

library(gganimate)

mean_abs %>% 
  ggplot(aes( x = time,
              y = mean_abs,
              color = Sample.ID)) +
  geom_line() +
  facet_wrap(~ Dilution) +
  labs(x = 'Time',
       y = 'Mean_absorbance',
       color = 'Sample.ID') +
  theme_minimal() +
  transition_reveal(time)



## read Height.xlsx file and make it tidy

library(readxl)
library(measurements)
dat = read_xlsx('Data/height.xlsx')
View(dat)

dat_2 = dat %>% 
  pivot_longer(everything(),
               names_to = 'sex',
               values_to = 'height') %>% 
  separate(height, into = c('feet', 'inches'), 
           convert = T) %>% 
  mutate(inches_all = (feet*12) + inches) %>% 
  mutate(cm = conv_unit(inches_all, from = 'inch', to = 'cm'))


dat_2 %>% 
  ggplot(aes( x = cm,
              fill = sex)) +
  geom_density(alpha = .5)


t.test(cm ~ sex, data = dat_2)
cor.test()

## glm = generalized linear model (above t-test)
mod = glm(data = dat_2,
          formula = cm ~ sex)

summary(mod)