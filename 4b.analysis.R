
# === description ==

# === reading data ====
# random
random_visitor_data <- read.csv(paste(p.data, "/", "RandomRun.csv", sep = ""))
# cooler better
cooler_better_visitor_data <- read.csv(paste(p.data, "/", 
                                             "CoolerBetterRun.csv", sep = ""))
# shortest wait 
shortest_wait_visitor_data <- read.csv(paste(p.data, "/", 
                                             "ShortestWaitRun.csv", sep = ""))

# === inspecting data ==== 
# random 
head(random_visitor_data)
str(random_visitor_data)
# cooler better 
head(cooler_better_visitor_data)
str(cooler_better_visitor_data)
tail(cooler_better_visitor_data)
# shortest wait
head(shortest_wait_visitor_data)
str(shortest_wait_visitor_data)

# === mean visitor satisfaction =====
# random
random_mean_satisfaction <- round(mean(random_visitor_data$satisfaction), 
                                  digits = 1)
# cooler better
cooler_better_mean_satisfaction <- round(mean(cooler_better_visitor_data$satisfaction), 
                                  digits = 1)
# shortest wait
shortest_wait_mean_satisfaction <- round(mean(shortest_wait_visitor_data$satisfaction), 
                                  digits = 1)

# === mean ridden =====
# random
random_ridden <- round(mean(random_visitor_data$ridden), digits = 1)
# cooler better
cooler_better_ridden <- round(mean(cooler_better_visitor_data$ridden), digits = 1)
# shortest wait
shortest_wait_ridden <- round(mean(shortest_wait_visitor_data$ridden), digits = 1)

# === mean fun points =====
# random
random_fun_points <- round(mean(random_visitor_data$points), digits = 1)
# cooler better
cooler_better_fun_points <- round(mean(cooler_better_visitor_data$points), digits = 1)
# shortest wait
shortest_wait_fun_points <- round(mean(shortest_wait_visitor_data$points), digits = 1)

# === strategies summary =====
# creating a data frame with the strategy names
strategies_summary <- as.data.frame(c("random", "cooler better", "shortest wait"))

# changing name of column
colnames(strategies_summary) <- "strategy"

# mean satisfaction
strategies_summary$mean_satisfaction <- c(random_mean_satisfaction, 
                                          cooler_better_mean_satisfaction,
                                          shortest_wait_mean_satisfaction)

# mean rides ridden 
strategies_summary$mean_rides_ridden <- c(random_ridden, cooler_better_ridden,
                                          shortest_wait_ridden)


# mean fun points 
strategies_summary$mean_fun_points <- c(random_fun_points, cooler_better_fun_points,
                                          shortest_wait_fun_points)

# === generating file =====
# generating data file and saving in data folder
strategies_summary_file <- paste(p.data, "/", "StrategiesSummary.csv", sep = "")

# writing in file 
write.csv(strategies_summary, strategies_summary_file)







