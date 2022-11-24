# Script name
# Author
# Date


# Libraries ---------------------------------------------------------------

# ???


# Data --------------------------------------------------------------------

# ???


# Example -----------------------------------------------------------------

# ???


# Exercise 1 --------------------------------------------------------------

# Download GBIF species presence data and a physical data layer
# Plot them together on the same map


# Exercise 2 --------------------------------------------------------------

# Download a subset from a different dataset on the NOAA ERDDAP server
# Create a mean time series over the spatial extent
  # e.g. group_by() date and create daily means, thereby removing lon/lat 
# Plot the time series with a linear model, showing the slope, R^2, and p values


# Exercise 3 --------------------------------------------------------------

# Download OBIS data and combine these two plots
  # Scatterplot: data collection over time
  # Map: occurrence records
# See: https://ropensci.org/blog/2017/01/25/obis/


# BONUS -------------------------------------------------------------------

# Find the thermal envelope of a species 
  # Hint: Match species occurrence values to temperature time series pixels
  # Then find the 25th - 75th percentile of temperatures in those time series
# Then calculate the decadal rate of change for temperature in each pixel
  # Hint, get the annual mean values per pixel and calculate a linear model
  # Multiply the slope of that line by 10 to get the decadal trend
# For how many pixels where this species occurs may be too warm by 2100?


# MEGA BONUS --------------------------------------------------------------

# Subsetting and working with Copernicus Marine Environment Monitoring Service (CMEMS) data
# See: https://github.com/markpayneatwork/RCMEMS
# As with the NOAA data we access via the ERDDAP system,
# we can also access CMEMS data via the 'motuclient' system
# Unfortunately this is only supported with python
# Following the instructions in the link above,
# install the necessary software and download a subset of a dataset of your choice
# Plot it as a data layer on an Arctic projection

