library(tidyverse)
theme_set(theme_minimal())
library(ggrepel)

formants <- tibble(
  f1 = c(300, 400, 600, 380, 430, 420, 250, 800, 250),
  f2 = c(550, 1970, 1915, 1560, 2350, 2250, 2400, 1500, 600),
  rec = c(1, 2, 3, 4, 5, 6, "i", "a", "u")
)

cardinal <- c("black", "black", "black", "black", "black", "black", "red", "red", "red")

formants %>%
  ggplot(aes(f2, f1, label = rec)) +
  geom_point(colour = cardinal) +
  geom_label_repel(colour = cardinal) +
  scale_x_reverse(limits = c(2500, 400)) +
  scale_y_reverse(limits = c(1000, 200)) +
  labs(caption = "Red vowels are average cardinal vowels that act as reference points.")

ggsave("./nalo-vowels.png", width = 7, height = 5)
