#### Load necessary libraries ####
library(readr)
library(dplyr)
library(here)



#### Load data ####
raw_data <- read_csv(here("data", "Bicycle_Thefts_Open_Data.csv"))



#### Clean Data ####
# Read in the data
raw_data <- read_csv(here("data", "Bicycle_Thefts_Open_Data.csv"))

# Select only the specified columns and rename them
cleaned_data <- raw_data %>%
  select(hood_num = HOOD_158, longitude = LONG_WGS84, latitude = LAT_WGS84)

# Save the cleaned dataset
write_csv(cleaned_data, here("data", "map_by_neighbourhoods_data.csv"))

# Define neighborhood classification lists
north_york <- c("151", "153", "152", "149", "130", "131", "132", "155", "154", "173", "150", "118", "119", "120")
scarborough <- c("143", "145", "146", "144", "142", "135", "156", "157", "136", "134", "133", "148", "147")
toronto_downtown_central <- c("166", "169", "170", "168", "167", "165", "163", "164", "82", "83", "95")
etobicoke <- c("158", "159", "161", "160")
york <- c("107", "109", "171")
east_york <- c("100", "102")
others <- c("172")

# Classify data based on hood_num and save each as a separate CSV file
cleaned_data %>%
  filter(hood_num %in% north_york) %>%
  write_csv(here("data", "north_york_data.csv"))

cleaned_data %>%
  filter(hood_num %in% scarborough) %>%
  write_csv(here("data", "scarborough_data.csv"))

cleaned_data %>%
  filter(hood_num %in% toronto_downtown_central) %>%
  write_csv(here("data", "toronto_downtown_central_data.csv"))

cleaned_data %>%
  filter(hood_num %in% etobicoke) %>%
  write_csv(here("data", "etobicoke_data.csv"))

cleaned_data %>%
  filter(hood_num %in% york) %>%
  write_csv(here("data", "york_data.csv"))

cleaned_data %>%
  filter(hood_num %in% east_york) %>%
  write_csv(here("data", "east_york_data.csv"))

cleaned_data %>%
  filter(hood_num %in% others) %>%
  write_csv(here("data", "others_data.csv"))