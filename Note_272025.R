library(tidyverse)
library(janitor)
library(ggplot2)
library(gganimate)
library(palmerpenguins)
library(easystats)


## does body weight (dependent) vary significantly between penguin species (independent)
penguins

mod = glm(data = penguins,
          formula = body_mass_g ~ species)
## Adelie penguin is the 'intercept'

summary(mod)
performance(mod)

  
dat_peng = penguins
  
dat_peng$species = relevel(dat_peng$species, ref = 'Gentoo')

dat_peng$species = factor(dat_peng$species, levels = c('Gentoo', 'Chinstrap', 'Adelie'))
mod = glm(data = dat_peng,
          formula = body_mass_g ~ species)

summary(mod)

names(dat_peng)
View(dat_peng)

dat_p = dat_peng %>% 
  mutate(gentoo = case_when(species == 'Gentoo' ~ TRUE,
                            TRUE ~ FALSE))
glm(data = dat_p,
    formula = gentoo ~ bill_depth_mm + bill_length_mm + flipper_length_mm + body_mass_g,
      family = 'binomial') 

## this is the pipe version for tidyverse
dat_peng %>%
  mutate(gentoo = case_when(species == 'Gentoo' ~ TRUE,
                            TRUE ~ FALSE)) %>% 
    glm(data = .,
    formula = gentoo ~ bill_depth_mm + bill_length_mm + flipper_length_mm + body_mass_g,
    family = 'binomial') 



mod = glm(data = dat_p,
          formula = gentoo ~ bill_depth_mm + bill_length_mm + flipper_length_mm + body_mass_g,
          family = 'binomial') 

predict(mod, dat_p)
# probability for a penguin to be a gentoo penguin
predict(mod, dat_p, type = 'response')
View(dat_p)

dat_p <- dat_p %>% 
  mutate(predict(mod,dat_p, type = 'response'))

dat_p %>% 
  ggplot(aes(x = body_mass_g,
             y = pred,
             color = species)) +
  geom_point()


pred = dat_p %>% 
  mutate(outcome = case_when(pred < 0.01 ~ 'Not Gentoo',
                             pred > 0.75 ~ 'Gentoo')) %>% 
  select(species, outcome) %>% 
  mutate(accurate = case_when(species == 'Gentoo' & outcome == 'Gentoo' ~ TRUE,
         species != 'Gentoo' & outcome == 'Not Gentoo' ~ TRUE,
         TRUE ~ FALSE))


## how accurate is the model
pred %>% 
  pluck('accurate') %>% 
  sum()/nrow(pred)


## Data/GradSchool_Admission.csv
## build a logical regression model and predict the admission of grad school


dat = read.csv("Data/GradSchool_Admissions.csv")
View(dat)


# : is interaction
# cyl * displ = cyl + displ + cyl:displ

as.logical(dat$admit)
names(dat)


mod3 = glm(data = dat,
           formula = as.logical(admit) ~ (gre + gpa) * rank,
           family = 'binomial')

# main effect: gre, gpa, rank
# interaction: gre:rank, gpa:rank

