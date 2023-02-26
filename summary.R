# Load relevant libraries
library("dplyr")
library("tidyverse")
library("stringr")

# Create List
summary_info <- list()

summary_info$total_checkouts <- max(usage_data$TotalCheckouts) + min(usage_data$TotalCheckouts)

summary_info$digital_pct <- 
  round(max(usage_data$TotalCheckouts) / summary_info$total_checkouts *100, 1)

summary_info$physical_pct <- 
  round(min(usage_data$TotalCheckouts) / summary_info$total_checkouts *100, 1)

books_per_month <- popular_materials %>% 
  filter(MaterialType == "BOOK") 

summary_info$max_books <- max(books_per_month$TotalCheckouts)

summary_info$min_books <- min(books_per_month$TotalCheckouts)