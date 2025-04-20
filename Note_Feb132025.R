## make a plot with 'flipper_length' on the x axis
## and 'body mass' on y axis 

library(tidyverse)
library(ggplot2)
library(palmerpenguins)

names(penguins)

penguins %>% 
  ggplot(aes(x = flipper_length_mm,
             y = body_mass_g,
             fill = island)) +
  geom_col(position = "dodge")
  


penguins %>% 
  filter(!is.na(flipper_length_mm)) %>% 
  filter(!is.na(body_mass_g)) %>% 
  ggplot(aes(x = flipper_length_mm,
             y = body_mass_g,
             fill = species)) + #fill fills inside of the lines####
  geom_path() +
  geom_point() +
  stat_ellipse() +
  geom_bin2d()



penguins %>% 
  filter(!is.na(flipper_length_mm)) %>% 
  filter(!is.na(body_mass_g)) %>% 
  ggplot(aes(x = flipper_length_mm,
             color = species)) + ##color outlines in a color####
  geom_density()


penguins %>% 
  filter(!is.na(flipper_length_mm)) %>% 
  filter(!is.na(body_mass_g)) %>% 
  ggplot(aes(x = flipper_length_mm,
             fill = species)) + 
geom_histogram(binwidth = 10,alpha = 0.75) ###shows a distribution, and alpha means transparency####


my_plot = penguins %>% 
  filter(!is.na(flipper_length_mm)) %>% 
  filter(!is.na(body_mass_g)) %>% 
  ggplot(aes(x = flipper_length_mm,
             y = body_mass_g,
             color = species)) + 
  geom_point()

my_plot

my_2nd_plot = my_plot + stat_ellipse()

my_2nd_plot


ggsave("cool_plot.jpg", plot = my_2nd_plot,
       width = 6, height = 8, dpi = 72) #### save as jpg ####
# 6*72
# 8*72
#this is how many dots per inch
## you can also change the units be saying unit = ""




## load DatasaurusDozen.tsv
setwd('~/Desktop/BIOL3100/Data_Course_HENSTROM/Data')
getwd()
read_tsv('DatasaurusDozen.tsv')

##### orrrrr ####
setwd('~/Desktop/BIOL3100/Data_Course_HENSTROM')
dat = read_tsv('Data/DatasaurusDozen.tsv')
head(dat)

dat_2 = read.delim('Data/DatasaurusDozen.tsv') ##### tab delimited ####
str(dat)
str(dat_2)

summary(dat_2$y)

dat_2 %>% 
  group_by(dataset) %>% 
  summarise(mean = mean(x),
            sd = sd(x),
            max = max(x),
            min = min(x))



dat_2 %>% 
  ggplot(aes(x = x,
              fill = dataset)) +
  geom_density()


dat_2 %>% 
  ggplot(aes(x = x,
             y = y)) +
  geom_point() +
  facet_wrap(~ dataset) #separates graph into subcatagories



install.packages('GGally')
library(GGally)            ###### different way to graph ####
ggpairs(penguins)
ggpairs(dat_2)

## download gapminder
# use filter
# use facet_wrap