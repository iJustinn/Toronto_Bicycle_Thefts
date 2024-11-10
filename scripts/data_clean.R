
# Purpose: This code sequence cleans and processes bicycle theft data by renaming columns, converting data types, handling missing values, and adding calculated fields. The cleaned dataset is then saved for further analysis, enabling insights into theft patterns, risk factors, and reporting delays to better inform the cyclist community and relevant stakeholders.
# Author: Yingke He, Ziheng Zhong
# Date: Nov 11 2024
# Contact: ziheng.zhong@mail.utoronto.ca
# License: MIT

#### Load necessary libraries ####
library(dplyr)
library(lubridate)
library(readr)
library(here)  # Added this to ensure 'here' is loaded

#### Load data ####
bicycle_thefts <- read_csv(here("data", "Bicycle_Thefts_Open_Data.csv"))


#### Handle missing values ####
# Example: Remove rows with missing dates
bicycle_thefts <- bicycle_thefts %>%
  filter(!is.na(Occurrence_Date) & !is.na(Reported_Date))

#### Remove columns with any missing values ####
bicycle_thefts <- bicycle_thefts %>%
  select(where(~ !any(is.na(.))))

#### Save cleaned data ####
write_csv(bicycle_thefts, here("data", "clean_data.csv"))
