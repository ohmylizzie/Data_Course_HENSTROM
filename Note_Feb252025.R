library(ggplot2)
library(gganimate)
library(ggthemes)
library(ggimage)
library(tuneR)
set.seed(123)
# Random data with no real correlation
data <- data.frame(
  x = rnorm(100),
  y = rnorm(100),
  frame = rep(1:10, each = 10),
  image = "https://emojicdn.elk.sh/👶" # Baby emoji as point
)

# Making the absolute worst animated plot
p <- ggplot(data, aes(x, y, image = image)) +
  geom_image(size = 0.1) +                         # Baby emojis instead of points
  theme_economist_white(base_size = 40) +          # Inappropriate theme
  theme(
    plot.background = element_rect(fill = "#FFD700"), # Blinding gold background
    panel.grid.major = element_line(color = "#8B0000", linetype = "twodash", size = 3),
    panel.grid.minor = element_line(color = "#00FF00", linetype = "longdash", size = 2),
    axis.text = element_text(color = "#FF00FF", face = "bold.italic", angle = 45),
    axis.title = element_text(color = "#00FFFF", face = "bold", size = 35)
  ) +
  labs(
    title = "THE ABSOLUTE WORST ANIMATED GRAPH EVER", # Even more over-the-top title
    x = "X-AXIS THAT MAKES NO SENSE",                 # Nonsensical label
    y = "Y-AXIS THAT'S PAINFUL TO READ"               # Even more painful label
  ) +
  transition_states(frame, transition_length = 5, state_length = 3) +
  enter_fly(x_loc = 10, y_loc = -10) + exit_shrink()  # Still unnecessary, but valid effects

# Saving this visual disaster
animate(p, nframes = 200, fps = 2, width = 1000, height = 800)

# Displaying the chaos
anim_save("absolute_worst_animation.gif")

# Slowing down "Baby" by Justin Bieber with tuneR
baby_song <- readMP3("Baby_Justin_Bieber.mp3")
slowed_baby <- stretch(baby_song, 0.5) # Slow down by 50%
writeWave(slowed_baby, "Slowed_Baby_Justin_Bieber.wav")

# Now play this cursed track while viewing the graph
