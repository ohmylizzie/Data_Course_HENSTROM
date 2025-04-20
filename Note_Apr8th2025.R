library(tidyverse)
library(ggplot2)
library(janitor)
library(palmerpenguins)


glm()

## anova

names(palmer)

## special case of glm and has only one type of distribution
mod = aov(data = penguins,
          formula = body_mass_g ~ species + sex + year)
summary(mod)

## has many types of distribution like poisson, etc
mod_glm = glm(data = penguins,
          formula = body_mass_g ~ species)
summary(mod_glm)


## Different ammounts of ## increases font size

## look at r markdown preload stuff