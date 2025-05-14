setwd("D:/Research/Dengue projection study")

library(ggplot2)
library(sf)
library(gridExtra)
library(ggspatial)  # Add for north arrow and scale bar

# Load the spatial data
spatial_data <- st_read("gadm40_BGD_2.shp")

# Load the incidence data
incidence_data <- read.csv(file.choose(), header = TRUE)

# Merge both spatial and disease data
merged_data <- merge(spatial_data, incidence_data, by.x = "NAME_2", by.y = "NAME_2")

# Plot
p1 <- ggplot(data = merged_data) +
  geom_sf(aes(fill = Incidence), color = "white", size = 0.3) +
  scale_fill_gradientn(
    name = "Incidence rates",
    colours = c("#2e8b57", "#f4a460", "#b22222"),   # sea green -> sandy orange -> firebrick red
    limits = c(0, 800),
    breaks = seq(0, 800, by = 200)
  ) +
  labs(x = "Longitude", y = "Latitude") +
  theme_bw() +
  theme(
    legend.title = element_text(face = "bold"),
    axis.text = element_text(size = 10),
    axis.title = element_text(size = 12, face = "bold"),
    plot.title = element_text(hjust = 0.5, face = "bold"),
    panel.grid.major = element_line(color = "gray90"),
    panel.border = element_rect(color = "black", fill = NA)
  ) +
  annotation_scale(location = "bl", width_hint = 0.3) +
  annotation_north_arrow(location = "tr", which_north = "true",
                         pad_x = unit(0.2, "in"), pad_y = unit(0.2, "in"),
                         style = north_arrow_fancy_orienteering())

p1

