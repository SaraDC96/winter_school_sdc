# Script name
# Author
# Date


# Libraries ---------------------------------------------------------------
library(tidyverse)


# Data --------------------------------------------------------------------

# The mangled data
load("course_material/data/OISST_mangled.RData")
  
# The tidy data
sst_NOAA <- read_csv("course_material/data/sst_NOAA.csv")
  

# Example -----------------------------------------------------------------

# Tidy data
head(OISST1)

ggplot(data = OISST1, aes(x = t, y = temp)) +
  geom_line(aes(colour = site)) +
  labs(x = NULL, y = "Temperature (°C)", colour = "Site") +
  theme_bw()
  
# Untidy data: temp (= variable) is split in three column
head(OISST2)
  # We want to combine these and make the data 'longer'
  OISST2_tidy <- OISST2 %>%
    pivot_longer(cols = c(Med, NW_Atl, WA),
                 names_to = "site", values_to = "temp")
  head(OISST2_tidy)
  
# Untidy data: there are more variables (t, site) in one column
head(OISST3)
  # We want to give each its own column
  OISST3_wide <- OISST3 %>% 
    pivot_wider(id_cols = idx, names_from = type, values_from = name)
  head(OISST3_wide)
  
# Untidy data: site and date are next to each other in one column
head(OISST4a)
  # We want to create two columns out of one
  OISST4a_tidy <- OISST4a %>%
    separate(col = index, into = c("site", "t"), sep = " ")
  head(OISST4a_tidy)
  
# Untidy data: date is split in three columns
head(OISST4b)
  # We want to unite these columns into one
  OISST4b_tidy <- OISST4b %>%
    unite(year, month, day, col = "t", sep = "-")
  head(OISST4b_tidy)


# Exercise 1 --------------------------------------------------------------

# Combine OISST4a and OISST4b into a new object

# Look at the data
head(OISST4a)
head(OISST4b)

#Tidy the data
OISST4a_tidy <- OISST4a %>%
  separate(col = index, into = c("site", "t"), sep = " ")

OISST4b_tidy <- OISST4b %>%
  unite(year, month, day, col = "t", sep = "-")

# Join both data frames
OISST4_tidy <- left_join(OISST4a_tidy, OISST4b_tidy, by = c("site", "t"))
head(OISST4_tidy)


# Exercise 2 --------------------------------------------------------------

# Ensure that the date formatting is correct on your new object

# Done in Exercise 1



# Exercise 3 --------------------------------------------------------------

# Split the date column on `sst_NOAA` and re-unite them

# Look at the data
head(sst_NOAA)

# Split date column
sst_NOAA_split <- sst_NOAA %>% 
  separate(col = t, into = c("year", "month", "day"), sep = "-")
head(sst_NOAA_split)

# Unite the year, month, day again
sst_NOAA_unite <- sst_NOAA_split %>%
  unite(year, month, day, col = "t", sep = "-" )
head(sst_NOAA_unite)



# BONUS -------------------------------------------------------------------

# Plot the temperatures of two time series against each other as a scatterplot
# Meaning temperature from time series 1 are the X axis, and time series 2 on the Y axis
# Hint: This requires pivoting the temperatures wide into columns

# Look at the data
head(sst_NOAA)

# Pivot the data into a wide dataframe
sst_NOAA_wide <- sst_NOAA %>%
  pivot_wider(names_from = site, values_from = temp)
head(sst_NOAA_wide)

# Load needed library's
library(ggplot2)

# Make scatterplot
scatterplot_noaa <- ggplot(data = sst_NOAA_wide,
                           aes(x = Med, y = WA)) +
  geom_point(aes(colour = t))
scatterplot_noaa




