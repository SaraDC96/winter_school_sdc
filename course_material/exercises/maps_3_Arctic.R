# Script name
# Author
# Date


# Libraries ---------------------------------------------------------------
library(tidyverse)
library(ggOceanMaps)
  
# The following package is not on CRAN, so:
# remotes::install_github("MikkoVihtakari/ggOceanMapsData")
library(ggOceanMapsData)


# Data --------------------------------------------------------------------
# Fix the base map
map_global_fix <- map_data('world') %>% 
  rename(lon = long) %>% 
  mutate(group = ifelse(lon > 180, group+2000, group),
         lon = ifelse(lon > 180, lon-360, lon))
  
# Load sea surface temperatures for 2000-01-01
load("course_material/data/OISST_2022.RData")


# Example -----------------------------------------------------------------

# An Arctic plot
basemap(limits = c(-160, -80, 60, 85), rotate = TRUE)


# Exercise 1 --------------------------------------------------------------

# Directly access the shape of a region near a pole
# Plot with coord_map(projection = "ortho")
map_5 <-  ggplot(data = map_global_fix, aes(x = lon, y = lat)) +
    geom_polygon(aes(group = group)) +
    coord_map(projection = "ortho", orientation = c(60, -5, 0),
              xlim = c(-45, 0), ylim = c(56, 74)) 


# Exercise 2 --------------------------------------------------------------

# Add temperature to this plot
map_5b <- map_5 + geom_polygon(aes(group = group)) +
  geom_tile(data = filter(OISST_2022,
                          lon > -55, lon < 0, lat > 56, lat < 74), # Filtering the OISST_2022 data directly in geom_tile()
            aes(fill = temp))
map_5b

# Exercise 3 --------------------------------------------------------------

# Use ggoceanmaps to create a similar plot
map_6 <- basemap(limit = c(-50, -3, 56, 68),
                 bathymetry = TRUE, land.col = "lightgrey", rotate = 2)
map_6


# BONUS -------------------------------------------------------------------

# Create a workflow for creating a polar plot for any region
# Add a red bounding box to highlight a region
# And different coloured points to show study sites
map_x <- basemap(limit = c(-50, -3, 56, 68),
                 bathymetry = TRUE, land.col = "#E5E5E5", rotate = T)
  
# New dataset is needed for to add a box
dt_box <- data.frame(lon = c(-45, -45, -34, -34), lat = c(60.5, 62.5, 65.2, 60.5))
  
# Now we can add it to the map_x
map_xy <- map_x  +
  geom_spatial_polygon(data = dt_box, aes(x = lon, y = lat),
                       fill = NA, colour = "darkred")
map_xy    

  
# Add a point, like a samplingstation
  # First: define the locations of the points in a dataset
    # dt_dot_g: Tasiilaq 65.6135°N, 37.6336°W
    # dt_dot_t: Torshavn 62.0107°N, 6.7741°W
  dt_dot_g <- expand.grid(lon = c(-37.6336, 20), lat = c(65.6135, 80))
  dt_dot_f <- expand.grid(lon = c(-60, -6.7741), lat = c(0, 62.0107))
    # Create a new dataset to add a legend to the map
      # !!! COM !!! The legend doesn't appear correctly
    dt_dot_gf <- data.frame(lon = c(-70, 20), lat = c(40, 80),
                            dt_colour = c("#a6d555", "#FFB732"))
  
  # Second: add these to map_x
    # !!! COM !!! The legend for sampling location isn't added correctly
  map_xz <- map_x +
    geom_spatial_point(data = dt_dot_g, aes(x = lon, y = lat),
                       size = 4, fill = "#a6d555", shape = 21) +
    geom_spatial_point(data = dt_dot_f, aes(x = lon, y = lat),
                       size = 4, fill = "#FFB732", shape = 25) +
    geom_spatial_point(data = dt_dot_gf, aes(x = lon, y = lat, colour = dt_colour)) +
    labs(colour = "Sampling location")
    map_xz

    
# Add extras to this map
map_final <- map_xz +
  annotation_scale(location = "bl") + 
  annotation_north_arrow(location = "tr", which_north = "true") +
  labs(title = "Sampling locations TOPLINK")
map_final
  

# BONUS - Try with own data -----------------------------------------------

# Load datafile
ws_track <- read_csv("course_material/data/233997-Locations.csv") %>% 
  rename(lon = Longitude, lat = Latitude) # Rename Longitude and Latitude column names to match script
  
# Make base map
map_6 <-  ggplot(data = map_global_fix, aes(x = lon, y = lat)) +
  geom_polygon(aes(group = group)) +
  coord_map(projection = "ortho", orientation = c(60, -5, 0),
            xlim = c(-45, 0), ylim = c(58, 70)) 
  
# Add the dots from the track
map_6b <- map_6 + geom_polygon(aes(group = group)) +
  geom_spatial_point(data = ws_track, aes(colour = Quality))
map_6b

  
# Try the same with ggOceanMaps
  # Make the basemap
  map_7 <- basemap(limit = c(-50, -3, 56, 68),
                   bathymetry = T, land.col = "#E5E5E5", rotate = T)
      
  # Add the coordinates from the track as dots
  map_7b <- map_7 +
    geom_spatial_point(data = ws_track, aes(x = lon, y = lat),
                       size = 3, fill = "#FFB732", shape = 21)
  
  
  