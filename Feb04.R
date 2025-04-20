getwd()
setwd('Data/')
View(iris)

iris$Sepal.Length = as.character(iris$Sepal.Length)
str(iris)
names(iris)

for (col in names(iris)) {
  iris[, col] = as.character(iris[, col])
}


iris[, 1]
str(iris)

library(tidyverse)
library(palmerpenguins)

##View(penguins)
##vec = penguins

##dat <- penguins %>% 
  filter(body_mass_g > 5000) %>% 
  View()
  
  
# exercise for today####
## find the fatty penguins (body mass > 5000)
## Count many male and female
## return the body mass for male and female
## add new column to penguins to dataset that says whether they're fat
penguins %>% 
  filter(body_mass_g > 5000) %>% 
  group_by(sex) %>% 
  summarize(count = n(),
            fattest = max(body_mass_g))
  

##just in case there is anything that is N/A
max(penguins$body_mass_g, na.rm = T)


dat = penguins

dat$fat_state = dat$body_mass_g > 5000
View(dat)

## or (mutate means to add a column) ####
penguins %>%
  mutate(fattiesss = body_mass_g > 5000) %>% 
  View()

dat_peng = penguins %>%
  mutate(fattiesss = case_when(body_mass_g > 5000 ~ 'fat',
                               body_mass_g <= 5000 &body_mass_g > 3000 ~ 'medium',
                               TRUE ~ 'skinny'))
  ## remove View() if you wanna not have the vector = NULL
## making a plot ####
library(ggplot2)
plot(dat_peng$bill_length_mm, dat_peng$body_mass_g)

## without tidyverse
ggplot(data = dat_peng)

## or with tidyverse (but no dots yet, sadddd)

dat_peng %>% 
  filter(!is.na(sex)) %>% ## removing NA
  ggplot(aes(x = bill_length_mm,
             y = body_mass_g,
             color = sex,
             shape = fattiesss)) + 
  geom_point() +
  geom_smooth()