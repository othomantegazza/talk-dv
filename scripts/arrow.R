library(tidyverse)

svglite::svglite(here::here("img/arrow.svg"))

p <- 
  ggplot() +
  annotate(geom = "curve",
           x = 0,
           xend = -1,
           y = 0,
           yend = 1,
           curvature = -.3,
           arrow = arrow(length = unit(6, units = "cm")),
           size = 5,
           colour = "#235596") +
  theme_void()

p %>% print()

dev.off()           