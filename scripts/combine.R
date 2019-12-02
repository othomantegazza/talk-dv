library(tidyverse)
library(svglite)

theme_set(theme_minimal())

calvin <-
  read_csv(here::here("data/calvin.csv")) %>% 
  mutate(y = y*1.3,
         x = x*1.3,
         x = x - 20,
         y = y+300)
hobbes <- read_csv(here::here("data/hobbes.csv"))


tiger_attack <- 
  bind_rows(calvin, hobbes)

p <- 
  tiger_attack %>% 
  ggplot(aes(x = x,
             y = max(y) - y))  +
  lims(x = c(0, 1100),
       y = c(0, NA)) +
  coord_fixed() 

p1 <- 
  p +
  geom_smooth(colour = "#235596", method = "lm")

p2 <- 
  p +
  geom_smooth(colour = "#fc8f0033", method = "lm") +
  geom_smooth(colour = "#235596", method = "lm", formula = y ~ poly(x, 2))

p3 <- 
  p +
  geom_smooth(colour = "#fc8f0033", method = "lm") +
  geom_smooth(colour = "#fc8f0033", method = "lm", formula = y ~ poly(x, 2)) +
  geom_smooth(colour = "#235596", method = "lm", formula = y ~ poly(x, 5))

p4 <- 
  p +
  geom_smooth(colour = "#fc8f0005", method = "lm") +
  geom_smooth(colour = "#fc8f0005", method = "lm", formula = y ~ poly(x, 2)) + 
  geom_smooth(colour = "#fc8f0005", method = "lm", formula = y ~ poly(x, 5)) +
  geom_point(size = .5,
             alpha = 1) 

height <-  4.5
width <- 9
bg <- "#FFFFFF00"

svglite(file = here::here("img/ch1.svg"),
        width = width, height = height)
p1 %>% print()
dev.off()


svglite(file = here::here("img/ch2.svg"),
        width = width, height = height)
p2 %>% print()
dev.off()


svglite(file = here::here("img/ch3.svg"),
        width = width, height = height)
p3 %>% print()
dev.off()


svglite(file = here::here("img/ch4.svg"),
        width = width, height = height)
p4 %>% print()
dev.off()