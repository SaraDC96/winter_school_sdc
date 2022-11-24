# Script name
# Author
# Date


# Libraries ---------------------------------------------------------------
library(tidyverse)
library(lubridate)

  # Look at all of the datasets available in R
  data(package = .packages(all.available = TRUE))
  
    # Access dataset, e.g. crabs
    MASS::crabs
      # To get it in your working environment
      crabs <- MASS::crabs # You can give it any name


# Data --------------------------------------------------------------------

# SST data
sst_NOAA <- read_csv("course_material/data/sst_NOAA.csv")


# Example -----------------------------------------------------------------

# Whatever we can imagine!
sst_NOAA %>%  
  group_by(site) %>%
  summarise(count = n(), 
            count_15 = sum(temp > 20)) %>% 
  mutate(prop_15 = count_15/count) %>% 
  arrange(prop_15)

# Temps above 15°C per year per site
sst_NOAA_15 <- sst_NOAA %>%
  group_by(site, year(t)) %>%
  summarise(count = n(),
            count_15 = sum(temp > 15),
            prop_15 = count_15/count) %>%
  mutate(prop_15 = count_15/count) %>%
  arrange(prop_15)
head(sst_NOAA_15)


# Exercise 1 --------------------------------------------------------------

# Filter two sites and summarise six different statistics
sst_NOAA %>% 
  filter(site == "Med" | site == "WA") %>%
  group_by(site) %>% 
  summarise(min_temp = min(temp, na.rm = TRUE),
            mean_temp = mean(temp, na.rm = TRUE),
            max_temp = max(temp, na.rm = TRUE),
            sd_temp = sd(temp, na.rm = TRUE))


# Exercise 2 --------------------------------------------------------------

# Find the maximum temperature and SD per year per site
# Plot this as a bar plot with error bars

# Group and summarise to get the max temp and sd per year per site
sst_NOAA_ex2 <- sst_NOAA %>%
  group_by(site, year = year(t)) %>%
  summarise(max_temp = max(temp, na.rm = TRUE), 
            sd_temp = sd(temp, na.rm = TRUE))

# Plot this new data frame
plot_sst_NOAA_ex2 <- ggplot(data = sst_NOAA_ex2, 
                            aes(x = as.factor(year), y = max_temp, fill = site)) +
                          geom_bar(stat = "identity", position = "dodge")

plot_sst_NOAA_ex2



# Find the maximum temperature and SD per site
# Plot this as a bar plot with error bars
# Inset a map of each site over each bar plot

# Group and summarise to get the max temp and sd per site
sst_NOAA_ex2b <- sst_NOAA %>%
  group_by(site) %>%
  summarise(max_temp = max(temp, na.rm = TRUE), 
            sd_temp = sd(temp, na.rm = TRUE))

# Plot this new data frame
plot_sst_NOAA_ex2b <- ggplot(data = sst_NOAA_ex2b, 
                            aes(x = site, y = max_temp, fill = site)) +
                        geom_bar(stat = "identity", width = 0.6, show.legend = FALSE) +
                        scale_fill_manual(values = c("#a09446", "#7f64b9", "#a64d6c"),
                                            labels = c("Med", "NW_Atl", "WA")) +
                        # Add errorbars
                        geom_errorbar(aes(x = site, ymin = max_temp-sd_temp, ymax = max_temp+sd_temp),
                                      width = 0.1, colour = "black", alpha = 0.9) +
                        # Adjust your plot further
                        labs(x = "Sampling site", y = "Maximum temperature (°C)", title = "Maximum temperature per sampling site") +
                        theme_bw()

plot_sst_NOAA_ex2b

# Inset a map over each barplot
  # Fix the base map
  map_global_fix <- map_data("world") %>% 
    rename(lon = long) %>% 
    mutate(group = ifelse(lon > 180, group+2000, group),
           lon = ifelse(lon > 180, lon-360, lon))
  # Load seasurface temperature data
  load("course_material/data/OISST_2022.RData")
  
  # Create map for each site
  # Med
  map_Med <-
  
  # NW_Atl
  map_NW_Atl <- map_global_fix %>% 
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

  map_NW_Atl
  
  # WA
  map_WA <- 
  
  

# Exercise 3 --------------------------------------------------------------

# From scratch, re-write the full analysis for exercise 1 'The new age'
# Inset maps for each at the end of each line on the Y axis


# BONUS -------------------------------------------------------------------

# Create a faceted heatmap showing the monthly climatologies per site

