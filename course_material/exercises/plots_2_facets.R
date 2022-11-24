# Script name
# Author
# Date


# Libraries ---------------------------------------------------------------
library(tidyverse)
library(ggpubr)
library(palmerpenguins)


# Data --------------------------------------------------------------------

# Load the dataset into the local environment
penguins <- penguins


# Example -----------------------------------------------------------------

# Basic faceted plot
lm_1 <- ggplot(data = penguins,
       aes(x = body_mass_g, y = bill_length_mm, colour = species)) +
  geom_point() +
  geom_smooth(method = "lm") +
  facet_wrap(~species)
lm_1

# Basic combined plot
ggarrange(lm_1, lm_1)


# Exercise 1 --------------------------------------------------------------

# Create a new plot type and facet by gender
lm_2 <- ggplot(data = na.omit(penguins),
               aes(x = body_mass_g, y = bill_length_mm, colour = species)) +
  geom_point() +
  geom_smooth(method = "lm") +
  facet_wrap(~sex)
lm_2


# Exercise 2 --------------------------------------------------------------

# Create a new plot type and facet by two categories
lm_3 <- ggplot(data = na.omit(penguins),
               aes(x = body_mass_g, y = bill_length_mm, colour = species)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "Body mass (g)", y = "Bill length (mm)", colour = "Species") +
  theme(legend.position = "none") +
  facet_wrap(species~sex, nrow = 3)
lm_3


# Exercise 3 --------------------------------------------------------------

# Combine all of the plots you've created so far
# Save them as a high-res file larger than 2 MB
grid_1 <- ggarrange(lm_1, lm_2, lm_3, lm_4,
                    ncol = 2, nrow = 2,
                    labels = c("a)", "b)", "c)", "d)"),
                    common.legend = TRUE,
                    legend = "bottom")
grid_1

ggsave(plot = grid_1, filename = "Figures/plots_2_facets.png",
       width = 10, height = 8,
       dpi = 600) #dpi is generally okay and doesn't need to be changed

# BONUS -------------------------------------------------------------------

# Use a different package to combine plots
library(cowplot)

grid_2 <- plot_grid(lm_1, lm_2, lm_3, lm_4,
                    nrow = 2, ncol = 2,
                    labels = NULL,
                    legend = "top")
grid_2


library(patchwork)

grid_3 <- lm_1 + lm_2 + lm_3 + lm_4


# Extra plots -------------------------------------------------------------
lm_4 <- ggplot(data = na.omit(penguins),
               aes(x = body_mass_g)) +
  geom_histogram(aes(fill = species), position = "stack", binwidth = 100) +
  labs(x = "Body mass (g)", y = "Count", fill = "Species" )
lm_4

lm_5 <- ggplot(data = na.omit(penguins),
               aes(x = species, y = body_mass_g)) +
  geom_boxplot(aes(fill = sex))
lm_5
