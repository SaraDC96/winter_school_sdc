# Script name
# Author
# Date


# Libraries ---------------------------------------------------------------
library(tidyverse)
library(palmerpenguins)


# Data --------------------------------------------------------------------

# Load the dataset into the local environment
penguins <- penguins


# Example -----------------------------------------------------------------

# The basic plot
ggplot(data = penguins,
       aes(x = body_mass_g, y = bill_length_mm)) +
  geom_point(aes(colour = species))


# Exercise 1 --------------------------------------------------------------

# Create a basic plot with different x and y axes
ggplot(data = penguins,
       aes(x = body_mass_g, y = flipper_length_mm)) +
  geom_point(aes(colour = species))


# Exercise 2 --------------------------------------------------------------

# Change the aes() arguments
ggplot(data = penguins,
       aes(x = body_mass_g, y = bill_length_mm)) +
  geom_point(aes(colour = species, shape = sex))


# Exercise 3 --------------------------------------------------------------

# Change the labels
ggplot(data = penguins,
       aes(x = body_mass_g, y = bill_length_mm)) +
  geom_point(aes(colour = species, shape = sex), size = 3) +
  labs(title = "Penguin species", x = "Body mass (g)", y = "Bill length (mm)", colour = "Species", shape = "Sex") +
  theme_classic()
  


# BONUS -------------------------------------------------------------------

# Create a ridgeplot
library(ggridges)

ggplot(data = penguins,
       aes(x = body_mass_g, y = species)) +
  geom_density_ridges(aes(fill = species)) +
  labs(title = "Penguin species", x = "Body mass (g)", y = "Species", colour = "Species") +
  theme_classic() +
  scale_y_discrete(expand = c(0,0))






