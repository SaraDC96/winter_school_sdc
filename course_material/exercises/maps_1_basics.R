# Script name
# Author
# Date


# Libraries ---------------------------------------------------------------

# Which libraries should be loaded?
library(tidyverse)
library(ggpubr)
library(ggsn)
library(palmerpenguins)


# Data --------------------------------------------------------------------

# Call the global data to the environment
map_data_world <- map_data("world")


# Example -----------------------------------------------------------------

# The basic map
map_data_world %>% 
  filter(region == "Germany") %>% 
  ggplot(aes(x = long, y = lat)) +
  geom_polygon(aes(group = group))


# Exercise 1 --------------------------------------------------------------

# Create maps of four regions and combine
# Use a mix of cropping and direct access

# Map 1
map_1 <- ggplot() +
  borders(fill = "#84B6AB", colour = "black") +
  coord_equal()
map_1

# Map 2
map_2 <- ggplot() +
  borders(fill = "#9CB7CB", colour = "black") +
  coord_equal(xlim = c(-47.35, 0), ylim = c(52, 76)) +
  scale_x_continuous(breaks = seq(-40, 0, 20),
                     labels = c("40°W", "20°W", "0°W"),
                     position = "bottom") +
  scale_y_continuous(breaks = seq(60, 80, 10),
                     labels = c("60°N", "70°N", "80°N"),
                     position = "right") +
  labs(x = "", y = "") +
  scalebar(xmin = , xmax = , ymin = , ymax = , location = "bottomleft", 
           dist = 500, dist_unit = "km", transform = TRUE,
           st.size = 3.5, height = 0.02, st.dist = 0.03, border.size = 0.02) +
  theme_bw()
map_2

# Map 3
data_map_3 <- map_data('world') %>%
  filter(region == "Faroe Islands")
  
map_3 <- ggplot(data = data_map_3,aes(x = long, y = lat)) +
  geom_polygon(aes(group = group), fill = "#9CB7CB", colour = "black") +
  annotate("text", label = "Faroe Islands", x = -7.35, y = 62.35, size = 5.0) +
  scalebar(data = data_map_4, location = "bottomleft", 
           dist = 50, dist_unit = "km", transform = TRUE,
           st.size = 3.5, height = 0.02, st.dist = 0.03, border.size = 0.02) +
  scale_x_continuous(breaks = seq(-7.4, -6.4, 0.4),
                     labels = c("-7.4°W", "-7°W", "-6.6°W", "-6.4°W"),
                     position = "bottom") +
  scale_y_continuous(breaks = seq(61.4, 62.4, 0.2),
                     labels = c("61.4°N", "61.6°N", "61.8°N", "62°N", "62.2°N", "62.4°N"),
                     position = "right") +
  labs(x = "", y = "") +
  theme_bw()
map_3

# Map 4
data_map_4 <- map_data('world') %>%
  filter(region == "Greenland")
  
map_4 <- ggplot(data = data_map_4,aes(x = long, y = lat)) +
  geom_polygon(aes(group = group), fill = "#9CB7CB", colour = "black") +
  annotate("text", label = "Greenland", x = -70, y = 85.0, size = 5.0) +
  scalebar(data = data_map_4, location = "bottomleft", 
           dist = 500, dist_unit = "km", transform = TRUE,
           st.size = 3.5, height = 0.02, st.dist = 0.03, border.size = 0.02) +
  scale_x_continuous(breaks = seq(-60, -20, 20),
                     labels = c("60°W", "40°W", "20°W"),
                     position = "bottom") +
  scale_y_continuous(breaks = seq(60, 80, 10),
                     labels = c("60°N", "70°N", "80°N"),
                     position = "right") +
  labs(x = "", y = "") +
  theme_bw()
map_4
  
# Combine 4 maps
ggarrange(map_1, map_2, map_3, map_4)


# Exercise 2 --------------------------------------------------------------

# Create a map that benefits from a scale bar and add a North arrow
# Hint: use annotate("segment", ...) to accomplish this
  
  # See map_3 and map_4 in Exercise 1



# Exercise 3 --------------------------------------------------------------

# Create a meaningful inset map

# Map I want as base big one
map_2b <- map_2 + 
  geom_rect(aes(xmin = -8, xmax = -6, ymin = 60.5, ymax = 63),
            fill = NA, colour = "darkred")
map_2b
  
# Create FAO map (map_3) without a background
map_3b <- map_3 + theme_bw()
  
map_2b_3 <- map_2b +
  annotation_custom(grob = ggplotGrob(map_3b), # Convert the Faroe Island plot (map_3) to a grob
                    xmin = -47, xmax = -28,
                    ymin = 62, ymax = 76)
map_2b_3
  
  
  

# BONUS -------------------------------------------------------------------

# Plot maps using Google Maps

