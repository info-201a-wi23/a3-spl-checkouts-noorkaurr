# Load relevant libraries
library("dplyr")
library("ggplot2")
library("scales")

# Load data frame
spl_data <- read.csv(
  "~/desktop/informatics201/2022-2023-All-Checkouts-SPL-Data.csv",
  stringsAsFactors = F
)

# Clean up dates
spl_data <- spl_data %>%
  mutate(Date = paste0(CheckoutYear, "-", CheckoutMonth, "-01"))

spl_data$Date <- as.Date(spl_data$Date, format = "%Y-%m-%d")

# Create relevant data frame for each month
publisher_data <- spl_data %>%
  group_by(Date, Publisher) %>%
  summarise(TotalCheckouts = sum(Checkouts))

# Get top three checked out publishers
popular_publishers <- publisher_data %>%
  group_by(Date) %>%
  top_n(n = 3, wt = TotalCheckouts)

# Create relevant plot
ggplot(popular_publishers) +
  geom_line(mapping = aes(
    x = Date,
    y = TotalCheckouts,
    color = Publisher # sets color for each line
  )) +
  labs( # title and axis labels
    title = "Checkouts for Popular Publishers Over Time",
    x = "Month",
    y = "Number of Checkouts"
  ) +
  scale_y_continuous(labels = label_number_si()) # abbreviates numbers
