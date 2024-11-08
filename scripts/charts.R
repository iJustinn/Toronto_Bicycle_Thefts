#### Setup #####
# Libraries
required_packages <- c("lubridate", "sf", "tidyverse", "readr", "here", "osmdata", "ggplot2")
for (p in required_packages) {
  if (!require(p, character.only = TRUE)) {
    install.packages(p, character.only = TRUE)
  }
}

library(lubridate)
library(tidyverse)
library(ggplot2)
library(osmdata)
library(readr)
library(here)
library(sf)

# Data
bike_thefts <- read_csv(here("data/Bicycle_Thefts_Open_Data.csv"))
coordinates_data <- read.csv(here("data/cleaned_coordinates_data.csv"))

#### Chart 1 #####
# Create a bar chart for the number of bicycle thefts by month
bike_thefts %>%
  count(OCC_MONTH) %>%
  ggplot(aes(x = reorder(OCC_MONTH, -n), y = n, fill = OCC_MONTH)) +
  geom_bar(stat = "identity") +
  labs(title = "Number of Bicycle Thefts by Month", x = "Month", y = "Number of Thefts") +
  theme_minimal()

# Save the plot
ggsave(here("other/charts/thefts_by_month.png"))



#### Chart 2 #####
# Create a pie chart for the status of bicycle thefts
bike_thefts %>%
  count(STATUS) %>%
  ggplot(aes(x = "", y = n, fill = STATUS)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y") +
  labs(title = "Bicycle Theft Status (Stolen vs Recovered)") +
  theme_minimal()

# Save the plot
ggsave(here("other/charts/theft_status_pie.png"))



#### Chart 3 #####
# Create a bar chart for bicycle thefts by day of the week
bike_thefts %>%
  count(OCC_DOW) %>%
  ggplot(aes(x = reorder(OCC_DOW, -n), y = n, fill = OCC_DOW)) +
  geom_bar(stat = "identity") +
  labs(title = "Number of Bicycle Thefts by Day of the Week", x = "Day of the Week", y = "Number of Thefts") +
  theme_minimal()

# Save the plot
ggsave(here("other/charts/thefts_by_day.png"))



#### Chart 4 #####
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

# Plot the map with bike theft locations data
ggplot() +
  geom_sf(data = streets, color = "gray", size = 0.3, alpha = 0.6) + # OSM street map layer
  geom_point(
    data = coordinates_data, aes(x = longitude, y = latitude),
    size = 0.5, color = "red"
  ) + # Bike theft points
  labs(
    title = "Map of Bicycle Theft Locations in Toronto",
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
ggsave(here("other/charts/bicycle_theft_heatmap.png"))


