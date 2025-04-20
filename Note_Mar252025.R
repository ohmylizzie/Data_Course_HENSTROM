library(ggplot2)
library(tidyverse)
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







## new #### 
# statistical analysis 
# car_insurance_price = age + gender + education ... 

### lm() means linear model for continuous data, glm() does more jobs and multiple things
## now the independent variable becomes t/f. you need to use glm() to set these conditionals



# build a model to predict cty (mpg in city, the dependent variable) 
# as a function of displ (total volume of engine, the independent variable)
mpg

mpg %>% 
  ggplot(aes(x = displ,
             y = cty)) +
  geom_point() +
  geom_smooth(method = 'glm', se = F)

# with formula = dependent ~ independent
mod = glm(data = mpg,
          formula = cty ~ displ)

summary(mod)


# model formula is now cty = 25.99 + (-2.63)*displ




str(mod)
mod$model
mod$formula
mod$coefficients
mod$fitted.values



plot(mod$model$cty, mod$fitted.values)


cor.test(mod$model$cty, mod$fitted.values)


library(easystats)
report(mod)
performance(mod)
check_model(mod)

names(mpg)
mod2 = glm(data = mpg,
          formula = cty ~ displ + manufacturer)
summary(mod2)


mod3 = glm(data = mpg,
          formula = cty ~ displ + manufacturer + model + year + trans + drv + hwy + fl)
summary(mod3)
performance(mod3)

# + adds another factor to the model

mod4 = glm(data = mpg,
           formula = cty ~ displ * cyl)
summary(mod4)


mpg %>% 
  ggplot(aes(x = displ,
             y = cty)) +
  geom_smooth(method = 'glm')


mpg %>% 
  ggplot(aes(x = displ,
             y = cty,
             color = factor(cyl))) +
  geom_smooth(method = 'glm')



compare_models(mod4, mod3, mod)

# the model that you want to use hits most of the points on the graph
compare_performance(mod4, mod3, mod) %>% 
  plot()


predict(mod, mpg)
mod$formula



plot(mod$fitted.values, predict(mod, mpg))


range(mpg$displ)

mpgg = mpg

dat_displ$pred = predict(mod, dat_displ)

mpgg$pred1 = predict(mod, mpg)

mpgg %>% 
  ggplot(aes(x = cty,
             y = pred1)) +
  geom_point()


mpgg %>% 
  pivot_longer(starts_with('pred'),
               names_to = 'prediction',
               values_to = 'city_mpg') %>% 
  ggplot(aes(x = displ,
             y = cty,
             color = factor(cyl))) +
  geom_point() +
  geom_point(aes(y = city_mpg), 
             color = 'black')+
  facet_wrap(~ prediction)

mod$formula
mod2$formula
mod4$formula


## make your model 5 and compare with all other models and make a prediction

mod5 = glm(data = mpg,
           formula = cty ~ model + fl)
summary(mod5)
