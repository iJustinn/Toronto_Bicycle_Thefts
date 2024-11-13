#### Load necessary libraries ####
library(dplyr)
library(lubridate)
library(readr)
library(here)



#### Clean Data ####
# Load Data
bicycle_thefts <- read_csv(here("data", "Bicycle_Thefts_Open_Data.csv"))

# Handle missing values
# Example: Remove rows with missing dates
bicycle_thefts <- bicycle_thefts %>%
  filter(!is.na(Occurrence_Date) & !is.na(Reported_Date))

# Remove columns with any missing values
bicycle_thefts <- bicycle_thefts %>%
  select(where(~ !any(is.na(.))))

# Save Data
write_csv(bicycle_thefts, here("data", "clean_data.csv"))



#### Bicycle theft yearly count ####
# Load the dataset
bicycle_thefts <- read_csv(here("data", "Bicycle_Thefts_Open_Data.csv"))

# Count the number of thefts per year, filtering for the years 2014 to 2024
yearly_counts <- bicycle_thefts %>%
  filter(OCC_YEAR >= 2014 & OCC_YEAR <= 2024) %>%
  group_by(OCC_YEAR) %>%
  summarise(Number_of_Thefts = n())

# Save the results to a new CSV file
write_csv(yearly_counts, here("data", "Bicycle_Theft_Yearly_Counts_2014_2024.csv"))



#### Bicycle theft monthly count ####
# Load the dataset
bicycle_thefts <- read_csv(here("data", "Bicycle_Thefts_Open_Data.csv"))

# Count the number of thefts per month for each year, filtering for the years 2014 to 2024
monthly_counts <- bicycle_thefts %>%
  filter(OCC_YEAR >= 2014 & OCC_YEAR <= 2024) %>%
  group_by(OCC_YEAR, OCC_MONTH) %>%
  summarise(Number_of_Thefts = n(), .groups = "drop")

# Convert OCC_MONTH to a factor with levels in the order from January to December
monthly_counts <- monthly_counts %>%
  mutate(OCC_MONTH = factor(OCC_MONTH, levels = c("January", "February", "March", "April", "May", "June", 
                                                  "July", "August", "September", "October", "November", "December")))

# Sort the data by OCC_YEAR and the ordered OCC_MONTH
monthly_counts <- monthly_counts %>%
  arrange(OCC_YEAR, OCC_MONTH)

# Save the results to a new CSV file
write_csv(monthly_counts, here("data", "Bicycle_Theft_Monthly_Counts_2014_2024_Ordered.csv"))



#### number of stolen and found bikes ####
# Load the dataset
bicycle_thefts <- read_csv(here("data", "Bicycle_Thefts_Open_Data.csv"))

# Count occurrences for each category
offence_counts <- bicycle_thefts %>%
  mutate(
    Offence_Category = case_when(
      grepl("THEFT", PRIMARY_OFFENCE) ~ "THEFT",
      grepl("FOUND", PRIMARY_OFFENCE) ~ "FOUND",
      TRUE ~ "Other"
    )
  ) %>%
  group_by(Offence_Category) %>%
  summarise(Number_of_Offences = n())

# Display the result
print(offence_counts)


# Save the results to a new CSV file if needed
write_csv(offence_counts, here("data", "Stolen_Found_Counts.csv"))



#### Theft count weekly ####
# Load the dataset
bicycle_thefts <- read_csv(here("data", "Bicycle_Thefts_Open_Data.csv"))

# Filter rows where PRIMARY_OFFENCE contains "THEFT"
theft_data <- bicycle_thefts %>%
  filter(grepl("THEFT", PRIMARY_OFFENCE))

# Count occurrences of thefts for each day of the week
theft_counts_by_day <- theft_data %>%
  group_by(OCC_DOW) %>%
  summarise(Number_of_Thefts = n())

# Display the result
print(theft_counts_by_day)

# Save the results to a new CSV file if needed
write_csv(theft_counts_by_day, here("data", "Theft_Counts_By_Day.csv"))



#### Theft count monthly ####
# Load the dataset
bicycle_thefts <- read_csv(here("data", "Bicycle_Thefts_Open_Data.csv"))

# Filter for records within the years 2014 to 2024
theft_data <- bicycle_thefts %>%
  filter(OCC_YEAR >= 2014 & OCC_YEAR <= 2024)

# Count the number of FOUND and STOLEN for each month in each year
theft_counts_by_month <- theft_data %>%
  group_by(OCC_YEAR, OCC_MONTH) %>%
  summarise(
    Found = sum(grepl("FOUND", PRIMARY_OFFENCE)),
    Stolen = sum(grepl("THEFT", PRIMARY_OFFENCE)),
    .groups = "drop"
  )

# Ensure months are in chronological order from January to December
theft_counts_by_month <- theft_counts_by_month %>%
  mutate(OCC_MONTH = factor(OCC_MONTH, levels = c("January", "February", "March", "April", "May", "June", 
                                                  "July", "August", "September", "October", "November", "December"))) %>%
  arrange(OCC_YEAR, OCC_MONTH)

# Display the result
print(theft_counts_by_month)

# Save the results to a new CSV file if needed
write_csv(theft_counts_by_month, here("data", "Theft_and_Found_Counts_By_Month_2014_2024.csv"))



#### Bike Type ####
# Load Data
bicycle_thefts <- read_csv(here("data", "Bicycle_Thefts_Open_Data.csv"))

# Create a mapping of bike type abbreviations to detailed descriptions
bike_type_mapping <- c(
  "EL" = "Electric",
  "MT" = "Mountain",
  "RB" = "Road Bike",
  "HY" = "Hybrid",
  "BM" = "BMX",
  "CR" = "Cruiser",
  "TT" = "Time Trial",
  "TR" = "Track",
  "GR" = "Gravel",
  "FO" = "Folding",
  "OT" = "Other",
  "RC" = "Recreational & Commuting",
  "RE" = "Racing",
  "RG" = "Gravel",
  "SC" = "Scooter",
  "TA" = "Tandem",
  "TO" = "Touring",
  "UN" = "Unicycle"
)

# Count the total number of entries for each bike type, add the detailed description
bike_type_counts <- bicycle_thefts %>%
  rename(bike_type = BIKE_TYPE) %>%
  count(bike_type, name = "bike_num") %>%
  mutate(bike_type_detail = bike_type_mapping[bike_type])


# Save Data
write_csv(bike_type_counts, here("data", "bike_type_counts.csv"))



#### Bike Value ####
# Load Data
bicycle_thefts <- read_csv(here("data", "Bicycle_Thefts_Open_Data.csv"))

# Define cost tiers and count entries within each tier
bike_cost_counts <- bicycle_thefts %>%
  rename(bike_cost = BIKE_COST) %>%
  filter(!is.na(bike_cost)) %>%
  mutate(cost_tier = case_when(
    bike_cost < 500 ~ "Low (< $500)",
    bike_cost >= 500 & bike_cost < 1000 ~ "Medium ($500 - $999)",
    bike_cost >= 1000 & bike_cost < 2000 ~ "High ($1000 - $1999)",
    bike_cost >= 2000 ~ "Very High (>= $2000)"
  )) %>%
  count(cost_tier, name = "bike_num")

# Save Data
write_csv(bike_cost_counts, here("data", "bike_cost_counts.csv"))



