install.packages("gapminder")
install.packages("ggimage")
install.packages("gganimate")
library(gganimate)
library(patchwork)
library(gapminder)
library(tidyverse)
library(palmerpenguins)
library(patchwork)

df = gapminder

p3 = df %>% 
  ggplot(aes(x = gdpPercap,
             y = lifeExp,
             color = continent)) +
  geom_point()

df$year %>%  range
df$year %>% unique()


p3 = df %>% 
  ggplot(aes(x = gdpPercap,
             y = lifeExp,
             color = continent)) +
  geom_point()

df$year %>%  range
df$year %>% unique()

 p3 = df %>% 
  ggplot(aes(x = year,
             y = lifeExp,
             color = pop)) +
  geom_point(aes(size = pop)) +
  facet_wrap(~ continent)

p3 + transition_time(time = year) +
  labs(title = 'Year')

p3 + transition_time(time = year) +
  labs(title = 'Year:{frame_time}')

ggsave()

anim_save('gganimate.gif')

df$country %>% unique()
my_country = c("China", "Malaysia", "Singapore", "Japan", "Nepal", "Iceland", "Uganda", "Cote d' Ivoire", "Rwanda")

df2 <- df %>% 
  mutate(my_countries = case_when(country %in% my_country ~ country)) %>% 
  View()


p5 = df2 %>% 
  ggplot(aes(x = gdpPercap, 
             y = lifeExp,
             color = continent)) +
  geom_point() + 
  geom_text(aes(label = my_countries))

p5 + transition_time(time = year) +
  labs(title = 'Year:{frame_time}')

## saves the animation from a dataset ####
anim_p5 = p5 + transition_time(time = year) +
  labs(title = 'Year:{frame_time}')

anim_save('anim.gif', animation = anim_p5)

### to make a map ####
install.packages("ggmap")
library(ggmap)




df = read_csv('Data/wide_income_rent.csv')
#read this data and plot rent for each state
# x -axis = state, y-axis = rent, bar chart
View(df)

## plotting this doesn't work because it doesnt have a name. it is a bad data input
df %>% 
  ggplot(aes(x = state,
             y = rent)) +
  geom_bar()

# everything becomes skinnier
?pivot_longer
#everything becomes wider?
?pivot_wider

ex = data.frame(
  ID = c(1, 2, 3),
  Weight = c(78, 88, 100),
  Height = c(167, 180, 155)
)

dat_ex %>% 
  pivot_longer()
