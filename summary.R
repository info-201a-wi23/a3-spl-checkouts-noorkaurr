# Load relevant libraries
library("dplyr")
library("tidyverse")
library("stringr")

spl_data <- read.csv(
  "~/desktop/informatics201/2022-2023-All-Checkouts-SPL-Data.csv",
  stringsAsFactors = F
)

spl_data <- spl_data %>%
  mutate(Date = paste0(CheckoutYear, "-", CheckoutMonth, "-01"))

spl_data$Date <- as.Date(spl_data$Date, format = "%Y-%m-%d")

usage_data <- spl_data %>%
  group_by(UsageClass) %>%
  summarise(TotalCheckouts = sum(Checkouts))

material_data <- spl_data %>%
  group_by(Date, MaterialType) %>%
  summarise(TotalCheckouts = sum(Checkouts))

popular_materials <- material_data %>%
  group_by(Date) %>%
  top_n(n = 3, wt = TotalCheckouts)



# Create List
summary_info <- list()

summary_info$total_checkouts <- max(usage_data$TotalCheckouts) + min(usage_data$TotalCheckouts)

summary_info$digital_pct <-
  round(max(usage_data$TotalCheckouts) / summary_info$total_checkouts * 100, 1)

summary_info$physical_pct <-
  round(min(usage_data$TotalCheckouts) / summary_info$total_checkouts * 100, 1)

books_per_month <- popular_materials %>%
  filter(MaterialType == "BOOK")

summary_info$max_books <- max(books_per_month$TotalCheckouts)

summary_info$min_books <- min(books_per_month$TotalCheckouts)