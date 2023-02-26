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
usage_data <- spl_data %>%
  group_by(UsageClass) %>%
  summarise(TotalCheckouts = sum(Checkouts))

# Create relevant plot
ggplot(usage_data, aes(
  x = UsageClass,
  y = TotalCheckouts,
  fill = UsageClass # sets color for each bar
)) +
  geom_col() +
  scale_fill_manual(
    values = c("#1E5171", "#81C3D7")
  ) +
  labs( # title and axis labels
    title = "Number of Checkouts by Usage Class",
    x = "Usage Class",
    y = "Number of Checkouts"
  ) +
  scale_y_continuous(labels = label_number_si()) + # abbreviates numbers
  guides(fill = guide_legend(title = "Usage Class"))