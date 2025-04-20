library(tidyverse)
library(palmerpenguins)
penguins %>% 
  names()

bad_dat = penguins %>% 
  mutate(yearr = year + 20)

bad_dat

##one way
bad_dat[, -(ncol(bad_dat)-1)]
ncol(bad_dat)
nrow(bad_dat)

# Using tidyverse removing certain columns ####
bad_dat %>% 
  select(-c(island, sex, yearr)) %>% 
  View()

## to filter !is.na()

x = c(1, 2, 3, NA, 5, NA)
is.na(x)
!is.na(x)

##removes NA from the dataset ####
## save it to something for permanent changes####
x[!is.na(x)]

ggpolt(penguins)

## make a plot for fat penguins and their species
library(ggplot2)
?ggplot

dataaa = penguins
dataaa %>% 
  filter(!is.na(body_mass_g)) %>% 
  ggplot(aes(x = body_mass_g > 5000,
         y = species)) +
  geom_point
  
### Use this instead ####
penguins %>% 
  summary()

#### point graph ####
penguins %>% 
  filter(body_mass_g > 5000) %>% 
  ggplot(aes(x = body_mass_g,
             y = bill_length_mm,
             color = species)) +
  geom_point()

##### bar graph ####
penguins %>% 
  filter(body_mass_g > 5000) %>% 
  ggplot(aes(x = body_mass_g,
             color = species)) +
  geom_bar()

###### using group by ####
penguins %>% 
  filter(body_mass_g > 3000) %>% 
  group_by(species) %>% 
  summarize(mean_body_mass_g = mean(body_mass_g),
            sd_body_mass_g = sd(body_mass_g)) %>% 
  ggplot(aes(x = mean_body_mass_g)) +
  geom_bar(stat = 'identity')


penguins %>% 
  ggplot(aes(x = bill_length_mm,
             y = body_mass_g,
             color = species)) + 
  geom_point() +
  geom_smooth(method = 'lm', se = F)


####### changing color for color blindness ####
penguins %>% 
  ggplot(aes(x = bill_length_mm,
             y = body_mass_g,
             color = species)) + 
  geom_point() +
  scale_color_viridis_d()


####### manually changing color ####
penguins %>% 
  ggplot(aes(x = bill_length_mm,
             y = body_mass_g,
             color = species)) + 
  geom_point() +
  scale_color_manual(values = c('Gentoo' = 'pink', 'Adelie' = 'lightblue', 'Chinstrap'= 'black')) +
  theme_dark() +
  theme(axis.text = element_text(angle = 180, face = 'italic'))



## column graph
penguins %>% 
  ggplot(aes(x = flipper_length_mm,
             y = body_mass_g,
             fill = species)) +
  geom_col()


## side by side instead of stacked
penguins %>% 
  ggplot(aes(x = flipper_length_mm,
             y = body_mass_g,
             fill = species)) +
  geom_col(position = 'dodge')
