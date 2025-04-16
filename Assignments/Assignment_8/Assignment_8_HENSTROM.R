library(tidyverse)
library(ggplot2)
library(easystats)
library(broom)
library(fitdistrplus)
library(MASS)
library(caret)


## loads the “/Data/mushroom_growth.csv” data set
mush = read.csv("~/Desktop/BIOL3100/Data_Course_HENSTROM/Data/mushroom_growth.csv")
View(mush)

## creates several plots exploring relationships between the response and predictors
names(mush)
graph_1 = mush %>% 
  ggplot(aes(x = Humidity,
             y = GrowthRate,
             color = Species)) +
  geom_point()
plot(graph_1)

graph_2 = mush %>% 
  ggplot(aes(x = Temperature,
             y = GrowthRate,
             color = Humidity)) +
  geom_point() +
  facet_wrap(~ Species)
plot(graph_2)

graph_3 = mush %>% 
  ggplot(aes(x = Light,
             y = GrowthRate,
             color = Species)) +
  geom_point()
plot(graph_3)

graph_4 = mush %>% 
  ggplot(aes(x = Nitrogen, y = GrowthRate)) +
  geom_point() +
  geom_smooth(method = "loess") +
  labs(title = "Growth Rate vs Nitrogen")
plot(graph_4)

## defines at least 4 models that explain the dependent variable “GrowthRate”
mod_1 = glm(data = mush,
            formula = GrowthRate ~ Light)
summary(mod_1)
performance(mod_1)


mod_2 = glm(data = mush,
            formula = GrowthRate ~ Temperature)
summary(mod_2)
performance(mod_2)


mod_3 = glm(data = mush,
            formula = GrowthRate ~ (Species + Light) * Temperature)
summary(mod_3)
performance(mod_3)


mod_4 = glm(data = mush,
            formula = GrowthRate ~ Light)
summary(mod_4)
performance(mod_4)


mod_5 = aov(data = mush,
          formula = GrowthRate ~ Species + Humidity)
summary(mod_5)
performance(mod_5)


mod_6 = aov(data = mush,
            formula = GrowthRate ~ Humidity + Nitrogen + Light + Temperature + Species)
performance(mod_6)


mod_7 = glm(data = mush,
            formula = GrowthRate ~ Humidity + Nitrogen + Light + Temperature + Species)
performance(mod_7)

## calculates the mean sq. error of each model
mse_1 = mean(mod_1$residuals^2)
mse_2 = mean(mod_2$residuals^2)
mse_3 = mean(mod_3$residuals^2)
mse_4 = mean(mod_4$residuals^2)
mse_5 = mean(mod_5$residuals^2)
mse_6 = mean(mod_6$residuals^2)
mse_7 = mean(mod_7$residuals^2)

mse_df = tibble(Model = paste0("mod_", 1:7),
  MSE = c(mse_1, mse_2, mse_3, mse_4, mse_5, mse_6, mse_7))


## selects the best model you tried
full_model = glm(data = mush,
                 formula = GrowthRate ~ Species + Nitrogen + Light + Humidity +
                   Temperature)
full_model$formula
summary(full_model)
performance(full_model)

stepwise_mod = stepAIC(full_model, direction = 'both')
summary(stepwise_mod)
performance(stepwise_mod)
stepwise_mod$formula

best_model = glm(data = mush,
                 formula = stepwise_mod$formula)
performance(best_model)

compare_performance(mod_1, mod_2, mod_3, mod_4, mod_5, mod_6, mod_7, 
                    best_model) %>% 
  plot()

## adds predictions based on new hypothetical values for the independent 
## variables used in your model
id = createDataPartition(mush$GrowthRate, p = 0.8, list = FALSE)
train_data = mush[id, ]
test_data = mush[-id, ]

train_model = glm(data = train_data,
                  formula = stepwise_mod$formula)

test_data$predicted_GrowthRate = predict(train_model, newdata = test_data)
test_data$predicted_GrowthRate = ifelse(test_data$predicted_GrowthRate < 0, 0,
                                        test_data$predicted_GrowthRate)

View(test_data)
performance(train_model)

## looking at MSE training and testing data fo fun
mse_train = mean(train_model$residuals^2)

mse_test = mean((test_data$GrowthRate - test_data$predicted_GrowthRate)^2)

mse_train
mse_test

## plots these predictions alongside the real data

# Plot: Actual vs Predicted Growth Rate

SSE = sum((test_data$GrowthRate - test_data$predicted_GrowthRate)^2)
SST = sum((test_data$GrowthRate - mean(test_data$GrowthRate))^2)
fit_val = 1 - (SSE / SST)


test_data %>% 
  ggplot(aes(x = GrowthRate, y = predicted_GrowthRate, color = Species)) +
  geom_point(alpha = 0.7, size = 3) +
  geom_smooth(method = "lm", se = FALSE, color = "navyblue", linetype = "dashed") +
  labs(
    title = "Actual vs Predicted Growth Rate",
    subtitle = paste0("R² = ", round(fit_val, 3)),
    x = "Actual Growth Rate",
    y = "Predicted Growth Rate"
  ) +
  theme_minimal() +
  theme(legend.position = "bottom")
