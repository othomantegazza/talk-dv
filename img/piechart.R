library(tidyverse)

# Create Data
data <- tibble(
  group=c("Shared", "Not Shared"),
  value=c(.017, .983)
)

# Basic piechart
p <- 
  ggplot(data, aes(x="", y=value, fill=group)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0) +
  guides(fill = FALSE) +
  scale_fill_manual(values = c("#235596", "#19fff4")) +
  # lims(x = c(-.5, NA)) +
  theme_void()

svglite::svglite(file = "img/piechart.svg")
p %>% print()
dev.off()

