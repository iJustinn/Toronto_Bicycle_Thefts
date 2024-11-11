#### Setup #####
# Libraries
required_packages <- c("sf", "tidyverse", "here", "osmdata", "ggplot2")
for (p in required_packages) {
  if (!require(p, character.only = TRUE)) {
    install.packages(p, character.only = TRUE)
  }
}

library(tidyverse)
library(ggplot2)
library(osmdata)
library(here)
library(sf)



#### Chart 5 #####
# Load North York data
north_york_data <- read_csv(here("data", "north_york_data.csv"))

# Get bounding box for Toronto (approximate limits for Toronto)
toronto_bbox <- c(-79.6303856025883, 43.5822069220627, -79.1180336515019, 43.8554571861712)

# Fetch map data from OpenStreetMap (OSM)
toronto_map <- opq(bbox = toronto_bbox) %>%
  add_osm_feature(key = "highway", value = "primary") %>%
  add_osm_feature(key = 'highway', value = 'secondary') %>%
  add_osm_feature(key = 'highway', value = 'tertiary') %>%
  add_osm_feature(key = 'highway', value = 'residential') %>%
  osmdata_sf()

# Convert map data to Simple Features (sf) objects
streets <- toronto_map$osm_lines

# Plot the map with North York bike theft locations data
ggplot() +
  geom_sf(data = streets, color = "gray", size = 0.3, alpha = 0.6) + # OSM street map layer
  geom_point(
    data = north_york_data, aes(x = longitude, y = latitude),
    size = 0.5, color = "red"
  ) + # Bike theft points
  labs(
    title = "Map of Bicycle Theft Locations in North York",
    x = "Longitude", y = "Latitude"
  ) +
  coord_sf(
    xlim = c(-79.6303856025883, -79.1180336515019),
    ylim = c(43.5822069220627, 43.8554571861712), expand = FALSE
  ) +
  theme_minimal() +
  theme(
    panel.background = element_blank(), # Remove panel background
    panel.grid.major = element_blank(), # Remove major grid lines
    panel.grid.minor = element_blank(), # Remove minor grid lines
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

# Save the plot
ggsave(here("other/charts/north_york_bicycle_theft_map.png"))



#### Chart 6 #####
# Load North York data
north_york_data <- read_csv(here("data", "north_york_data.csv"))

# Get bounding box for Toronto (approximate limits for Toronto)
toronto_bbox <- c(-79.6303856025883, 43.5822069220627, -79.1180336515019, 43.8554571861712)

# Fetch map data from OpenStreetMap (OSM)
toronto_map <- opq(bbox = toronto_bbox) %>%
  add_osm_feature(key = "highway", value = "primary") %>%
  add_osm_feature(key = 'highway', value = 'secondary') %>%
  add_osm_feature(key = 'highway', value = 'tertiary') %>%
  add_osm_feature(key = 'highway', value = 'residential') %>%
  osmdata_sf()

# Convert map data to Simple Features (sf) objects
streets <- toronto_map$osm_lines

# Plot the map with North York bike theft locations data
ggplot() +
  geom_sf(data = streets, color = "gray", size = 0.3, alpha = 0.6) + # OSM street map layer
  geom_point(
    data = north_york_data, aes(x = longitude, y = latitude),
    size = 0.5, color = "red"
  ) + # Bike theft points
  labs(
    title = "Map of Bicycle Theft Locations in North York",
    x = "Longitude", y = "Latitude"
  ) +
  coord_sf(
    xlim = c(-79.6303856025883, -79.1180336515019),
    ylim = c(43.5822069220627, 43.8554571861712), expand = FALSE
  ) +
  theme_minimal() +
  theme(
    panel.background = element_blank(), # Remove panel background
    panel.grid.major = element_blank(), # Remove major grid lines
    panel.grid.minor = element_blank(), # Remove minor grid lines
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

# Save the plot
ggsave(here("other/charts/north_york_bicycle_theft_map.png"))



#### Chart 7 #####
# Load Scarborough data
scarborough_data <- read_csv(here("data", "scarborough_data.csv"))

# Plot the map with Scarborough bike theft locations data
ggplot() +
  geom_sf(data = streets, color = "gray", size = 0.3, alpha = 0.6) + # OSM street map layer
  geom_point(
    data = scarborough_data, aes(x = longitude, y = latitude),
    size = 0.5, color = "red"
  ) + # Bike theft points
  labs(
    title = "Map of Bicycle Theft Locations in Scarborough",
    x = "Longitude", y = "Latitude"
  ) +
  coord_sf(
    xlim = c(-79.6303856025883, -79.1180336515019),
    ylim = c(43.5822069220627, 43.8554571861712), expand = FALSE
  ) +
  theme_minimal() +
  theme(
    panel.background = element_blank(), # Remove panel background
    panel.grid.major = element_blank(), # Remove major grid lines
    panel.grid.minor = element_blank(), # Remove minor grid lines
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

# Save the plot
ggsave(here("other/charts/scarborough_bicycle_theft_map.png"))



#### Chart 8 #####
# Load Toronto Downtown and Central data
toronto_downtown_central_data <- read_csv(here("data", "toronto_downtown_central_data.csv"))

# Plot the map with Toronto Downtown and Central bike theft locations data
ggplot() +
  geom_sf(data = streets, color = "gray", size = 0.3, alpha = 0.6) + # OSM street map layer
  geom_point(
    data = toronto_downtown_central_data, aes(x = longitude, y = latitude),
    size = 0.5, color = "red"
  ) + # Bike theft points
  labs(
    title = "Map of Bicycle Theft Locations in Toronto (Downtown and Central)",
    x = "Longitude", y = "Latitude"
  ) +
  coord_sf(
    xlim = c(-79.6303856025883, -79.1180336515019),
    ylim = c(43.5822069220627, 43.8554571861712), expand = FALSE
  ) +
  theme_minimal() +
  theme(
    panel.background = element_blank(), # Remove panel background
    panel.grid.major = element_blank(), # Remove major grid lines
    panel.grid.minor = element_blank(), # Remove minor grid lines
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

# Save the plot
ggsave(here("other/charts/toronto_downtown_central_bicycle_theft_map.png"))



#### Chart 9 #####
# Load Etobicoke data
etobicoke_data <- read_csv(here("data", "etobicoke_data.csv"))

# Plot the map with Etobicoke bike theft locations data
ggplot() +
  geom_sf(data = streets, color = "gray", size = 0.3, alpha = 0.6) + # OSM street map layer
  geom_point(
    data = etobicoke_data, aes(x = longitude, y = latitude),
    size = 0.5, color = "red"
  ) + # Bike theft points
  labs(
    title = "Map of Bicycle Theft Locations in Etobicoke",
    x = "Longitude", y = "Latitude"
  ) +
  coord_sf(
    xlim = c(-79.6303856025883, -79.1180336515019),
    ylim = c(43.5822069220627, 43.8554571861712), expand = FALSE
  ) +
  theme_minimal() +
  theme(
    panel.background = element_blank(), # Remove panel background
    panel.grid.major = element_blank(), # Remove major grid lines
    panel.grid.minor = element_blank(), # Remove minor grid lines
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

# Save the plot
ggsave(here("other/charts/etobicoke_bicycle_theft_map.png"))



#### Chart 10 #####
# Load York data
york_data <- read_csv(here("data", "york_data.csv"))

# Plot the map with York bike theft locations data
ggplot() +
  geom_sf(data = streets, color = "gray", size = 0.3, alpha = 0.6) + # OSM street map layer
  geom_point(
    data = york_data, aes(x = longitude, y = latitude),
    size = 0.5, color = "red"
  ) + # Bike theft points
  labs(
    title = "Map of Bicycle Theft Locations in York",
    x = "Longitude", y = "Latitude"
  ) +
  coord_sf(
    xlim = c(-79.6303856025883, -79.1180336515019),
    ylim = c(43.5822069220627, 43.8554571861712), expand = FALSE
  ) +
  theme_minimal() +
  theme(
    panel.background = element_blank(), # Remove panel background
    panel.grid.major = element_blank(), # Remove major grid lines
    panel.grid.minor = element_blank(), # Remove minor grid lines
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

# Save the plot
ggsave(here("other/charts/york_bicycle_theft_map.png"))



#### Chart 11 #####
# Load East York data
east_york_data <- read_csv(here("data", "east_york_data.csv"))

# Plot the map with East York bike theft locations data
ggplot() +
  geom_sf(data = streets, color = "gray", size = 0.3, alpha = 0.6) + # OSM street map layer
  geom_point(
    data = east_york_data, aes(x = longitude, y = latitude),
    size = 0.5, color = "red"
  ) + # Bike theft points
  labs(
    title = "Map of Bicycle Theft Locations in East York",
    x = "Longitude", y = "Latitude"
  ) +
  coord_sf(
    xlim = c(-79.6303856025883, -79.1180336515019),
    ylim = c(43.5822069220627, 43.8554571861712), expand = FALSE
  ) +
  theme_minimal() +
  theme(
    panel.background = element_blank(), # Remove panel background
    panel.grid.major = element_blank(), # Remove major grid lines
    panel.grid.minor = element_blank(), # Remove minor grid lines
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

# Save the plot
ggsave(here("other/charts/east_york_bicycle_theft_map.png"))



#### Chart 12 #####
# Load Others data
others_data <- read_csv(here("data", "others_data.csv"))

# Plot the map with Others bike theft locations data
ggplot() +
  geom_sf(data = streets, color = "gray", size = 0.3, alpha = 0.6) + # OSM street map layer
  geom_point(
    data = others_data, aes(x = longitude, y = latitude),
    size = 0.5, color = "red"
  ) + # Bike theft points
  labs(
    title = "Map of Bicycle Theft Locations in Others",
    x = "Longitude", y = "Latitude"
  ) +
  coord_sf(
    xlim = c(-79.6303856025883, -79.1180336515019),
    ylim = c(43.5822069220627, 43.8554571861712), expand = FALSE
  ) +
  theme_minimal() +
  theme(
    panel.background = element_blank(), # Remove panel background
    panel.grid.major = element_blank(), # Remove major grid lines
    panel.grid.minor = element_blank(), # Remove minor grid lines
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

# Save the plot
ggsave(here("other/charts/others_bicycle_theft_map.png"))


