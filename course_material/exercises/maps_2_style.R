# Script name
# Author
# Date


# Libraries ---------------------------------------------------------------
library(tidyverse)
library(marmap) # For downloading bathymetry data


# Data --------------------------------------------------------------------
# We don't want to download it every time we run, so we will download it once and save it
# !!! COM !!! Does not work !

# Download bathy data
bathy_WA <-  getNOAA.bathy(lon1 = 111, lon2 = 117, # NB: smaller value first, i.e. more negative
                           lat1 = -36, lat2 = -19, # In degree minutes
                           resolution = 4)
  
# Convert to data.frame for use with ggplot2
bathy_WA_df <- fortify.bathy(bathy_WA) %>% 
  filter(z <= 0) # Remove altimetry data
  
# Save
save(bathy_WA_df, file = "course_material/data/bathy_WA_df.RData")


# Example -----------------------------------------------------------------

# The basic map
ggplot() +
  borders(fill = "grey70", colour = "black") +
  coord_equal(xlim = c(-90, -70), ylim = c(20, 40))


# Exercise 1 --------------------------------------------------------------

# Choose a coastal region somewhere within 30°N/S of the equator
# Download bathymetry data and plot them
map_1 <- ggplot() +
  borders(fill = "#9CB7CB", colour = "black") +
  coord_equal(xlim = c(115, 125), ylim = c(0, -10))
map_1


# Exercise 2 --------------------------------------------------------------

# Chose a different region and get bathymetry
# Plot and combine the two figures
map_2 <- ggplot() +
  borders(fill = "#9CB7CB", colour = "black") +
  coord_equal(xlim = c(-28, -13), ylim = c(5, 20))
map_2

# Exercise 3 --------------------------------------------------------------

# Change the themes and minutia of the previous two plots and combine them


# BONUS -------------------------------------------------------------------

# Overlay data layers on a Google map image

