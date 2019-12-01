# workflow: https://dahtah.github.io/imager/canny.html
library(imager)
library(tidyverse)


# get image ---------------------------------------------------------------
h_jump <- load.image("https://i.imgur.com/yIeij.jpg")
plot(h_jump)


# blur --------------------------------------------------------------------

im <- 
  h_jump %>% 
  grayscale() %>% 
  isoblur(2)

plot(im)


# gradients ---------------------------------------------------------------

ff_gr <- 
  im %>% 
  imgradient(axes = "xy")

ff_gr %>% plot(layout = "row")

# non maxima suppression --------------------------------------------------

mag <-mag <- with(ff_gr,sqrt(x^2+y^2))
# im <- ff_g
gr <- ff_gr

#Going along the (normalised) gradient
#Xc(im) is an image containing the x coordinates of the image
nX <- Xc(im) + gr$x/mag 
nY <- Yc(im) + gr$y/mag
#nX and nY are not integer values, so we can't use them directly as indices.
#We can use interpolation, though:
val.fwd <- interp(mag,data.frame(x=as.vector(nX),y=as.vector(nY)))

nX <- Xc(im) - gr$x/mag 
nY <- Yc(im) - gr$y/mag
val.bwd <- interp(mag,data.frame(x=as.vector(nX),y=as.vector(nY)))

throw <- (mag < val.bwd) | (mag < val.fwd)
mag[throw] <- 0
plot(mag)


# sample --------------------------------------------------------------------

set.seed(99)

mag_sampled <- 
  mag %>% 
  as.data.frame() %>% 
  as_tibble() %>% 
  sample_n(2000, weight =  value^2)

mag_sampled %>% 
  ggplot(aes(x = x,
             y = max(y) - y)) +
  geom_smooth(method = "lm") +
  geom_smooth() +
  geom_point(size = .5,
             alpha = 1) +
  # geom_rug() +
  # scale_y_reverse() +
  coord_fixed() +
  lims(x = c(0, 1100),
       y = c(0, NA)) +
  theme_bw()

mag_sampled %>% 
  write_csv(here::here("data/hobbes.csv"))

