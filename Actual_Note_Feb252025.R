library(ggmap)
library(leaflet)
library(ggplot2)
library(gapminder)
library(tidyverse)

geocode('Lisbon')


leaflet() %>% 
  addTiles() %>% 
  addMarkers(lng = -9.14, lat = 38.7)


dat_ex = data.frame(
  ID = c(1, 2, 3),
  Weight = c(78, 88, 100),
  Height = c(167, 180, 155)
)

data_ex = data.frame(
  ID = c(1, 2, 3),
  Weight = c(78, 88, 100),
  Height = c(167, 180, 155)
)

dat_ex %>% 
  pivot_longer(cols = c(Height, Weight)
               names_to = 'measure',
               values_to = 'value') %>% 
  View()

dat_ex %>% 
  pivot_longer(cols = everything()
               names_to = 'measure',
               values_to = 'value') %>% 
  View()

dat_wide = dat_ex %>% 
  pivot_longer(cols = -ID
               names_to = 'measure',
               values_to = 'value')



df = read_csv('Data/wide_income_rent.csv')
View(df)
# read this data and plot rent for each state
# make it good format for plotting
# hint: pivot_longer, pivot_wider
# x-axis = state, y-axis = rent, bar chart

df %>% 
  pivot_longer(cols = -variable, ##pivot longer except for variable column ####
               names_to = 'state',
               values_to = 'value') %>% 
  pivot_wider(names_from = 'variable',
              values_from = 'value') %>% 
  ggplot(aes(y = rent,
             x = income))+
  geom_point()+
  geom_text(aes(label = state))

##Ugly table2 data
table2
table2 %>% 
  pivot_wider(names_from = 'type', ## type has values that i want to put into two columns####
              values_from = 'count') ### count has values that correspond with cases and population in type####
## values from will remove the column "count" and assign corresponding values to cases and population


table3

table3 %>% 
  separate(rate, c('col1', 'col2'))


table4a
table4b


