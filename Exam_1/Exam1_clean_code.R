getwd()
setwd('Exam_1')
library(tidyverse)
library(ggplot2)

cleaned_covid_data = read_csv('cleaned_covid_data.csv')

A_states = cleaned_covid_data %>% 
  filter(grepl('A', Province_State))


A_states %>% 
  ggplot(aes(y = Deaths,
             x = Last_Update)) +
  geom_point()+
  geom_smooth(method = 'loess', se = F) +
  facet_wrap(~ Province_State, scales = 'free') +
  theme_classic()

#state_max_fatality_rate 
state_max_fatality_rate = cleaned_covid_data %>% 
  group_by(Province_State) %>% 
  summarise(Maximum_Fatality_Ratio = max(Case_Fatality_Ratio, na.rm = T),
            count = n()) %>% 
  arrange(desc(Maximum_Fatality_Ratio))

state_max_fatality_rate %>% 
  ggplot(aes(x = Province_State,
             y = Maximum_Fatality_Ratio)) +
  geom_col()

# mutate means add a new column ####
## factor sorts something based on levels ####
### levels means to sort based on unique categories in a specific column ####
state_max_fatality_rate %>%
  mutate(Province_State = factor(Province_State, levels = state_max_fatality_rate$Province_State)) %>%
  ggplot(aes(x = Province_State,
             y = Maximum_Fatality_Ratio,
             fill = Maximum_Fatality_Ratio,
             color = Maximum_Fatality_Ratio)) +
  geom_col(color = "black") +
  scale_fill_gradient(low = "lavender", high = "pink") +
  theme(axis.text.x = element_text(angle = 90))


##Using the FULL data set, plot cumulative deaths for the entire US over time##

## You'll need to read ahead a bit and use the dplyr package functions group_by() and summarize() to accomplish this.

cumulative_unalived_over_time = cleaned_covid_data %>% 
  group_by(Last_Update) %>% 
  summarise(Deaths_Per_Day = sum(Deaths, na.rm = T))

cumulative_unalived_over_time %>% 
  ggplot(aes(y = Deaths_Per_Day,
             x = Last_Update,
             fill = Deaths_Per_Day)) +
  geom_col() +
  scale_fill_gradient(low = "yellow1", high = "darkorchid") + 
  theme_linedraw()

