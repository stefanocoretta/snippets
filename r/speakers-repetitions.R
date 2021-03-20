sprep <- tibble(
  speak = seq(10, 100),
  rep = 300 / speak
)

ggplot(sprep, aes(speak, rep)) +
  geom_ribbon(aes(x = ifelse(speak > 29 & speak < 61 , speak, NA), ymin = -Inf, ymax = rep), alpha = 0.2) +
  geom_point() +
  annotate("segment", x = 30, xend = -Inf, y = 10, yend = 10) +
  annotate("segment", x = 30, xend = 30, y = 10, yend = -Inf) +
  annotate("segment", x = 60, xend = -Inf, y = 5, yend = 5) +
  annotate("segment", x = 60, xend = 60, y = 5, yend = -Inf) +
  scale_x_continuous(breaks = seq(10, 100, 10)) +
  scale_y_continuous(breaks = seq(0, 40, 5))
