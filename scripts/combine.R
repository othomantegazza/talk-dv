library(tidyverse)

calvin <-
  read_csv(here::here("data/calvin.csv")) %>% 
  mutate(y = y*1.3,
         x = x*1.3,
         x = x - 20,
         y = y+300)
hobbes <- read_csv(here::here("data/hobbes.csv"))

bind_rows(calvin, hobbes) %>% 
  ggplot(aes(x = x,
             y = max(y) - y)) +
  # geom_smooth(method = "lm") +
  # geom_smooth() +
  geom_point(size = .5,
             alpha = 1) +
  # geom_rug() +
  # scale_y_reverse() +
  coord_fixed() +
  lims(x = c(0, 1100),
       y = c(0, NA)) +
  theme_bw()

