library(tidyverse)
library(ggplot2)
library(easystats)
library(broom)
library(fitdistrplus)
library(MASS)
library(caret)

dat = read.csv("~/Desktop/BIOL3100/Data_Course_HENSTROM/Data/non_linear_relationship.csv")
View(dat)

model_poly <- lm(y ~ poly(x, 2, raw = TRUE), data = dat)

# Summarize the model
summary(model_poly)

# Plot the data and the fitted curve
dat %>% 
  ggplot(aes(x = predictor, y = response)) +
  geom_point() +
  stat_smooth(method = "lm", formula = y ~ poly(x, 2, raw = TRUE), se = FALSE, color = "navyblue") +
  labs(title = "Polynomial Regression Fit", x = "Predictor", y = "Response") +
  theme_minimal()
