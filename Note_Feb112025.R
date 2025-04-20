library(tidyverse)
library(palmerpenguins)
library(ggplot2)

## rm(list = ls()) is to remove things

penguins %>% 
  ggplot(aes(x = species)) +
  geom_bar(stat = 'count') ##default

## Plots out the count ####
penguins %>% 
  ggplot(aes(x = species, 
             y = body_mass_g)) +
  geom_bar(stat = 'identity')

### Col summarizes ####
penguins %>% 
  ggplot(aes(x = species, 
             y = body_mass_g)) +
  geom_col() #default = stacked


# getting better plots... ####
penguins %>% 
  ggplot(aes(x = species, 
             y = body_mass_g)) +
  geom_col(position = 'dodge')


penguins %>% 
  group_by(species) %>% 
  summarize(avg_mass = mean(body_mass_g, na.rm = T))


#### dodge stacks data and separates them ####
penguins %>% 
  ggplot(aes(x = species, fill = island)+
  geom_bar(stat = 'count', position = 'dodge'))



penguins %>% 
  group_by(species) %>% 
  summarize(avg_mass = mean(body_mass_g, na.rm = T)) %>% 
  ggplot(aes(x = species, y = avg_mass)) +
  geom_col()

##or

penguins %>% 
  group_by(species) %>% 
  summarize(avg_mass = mean(body_mass_g, na.rm = T)) %>% 
  ggplot(aes(x = species,
             y = avg_mass)) +
  geom_bar(stat = 'identity')


##### error bars ####
penguins %>% 
  group_by(species) %>% 
  summarize(avg_mass = mean(body_mass_g, na.rm = T),
            sd = sd(body_mass_g, na.rm = T)) %>% 
  ggplot(aes(x = species, y = avg_mass)) +
  geom_bar(stat = 'identity') + 
  geom_errorbar(aes(ymin = avg_mass - sd,
                    ymax = avg_mass + sd),
                width = 0.15)


## making an interesting graph for penguins data
## DO NOT use geom_point()

penguins %>% 
  group_by(island) %>% 
  summarize(avg_bill_length = mean(bill_length_mm, na.rm =T)) %>% 
  ggplot(aes(x = avg_bill_length)) +
  geom_freqpoly() +
  scale_color_manual(values = c('avg_bill_length' = 'darkred')) +
                       theme_dark()


penguins %>% 
  filter(!is.na(body_mass_g)) %>% 
  ggplot(aes(x = body_mass_g, fill = species)) + 
  geom_density(alpha = 0.7)


##### Don't hide data!!! ####
penguins %>% 
  filter(!is.na(body_mass_g)) %>% 
  ggplot(aes(x = body_mass_g, y = species)) + 
  geom_boxplot() +
  geom_point() +
  geom_jitter()


penguins %>% 
  filter(!is.na(body_mass_g)) %>% 
  ggplot(aes(x = body_mass_g, y = species)) + 
  geom_boxplot() +
  geom_jitter()


penguins %>% 
  filter(!is.na(body_mass_g)) %>% 
  ggplot(aes(x = factor(year), y = body_mass_g)) +
  geom_boxplot() +
  geom_jitter()

str(penguins)



install.packages('qrcode')
library(qrcode)
url = 'https://gzahn.github.io/data-course/Repository/Assignments/Assignment_1/Assignment_1.html'
qr = qrcode::qr_code(url)
plot(qr)
