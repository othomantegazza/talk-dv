library(tidyverse)

svglite::svglite(here::here("img/arrow-left.svg"), bg = "#FFFFFF00")

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
  theme_void() +
  theme(plot.background = element_rect(fill = "#FFFFFF00"))

p %>% print()

dev.off()           

svglite::svglite(here::here("img/arrow-right.svg"), bg = "#FFFFFF00")

p_right <- 
  ggplot() +
  annotate(geom = "curve",
           x = 0,
           xend = -1,
           y = 0,
           yend = 1,
           curvature = .3,
           arrow = arrow(length = unit(6, units = "cm")),
           size = 5,
           colour = "#235596") +
  theme_void() +
  theme(plot.background = element_rect(fill = "#FFFFFF00")) +
  lims(y = c(NA, 1.05))

p_right %>% print()

dev.off()           
