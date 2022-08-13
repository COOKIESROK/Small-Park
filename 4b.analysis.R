
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






