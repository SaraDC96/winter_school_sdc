# Script name
# Author
# Date


# Libraries ---------------------------------------------------------------
library(tidyverse)
library(lubridate)


# Data --------------------------------------------------------------------

# SST time series
sst_NOAA <- read_csv("course_material/data/sst_NOAA.csv")

# Global SST layer for 2022-01-01
load("course_material/data/OISST_2022.RData")


# Example -----------------------------------------------------------------

# All five functions at once
sst_NOAA %>% 
  arrange(site, temp) %>% 
  select(t, temp) %>% 
  filter(temp >= 23) %>% 
  mutate(year = year(t)) %>% 
  summarise(mean_year = mean(year))


# Exercise 1 --------------------------------------------------------------

# Filter sst_NOAA to have only data for WA from 2005-2010
# Plot as a line plot
# Combine or inset with a map of Western Australia

# Filter
sst_NOAA_20052010 <- sst_NOAA %>%
  filter(site == "WA" & year(t) == 2005:2010)
head(sst_NOAA_20052010)
tail(sst_NOAA_20052010)

# Plot
plot_sst_NOAA_20052010 <- ggplot(data = sst_NOAA_20052010,
                                 aes(x = t, y = temp)) + geom_line(colour = "#094D7E") +
                                  theme_bw() +
                                  labs(x = "Year", y = "Temperature (°C)")
plot_sst_NOAA_20052010

# Combine with map
  # Load libraries
  library(ggpubr)
  library(ggsn)
  
  # Make the map
    # Fix the base map
    map_global_fix <- map_data("world") %>% 
      rename(lon = long) %>% 
      mutate(group = ifelse(lon > 180, group+2000, group),
             lon = ifelse(lon > 180, lon-360, lon))
  
  map_sst_NOAA <- map_global_fix %>% 
      filter(region == "Australia") %>% 
      ggplot(aes(x = lon, y = lat)) +
      # First add the temp data
      geom_tile(data = filter(OISST_2022,
                            lon > 90, lon < 125, lat > -38, lat < -18), # Filtering the OISST_2022 data directly in geom_tile()
              aes(fill = temp)) +
      labs(fill = "Temperature (°C)") +
      # Then add the landmass on top
      geom_polygon(aes(group = group), fill = "lightgrey", colour = "black") +
      coord_equal(xlim = c(90, 125), ylim = c(-38, -18)) +
      scale_x_continuous(breaks = seq(90, 125, 5),
                         labels = c("90°E", "95°E", "100°E", "105°E", "110°E", "115°E","120°E", "125°E"),
                         position = "bottom") +
      scale_y_continuous(breaks = seq(-35, -15, 5),
                         labels = c("35°S", "30°S", "25°S", "20°S", "15°S"),
                         position = "right") +
      labs(x = "", y = "", title = "Seasurface temperature of West Australia") +
      theme_bw()
  
  
  # Convert the plot to a grob and add to the map
  sst_NOAA_20052010_WA <- map_sst_NOAA +
    annotation_custom(grob = ggplotGrob(plot_sst_NOAA_20052010), 
                      xmin = 89, xmax = 110,
                      ymin = -30, ymax = -18)

sst_NOAA_20052010_WA
  


# Exercise 2 --------------------------------------------------------------

# Create an informative table of the 10 highest monthly temperature in the Med
# Inset this onto a map of the Med with the sea surface temperature from 'OISST_2022'




# Exercise 3 --------------------------------------------------------------

# Plot the the annual mean temperatures of NW_Atl as a bar plot
# Inset a map of Atlantic Canada into the corner of the bar plot

# Filter/select the data out of the data set, and group by year
sst_NOAA_NW_Atl <- sst_NOAA %>%
  filter(site == "NW_Atl") %>%
  group_by(site, year = year(t)) %>% 
  summarise(mean_temp = mean(temp, na.rm = TRUE))  %>%
  ungroup()
head(sst_NOAA_NW_Atl)

# Plot this new sub_dataset (sst_NOAA_NW_Atl)
plot_sst_NOAA_NW_Atl <- ggplot(data = sst_NOAA_NW_Atl,
                                 aes(x = year, y = mean_temp)) + geom_line(colour = "#094D7E") +
  theme_bw() +
  labs(x = "Year", y = "Temperature (°C)",  title = "Seasurface temperature of Atlantic Canada")
plot_sst_NOAA_NW_Atl

# Inset a map into this plot
  # Create a map of Atlantic Canada
  map_sst_NOAA_NW_Atl <- map_global_fix %>% 
      # Look for the name of America --> USA
        # map_global_fix_US <- map_global_fix %>%
          # group_by(region) %>%
          # ungroup()
        # unique(map_global_fix_US$region)
    filter(region == "Canada" | region == "Greenland" | region == "USA") %>% 
    ggplot(aes(x = lon, y = lat)) +
    # First add the temp data
    geom_tile(data = filter(OISST_2022,
                            lon > -130, lon < -50, lat > 40, lat < 90), # Filtering the OISST_2022 data directly in geom_tile()
              aes(fill = temp)) +
    labs(fill = "Temperature (°C)") +
    # Then add the landmass on top
    geom_polygon(aes(group = group), fill = "lightgrey", colour = "black") +
    coord_equal(xlim = c(-130, -50), ylim = c(40, 90)) +
    scale_x_continuous(breaks = seq(-130, -50, 20),
                       labels = c("130°W", "110°W", "90°W", "70°W", "50°W"),
                       position = "bottom") +
    scale_y_continuous(breaks = seq(40, 90, 10),
                       labels = c("40°N", "50°N", "60°N", "70°N", "80°N", "90°N"),
                       position = "right") +
    labs(x = "", y = "") +
    theme_bw()
  
  map_sst_NOAA_NW_Atl
  
  # Convert the map to a grob and add to the plot
  library(cowplot)
  
  sst_NOAA_NW_Atl <- ggplot() +
    draw_plot(plot_sst_NOAA_NW_Atl) +
    draw_plot(map_sst_NOAA_NW_Atl, x = -0.2, y = 0.45, height = 0.5)
  
sst_NOAA_NW_Atl


# BONUS -------------------------------------------------------------------

# Find the mean temperature for 2002 in Med and 2005 in WA in the same code chunk
# Hint: The case_when() function will be useful for this
# In another single code chunk, extract the country shapes for Italy and Australia
# Inset plots of the Med temperatures over Italy, and WA over Australia
# Combine into one figure

