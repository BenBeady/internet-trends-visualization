# Load libraries
library(ggplot2)
library(dplyr)
library(readr)

# Load dataset (replace with your own if needed)
# Sample dataset idea: Country, Year, Internet_Users (in % of population)
data <- read_csv("data/internet.csv")

# Inspect
head(data)

# Trend over time - Global Average
global_trend <- data %>%
  group_by(Year) %>%
  summarise(avg_internet = mean(Internet_Users, na.rm = TRUE))

ggplot(global_trend, aes(x=Year, y=avg_internet)) +
  geom_line(color="blue", size=1.2) +
  theme_minimal() +
  labs(title="🌍 Global Internet Usage Over Time",
       x="Year",
       y="Internet Users (% of population)")

ggsave("plots/internet_growth.png", width=7, height=5)

# Top 10 countries in latest year
latest_year <- max(data$Year)
top_countries <- data %>%
  filter(Year == latest_year) %>%
  arrange(desc(Internet_Users)) %>%
  head(10)

ggplot(top_countries, aes(x=reorder(Country, Internet_Users), y=Internet_Users, fill=Country)) +
  geom_col(show.legend = FALSE) +
  coord_flip() +
  theme_minimal() +
  labs(title=paste("Top 10 Countries by Internet Usage in", latest_year),
       x="Country", y="Internet Users (% of population)")

ggsave("plots/top_countries.png", width=7, height=5)
