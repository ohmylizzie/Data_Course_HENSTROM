library(tidyverse)
library(janitor)
library(ggplot2)
library(easystats)

## Use the data set “/Data/GradSchool_Admissions.csv”
dat = read.csv("~/Desktop/BIOL3100/Data_Course_HENSTROM/Data/GradSchool_Admissions.csv")
View(dat)


mod = glm(data = dat,
          formula = as.logical(admit) ~ (gre + gpa) * rank,
          family = 'binomial')
summary(mod)
performance(mod)


mod2 = glm(data = dat,
           formula = as.logical(admit) ~ gre * gpa,
           family = 'binomial')
summary(mod2)
performance(mod2)


mod3 = glm(data = dat,
           formula = as.logical(admit) ~ (gre + rank) * gpa,
           family = 'binomial')
summary(mod3)
performance(mod3)


mod4 = glm(data = dat,
           formula = as.logical(admit) ~ (gre + rank) * gpa)
summary(mod4)
performance(mod4)

## class example

str(dat)
as.logical(dat$admit)
mod = glm(data = dat,
          formula = as.logical(admit) ~ gre + gpa + rank, 
          family = 'binomial')

## adds a new column to dat that is the predicted values
dat$pred_1 = predict(mod, dat, type = 'response')
View(dat)


mod2 = glm(data = dat,
           formula = as.logical(admit) ~ gre + gpa * rank,
           family = 'binomial')


dat$pred_2 = predict(mod2, dat, type = 'response')

compare_performance(mod, mod2) %>% 
  plot()

dat$pred_1 %>% 
  summary()


dat %>% 
  mutate(outcome = case_when(pred_1 < 0.2 ~ 'Not Admitted',
                             pred_1 >= 0.2 & pred_1 <= 0.4 ~ 'I dont know',
                             pred_1 > 0.4 ~ 'Admit')) %>% 
  mutate(accurate = case_when(admit == 1 & outcome == 'Admit' ~ TRUE,
                              admit == 0 & outcome == 'Not Admitted' ~ TRUE,
                              TRUE ~ FALSE)) %>% 
  pluck('accurate') %>% 
  sum()/nrow(dat)

## same as above! Just no piping
pred = dat %>% 
  mutate(outcome = case_when(pred_1 < 0.2 ~ 'Not Admitted',
                             pred_1 >= 0.2 & pred_1 <= 0.4 ~ 'I dont know',
                             pred_1 > 0.4 ~ 'Admit')) %>% 
  mutate(accurate = case_when(admit == 1 & outcome == 'Admit' ~ TRUE,
                              admit == 0 & outcome == 'Not Admitted' ~ TRUE,
                              TRUE ~ FALSE))
sum(pred$accurate)/nrow(pred)


## automatically chooses the best model
library(MASS)
stepAIC()

full_model = glm(data = dat,
                 formula = as.logical(admit) ~ gre*gpa*rank,
                 family = 'binomial')
full_model$formula
summary(full_model)
## finds the smallest AIC and the largest R2
stepwise_mod = stepAIC(full_model, direction = 'both') ## direction is both normally, so there is 
## no need to say both for direction
summary(stepwise_mod)
stepwise_mod$formula

best_model = glm(data = dat,
                 formula = stepwise_mod$formula,
                 family = 'binomial')
compare_performance(mod, mod2, best_model) %>% 
  plot()


## response fixes negative values
dat$pred_2 = predict(best_model, dat, type = 'response')
View(dat)

## with new stuff
dat %>% 
  mutate(outcome_2 = case_when(pred_2 < 0.2 ~ 'Not Admitted',
                               pred_2 >= 0.2 & pred_2 <= 0.4 ~ 'I dont know',
                               pred_2 > 0.4 ~ 'Admit')) %>% 
  mutate(accurate_2 = case_when(admit == 1 & outcome_2 == 'Admit' ~ TRUE,
                                admit == 0 & outcome_2 == 'Not Admitted' ~ TRUE,
                                TRUE ~ FALSE)) %>% 
  pluck('accurate_2') %>% 
  sum()/nrow(dat)

## separating data
library(caret)
createDataPartition()

id = createDataPartition(dat$admit, p = 0.8, list = F)
dat_train = dat[id, ]
dim(dat_train) # 360 6
dim(dat) # 400

dat_test = dat[id, ]

train_mod = glm(data = dat_train,
                formula = stepwise_mod$formula,
                family = 'binomial')

dat_test$pred = predict(train_mod, dat_test, type = 'response')
View(dat_test)
