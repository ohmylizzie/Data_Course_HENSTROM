## Redoing Exam_2!



library(dplyr)
library(tidyverse)
library(janitor)
library(ggplot2)
library(easystats)

dat = read.csv("~/Desktop/BIOL3100/Data_Course_HENSTROM/Exam_2/unicef-u5mr.csv",
               check.names = FALSE)

dat = janitor::clean_names(dat)
View(dat)

# Make long data, remove the u5mr. and replace it with year and deaths

## Tasks 1-3
long_dat = dat %>% 
  pivot_longer(cols = starts_with('u5mr_'),
               names_to = 'year',
               values_to = 'deaths') %>% 
  drop_na(deaths) %>% 
  mutate(year = as.numeric(str_remove(year, "u5mr_")))
View(long_dat)


uni_dat = long_dat %>% 
  ggplot(aes(x = year,
             y = deaths,
             group = country_name)) +
  geom_line() +
  facet_wrap(~ continent) +
  labs(x = "Year",
       y = "U5MR") +
  theme_bw()
plot(uni_dat)

## Task 4

ggsave("HENSTROM_Plot_1.png")


## Task 5 

new_uni_dat = long_dat %>% 
  group_by(continent, year) %>% 
  summarise(mean_u5mr = mean(deaths, na.rm = TRUE)) %>% 
  ggplot(aes(y = mean_u5mr,
             x = year,
             color = continent)) +
  geom_line(size = 2) +
  labs(x = "Year",
       y = "Mean_U5MR") +
  theme_bw()
plot(new_uni_dat)


## Task 6

ggsave("HENSTROM_Plot_2.png")

## Task 7

mod1 = glm(data = long_dat,
           formula = deaths ~ year)
summary(mod1)




mod2 = glm(data = long_dat,
           formula = deaths ~ year + continent)
summary(mod2)




mod3 = glm(data = long_dat,
           formula = deaths ~ year * continent)
summary(mod3)

compare_parameters(mod1, mod2, mod3)

## Task 8

performance(mod1)
performance(mod2)
performance(mod3)
## According to the R2 values, mod3 would be best. This means that 
## the interaction of both the year and continent had more of a linear
## effect on the deaths than any of the other models. This means that the year,
## or using both the year and continent as predictors.

## Task 9 

longer_dat = long_dat %>%
  mutate(pred_mod1 = predict(mod1, newdata = long_dat, type = 'response'),
         pred_mod2 = predict(mod2, newdata = long_dat, type = 'response'),
         pred_mod3 = predict(mod3, newdata = long_dat, type = 'response')) %>% 
  pivot_longer(cols = starts_with('pred_'),
               names_to = 'model',
               values_to = 'pred_deaths')


three_graphs = longer_dat %>% 
  ggplot(aes(x = year,
             y = pred_deaths,
             color = continent)) +
  geom_line(size = 2) +
  facet_wrap(~ model) +
  labs(title = "Model predictions",
       x = "Year",
       y = "Predicted U5MR") +
  theme_bw()
plot(three_graphs)


ggsave("Model_Predictions.png")



## Extra Credit

ecuador_dat = longer_dat %>% 
  filter(country_name == "Ecuador")

pred_ecuador = data.frame(continent = factor("Americas",
                                             levels = unique(long_dat$continent)),
                          year = 2020,
                          country_name = "Ecuador")

pred_u5mr_2020 = predict(mod3,
                         newdata = pred_ecuador, type = "response")

pred_ecuador = pred_ecuador %>%
  mutate(pred = pred_u5mr_2020)
## Close but also negative value for deaths

mod4 = glm(data = long_dat,
           formula = deaths ~ poly(year, 2) * continent)

pred_u5mr_2020_mod4 = predict(mod4,
                              newdata = pred_ecuador,
                              type = "response")

mod5 = glm(data = long_dat, 
           formula = sqrt(deaths) ~ year * continent)

pred_u5mr_2020_mod5 = predict(mod5, newdata = pred_ecuador,
                              type = "response")

mod6 = glm(data = long_dat,
           formula = log(deaths) ~ year * continent)

pred_u5mr_2020_mod6 = predict(mod6,
                              newdata = pred_ecuador,
                              type = "response")


ecuador_newdat = ecuador_dat %>% 
  filter(country_name == "Ecuador") %>%
  slice(1) %>%
  mutate(year = 2020, 
         continent = factor("Americas", levels = unique(long_dat$continent))) %>%
  mutate(pred_mod3 = predict(mod3, newdata = .,
                             type = "response"),
         pred_mod4 = predict(mod4, newdata = .,
                             type = "response"),
         pred_mod5 = predict(mod5, newdata = .,
                             type = "response")^2,
         pred_mod6 = exp(predict(mod6, newdata = .,
                                 type = "response")),
         actual = 13) %>% 
  select(-deaths, -pred_deaths)
View(ecuador_newdat)

## I got pretty close to the 13! mod4 got me to 14 by itself. However, if I
## back-transform the other models, I can get mod6 pretty close to the actual
## value. It has predicted deaths = ~ 12.