#### Load necessary libraries ####
library(readr)
library(dplyr)
library(here)



#### Load data ####
raw_data <- read_csv(here("data", "Bicycle_Thefts_Open_Data.csv"))



#### Define area categories ####
north_york <- c(151, 153, 152, 149, 130, 131, 132, 155, 154, 173, 150, 118, 119, 120)
scarborough <- c(143, 145, 146, 144, 142, 135, 156, 157, 136, 134, 133, 148, 147)
downtown_toronto <- c(166, 169, 170, 168, 167, 165, 163, 164, 82, 83, 95, 79, 70, 71)
etobicoke <- c(158, 159, 161, 160)
york <- c(107, 109, 171)
east_york <- c(100, 102)



#### Clean Data 1 ####
# Select the specified columns, rename them, and filter out invalid values
cleaned_data <- raw_data %>%
  select(
    longitude = LONG_WGS84,
    latitude = LAT_WGS84,
    stolen_place = PREMISES_TYPE,
    cost = BIKE_COST,
    status = STATUS,
    hood_num = HOOD_158,
    hood_name = NEIGHBOURHOOD_158
  ) %>%
  filter(hood_num != "NSA") %>%
  group_by(hood_num) %>%
  mutate(case_num = n()) %>%
  ungroup()

# Save data with only the required columns
final_data <- cleaned_data %>%
  select(longitude, latitude, stolen_place, cost, status, hood_num, hood_name, case_num)

write_csv(final_data, here("data", "map_by_neighbourhoods_data.csv"))



#### Clean Data 2 ####
# Create summarized data with only the required columns and calculate case_num by area
cleaned_data_2 <- cleaned_data %>%
  mutate(
    area_num = case_when(
      hood_num %in% north_york ~ 1,
      hood_num %in% scarborough ~ 2,
      hood_num %in% downtown_toronto ~ 3,
      hood_num %in% etobicoke ~ 4,
      hood_num %in% york ~ 5,
      hood_num %in% east_york ~ 6,
      TRUE ~ 7
    ),
    area_name = case_when(
      hood_num %in% north_york ~ "North York",
      hood_num %in% scarborough ~ "Scarborough",
      hood_num %in% downtown_toronto ~ "Downtown Toronto",
      hood_num %in% etobicoke ~ "Etobicoke",
      hood_num %in% york ~ "York",
      hood_num %in% east_york ~ "East York"
    )
  ) %>%
  filter(area_name != "Others") %>%
  group_by(area_num, area_name) %>%
  summarize(
    longitude = mean(longitude, na.rm = TRUE),
    latitude = mean(latitude, na.rm = TRUE),
    case_num = sum(case_num, na.rm = TRUE),
    .groups = 'drop'
  )

# Save summarized data
write_csv(cleaned_data_2, here("data", "map_by_area_data.csv"))