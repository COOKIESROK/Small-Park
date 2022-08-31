
# === description ==============================================================
# This script uses csv file "CompleteVisitorTracker.csv" generated in 
# 3.tracking.data.R to create and save figures that help visualize the distribution 
# of visitors and their satisfaction with their park experience.

# === installing and loading ggplot 2 =====
#install.packages("ggplot2")
#loading library
library("ggplot2")


# === 1) read data =============================================================
# reading data
strategies_data <- read.csv(paste(p.data, "/", "StrategiesSummary.csv", sep = ""))

#inspecting data
head(strategies_data)
str(strategies_data)

# === setting colors ====
colors <- c("random" = "#ec664d", "cooler_better" = "#fcc542", "shortest_wait" = "#84bbc4" )

# === mean satisfaction plot ====
ggplot(strategies_data, aes(x = strategy, y = mean_satisfaction)) +    
  geom_bar(fill = colors,
           stat = "identity") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = -30, vjust = 1, hjust = 0.2)) +
  ylab("Mean Satisfaction") +
  xlab("Strategies")

ggsave(path = p.fig, filename = "Mean Satisfaction.png")

# === mean rides ridden plot ====
ggplot(strategies_data, aes(x = strategy, y = mean_rides_ridden)) +    
  geom_bar(fill = colors,
           stat = "identity") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = -30, vjust = 1, hjust = 0.2)) +
  ylab("Mean Rides Ridden") +
  xlab("Strategies")

ggsave(path = p.fig, filename = "Mean Rides Ridden.png")

# === mean fun points plot ====
ggplot(strategies_data, aes(x = strategy, y = mean_fun_points)) +    
  geom_bar(fill = colors,
           stat = "identity") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = -30, vjust = 1, hjust = 0.2)) +
  ylab("Mean Fun Points") +
  xlab("Strategies")

ggsave(path = p.fig, filename = "Mean Fun Points.png")

