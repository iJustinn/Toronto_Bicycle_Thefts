# Load required libraries
library(jsonlite)
library(dplyr)
library(sf)

# Load the GeoJSON data
bike_thefts_geo <- read_sf(here("data/Bicycle_Thefts_Open_Data.geojson"))

# Function to extract and clean coordinates from geometry
extract_coordinates <- function(geo) {
  if (!is.null(geo) && nrow(st_coordinates(geo)) > 0) {
    # Convert geometry to WKT format and extract coordinates
    coords <- st_coordinates(geo)
    
    if (!is.null(coords)) {
      # Separate longitude and latitude
      longitude <- coords[, 1]
      latitude <- coords[, 2]
      
      # Create a data frame with longitude and latitude
      coords_df <- data.frame(longitude = longitude, latitude = latitude)
      return(coords_df)
    }
  }
  
  return(NULL) # Return NULL for invalid or empty data
}

# Apply the function to extract all coordinates from the 'geometry' column
all_coordinates <- lapply(bike_thefts_geo$geometry, extract_coordinates)

# Filter out any NULL values from the list of extracted coordinates
valid_coordinates <- all_coordinates[!sapply(all_coordinates, is.null)]

# Create a unique ID for each geometry feature (so we know which points belong together)
bike_thefts_geo$id <- seq_len(nrow(bike_thefts_geo))

# Combine all valid coordinates into a single dataframe with IDs
coordinates_data <- do.call(rbind, Map(function(coords, id) {
  coords$id <- id # Add ID to each set of coordinates
  return(coords)
}, valid_coordinates, bike_thefts_geo$id[!sapply(all_coordinates, is.null)]))

# Ensure no NA values exist in longitude and latitude
coordinates_data <- coordinates_data %>%
  filter(!is.na(longitude), !is.na(latitude))

# Save the cleaned coordinates data to the same directory
write.csv(coordinates_data, here("data/cleaned_coordinates_data.csv"), row.names = FALSE)
