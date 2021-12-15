
# === description ===========================================================================
# This file looks at the descriptive statistics of the data file 
# "CompleteVisitorTracker.csv" generated in 3.tracking.data.R
# This script would be much more useful if used to compare cycles with different
# parameters (maybe in which rides were randomly assigned vs one in which they
# they were selected based on a factor such as current wait time or amount of 
# cool points they provide).

# ******************************************************************************
# 1) read data
# 2) descriptive stats visitor satisfaction
# 3) experiment scatter plot

# === 1) read data =============================================================
# reading data
visitor_data <- read.csv(paste(p.data, "/", "CompleteVisitorTracker.csv", sep = ""))

#inspecting data
head(visitor_data)
str(visitor_data)

# === 2) descriptive stats visitor satisfaction ================================
# looking at the least and most satisfied visitors
satisfaction_range <- range(visitor_data$satisfaction)
least_satisfied_visitor <- range(visitor_data$satisfaction)[1]
least_satisfied_visitor_id <- 
  visitor_data[visitor_data$satisfaction == least_satisfied_visitor,][3]
most_satisfied_visitor <- range(visitor_data$satisfaction)[2]
most_satisfied_visitor_id <- 
  visitor_data[visitor_data$satisfaction == most_satisfied_visitor,][3]

# looking at mean satisfaction for all visitors throughout the day
mean_satisfaction <- mean(visitor_data$satisfaction)

# looking at mean satisfaction for all visitors at the end of the day
final_mean_satisfaction <- 
  mean(visitor_data$satisfaction[visitor_data$time_step == 10])

# looking at standard deviation of satisfaction
var_satisfaction <- var(visitor_data$satisfaction)

# looking at standard deviation of satisfaction at the end of the day
final_var_satisfaction <- 
  var(visitor_data$satisfaction[visitor_data$time_step == 10])

#___ end _______________________________________________________________________





