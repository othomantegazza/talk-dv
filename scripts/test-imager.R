library(imager)
library(tidyverse)


# https://upload.wikimedia.org/wikipedia/en/3/38/You_Could_Have_It_So_Much_Better_%28Franz_Ferdinand_album_-_cover_art%29.png
# https://cran.r-project.org/web/packages/imager/vignettes/gettingstarted.html

# ff <- imager::load.image("https://upload.wikimedia.org/wikipedia/en/3/38/You_Could_Have_It_So_Much_Better_%28Franz_Ferdinand_album_-_cover_art%29.png")
ff <- load.image("https://i.imgur.com/yIeij.jpg")
plot(ff)

save(ff, file = "franz-ferdinand.Rdata")

ff_g <- 
  ff %>% 
  grayscale() %>% 
  isoblur(2)
  
ff_gr <- 
  ff_g %>% 
  imgradient(axes = "xy")

ff_dx <- 
  ff_g %>% 
  imgradient("x") 

ff_dy <- 
  ff_g %>% 
  imgradient("y") 

ff_edge <- 
  sqrt(ff_dx^2 + ff_dy^2) #%>% # plot()
  # threshold(thr = 0.03) 

ff_edge %>% 
  plot()

# https://dahtah.github.io/imager/canny.html
# non maxima suppression --------------------------------------------------

mag <-mag <- with(ff_gr,sqrt(x^2+y^2))
im <- ff_g
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

# plot --------------------------------------------------------------------



ff_edge %>% 
  as.data.frame() %>% 
  as_tibble() %>% 
  sample_n(2000, weight =  value^3) %>% 
  ggplot(aes(x = x,
             y = max(y) - y)) +
  geom_point(size = .6,
             alpha = .3) +
  # geom_rug() +
  # scale_y_reverse() +
  coord_fixed() +
  lims(x = c(0, 500),
       y = c(0, 500))

mag %>% 
  as.data.frame() %>% 
  as_tibble() %>% 
  sample_n(2000, weight =  value^3) %>% 
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

ff_g %>% 
  as.data.frame() %>% 
  as_tibble() %>% 
  sample_n(2000, weight =  value^2) %>% 
  ggplot(aes(x = x,
             y = y)) +
  geom_point(size = .3) +
  scale_y_reverse() +
  coord_fixed()

