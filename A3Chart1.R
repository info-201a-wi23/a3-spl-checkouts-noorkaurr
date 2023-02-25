#Load relevant libraries
library("dplyr")
library("ggplot2")
library("scales")

#Load data frame
spl_data <- read.csv("~/desktop/informatics201/2022-2023-All-Checkouts-SPL-Data.csv", stringsAsFactors = F)

#Clean up dates
spl_data <- spl_data %>% 
  mutate(Date = paste0(CheckoutYear, "-", CheckoutMonth, "-01"))

spl_data$Date <- as.Date(spl_data$Date, format = "%Y-%m-%d")

#Create relevant data frame for each month
material_data <- spl_data %>% 
  group_by(Date, MaterialType) %>% 
  summarise(TotalCheckouts = sum(Checkouts))

#Get top three checked out materials
popular_materials <- material_data %>% 
  group_by(Date) %>% 
  top_n(n = 3, wt = TotalCheckouts)

#Create relevant plot
ggplot(popular_materials) +
  geom_line(mapping = aes(
    x = Date,
    y = TotalCheckouts,
    color = MaterialType
  )) +
  labs(
    title = "Checkouts for Popular Materials Over Time",
    x = "Month",
    y = "Number of Checkouts"
  ) +
  scale_y_continuous(labels = label_number_si())