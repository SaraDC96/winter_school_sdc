# Script name
# Author
# Date


# Libraries ---------------------------------------------------------------
library(tidyverse)
library(ggpubr)
library(RColorBrewer)
library(palmerpenguins)


# Data --------------------------------------------------------------------

# Load the dataset into the local environment
penguins <- penguins


# Example -----------------------------------------------------------------

# Discrete viridis colour palette
ggplot(data = penguins,
       aes(x = body_mass_g, y = bill_length_mm)) +
  geom_point(aes(colour = as.factor(year))) +
  scale_colour_viridis_d(option = "A")

# Compare species
ggplot(data = penguins, aes(x = species, y = bill_length_mm)) +
  geom_boxplot(aes(fill = species), show.legend = FALSE) +
  stat_compare_means(method = "anova")


# Exercise 1 --------------------------------------------------------------

# Create your own continuous and discrete colour palettes
# Create and combine two figures, each using a different palette

# Continuous
plot_1 <- ggplot(data = penguins,
                 aes(x = body_mass_g, y = bill_length_mm)) +
  geom_point(aes(colour = bill_depth_mm), size = 2) +
  scale_colour_gradientn(colours = c("#64FAF9", "#59CAD5", "#509CAE", "#447184", "#33495A", "#1E2531")) +
  labs(x = "Body mass (g)", y = "Bill length (mm)", colour = "Bill depth (mm)")
    

# Discrete
plot_2 <- ggplot(data = penguins,
                 aes(x = body_mass_g, y = bill_length_mm)) +
  geom_point(aes(colour = species), size = 2) +
  scale_colour_manual(values = c("#a09446", "#7f64b9", "#a64d6c"),
                        labels = c("Adelie", "Chintrap", "Gentoo")) +
  labs(x = "Body mass (g)", y = "Bill length (mm)", colour = "Species")

#Combine both plots  
library(ggpubr)
ggarrange(plot_1, plot_2,
          nrow = 1)


# Exercise 2 --------------------------------------------------------------

# Create two versions of the same figure and combine
# Use a viridis colour palette against a default palette in a way that 
# allows features in the data to be more pronounced

plot_3 <- ggplot(data = penguins,
                 aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(aes(colour = body_mass_g), size = 2) +
  labs(x = "Bill length (mm)", y = "Bill depth (mm)", colour = "Body mass (g)")
  
plot_4 <- ggplot(data = penguins,
                 aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(aes(colour = body_mass_g), size = 2) +
  scale_colour_viridis_c(option = "D", direction = -1) +
  labs(x = "Bill length (mm)", y = "Bill depth (mm)", colour = "Body mass (g)")

ggarrange(plot_3, plot_4,
          nrow = 2,
          legend = "right")

# Exercise 3 --------------------------------------------------------------

# Plot and combine t-test and ANOVA stats using sst_NOAA
# See this site for more info on plotting stats:
# http://www.sthda.com/english/articles/24-ggpubr-publication-ready-plots/76-add-p-values-and-significance-levels-to-ggplots/

# Load the dataset
sst_noaa <- read_csv("winter_school_sdc/course_material/data/sst_NOAA.csv")
head(sst_noaa) #prints the first six lines instead of all
summary(sst_noaa)
  
# Load package
library(ggpubr)
  
# COM! The following script doesn't work for this dataset
# First create a list of comparisons to feed into our figure
sst_noaa_levels <- levels(sst_noaa$site)
my_comparisons <- list(c(sst_noaa_levels[1], sst_noaa_levels[2]),
                       c(sst_noaa_levels[2], sst_noaa_levels[3]),
                       c(sst_noaa_levels[1], sst_noaa_levels[3]))
  
# Then we stack it all together
ggplot(data = sst_noaa, aes(x = site, y = temp)) +
  geom_boxplot(aes(fill  = site), colour = "grey40", show.legend = F) +
  stat_compare_means(method = "anova", colour = "grey50",
                     label.x = 1.8, label.y = 32) +
  # Add pairwise comparisons p-value
  stat_compare_means(comparisons = my_comparisons,
                     label.y = c(62, 64, 66)) +
  # Perform t-tests between each group and the overall mean
  stat_compare_means(label = "p.signif", 
                     method = "t.test",
                     ref.group = ".all.") + 
  # Add horizontal line at base mean
  geom_hline(yintercept = mean(sst_noaa$temp, na.rm = T), 
             linetype = 2) + 
  labs(y = "Temperature (°C)", x = NULL) +
  theme_bw()



# BONUS -------------------------------------------------------------------

# Create a correlogram
library(GGally)
penguins <- penguins
  
ggpairs(data = penguins, columns = 3:6, ggplot2::aes(colour = species))
  
  

# Use own dataset ---------------------------------------------------------
pw_teeth <- read_csv("winter_school_sdc/Phd_database_pw_teeth.csv")

ggplot(data = na.omit(pw_teeth), aes(x = kyn, y = longd)) +
  geom_boxplot(aes(fill = kyn), show.legend = TRUE) +
  scale_fill_manual(values = c("#CDDBE5", "#84B6AB"),
                        labels = c("Female", "Male")) +
  labs(x = "Sex", y = "Length (cm)", fill = "Sex") +
  theme(axis.text.x = element_blank())
  
  
  