library(tidyverse)
library(ggplot2)
library(gganimate)
library(ggimage)
library(tuneR)
library(magick)

img <- magick::image_read("justin_bieber_baby.jpg")

img_raster <- as.raster(img)

mtcars_animated <- mtcars %>%
  rownames_to_column("car") %>%
  mutate(frame = rep(1:3, length.out = n()))

emoji_url <- "https://emojicdn.elk.sh/👶"

p <- mtcars_animated %>%
  ggplot(aes(x = cyl, y = mpg, image = emoji_url)) +
  annotation_raster(img_raster, -Inf, Inf, -Inf, Inf) + # Use the correctly converted raster
  geom_image(size = 0.08) +
  theme(
    panel.background = element_rect(fill = "transparent"),
    plot.background = element_rect(fill = "deeppink"),
    axis.text = element_text(color = "mediumvioletred", face = "bold.italic", angle = 45, size = 10),
    axis.title = element_text(color = "cyan", face = "bold", size = 14),
    plot.title = element_text(color = "blue2", face = "bold", size = 18),
    legend.position = "none"
  ) +
  labs(
    title = "For the Beliebers",
    x = "Wish You Could Always Be Mineeeeeeeee",
    y = "Baby, Baby, Baby, Nooo"
  ) +
  transition_states(frame, transition_length = 3, state_length = 2) +
  enter_fly(x_loc = 10, y_loc = -10) +
  exit_shrink()

animate(p, nframes = 50, fps = 5, width = 800, height = 600)

anim_save("justin_bieber_mtcars_baby.gif")
anim_save("justin_bieber_mtcars_baby_frame5.jpg", animate(p, nframes = 50, fps = 5, width = 800, height = 600)[5])

# Audio
if (file.exists("Baby_Justin_Bieber.mp3")) {
  readMP3("Baby_Justin_Bieber.mp3") %>%
    writeWave("Baby_Justin_Bieber.wav")
} else {
  print("Whoopsie, you don't have the audio. You are not a true Belieber!!!")
}