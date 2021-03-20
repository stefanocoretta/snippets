library(ggplot2)
library(VGAM)

# Yule-Simon

ggplot() +
  aes(x = seq(1, 28)) +
  geom_point(aes(y = dyules(seq(1, 28), 4, log = FALSE))) +
  geom_line(aes(y = dyules(seq(1, 28), 4, log = FALSE))) +
  scale_x_log10() +
  scale_y_log10()

ggplot() +
  aes(x = log(seq(1, 28))) +
  geom_point(aes(y = dyules(seq(1, 28), 4, log = TRUE))) +
  geom_line(aes(y = dyules(seq(1, 28), 4, log = TRUE)))
