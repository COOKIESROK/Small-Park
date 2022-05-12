
# === description ==============================================================
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

# finding minimum satisfaction
least_satisfied_visitor <- range(visitor_data$satisfaction)[1]
# finding visitors with lowest satisfaction (uncomment the [3] to see ids only)
least_satisfied_visitor_id <- 
  visitor_data[visitor_data$satisfaction == least_satisfied_visitor,]#[3]
# finding the least satisfied visitors at the end of the cycle
end_of_cycle_least_satisfied_visitor <- least_satisfied_visitor_id[
  least_satisfied_visitor_id$time_step == cycle,]
# looking at these visitors' id
end_of_cycle_least_satisfied_visitor_id <- as.integer(
  end_of_cycle_least_satisfied_visitor[3])
# looking at these visitors' history
end_of_cycle_least_satisfied_visitor_history <- visitor_data[
  visitor_data$visitors == end_of_cycle_least_satisfied_visitor_id,]
 
# finding maximum satisfaction
most_satisfied_visitor <- range(visitor_data$satisfaction)[2]
# finding visitors with highest satisfaction (uncomment the [3] to see ids only)
most_satisfied_visitor_id <- 
  visitor_data[visitor_data$satisfaction == most_satisfied_visitor,]#[3]
# finding the most satisfied visitors at the end of the cycle
end_of_cycle_most_satisfied_visitor <- most_satisfied_visitor_id[
  most_satisfied_visitor_id$time_step == cycle,]
# looking at these visitors' id
end_of_cycle_most_satisfied_visitor_id <- as.integer(
  end_of_cycle_most_satisfied_visitor[3])
# looking at these visitors' history
end_of_cycle_most_satisfied_visitor_history <- visitor_data[
  visitor_data$visitors == end_of_cycle_most_satisfied_visitor_id,]

# looking at mean satisfaction for all visitors throughout the day
mean_satisfaction <- round(mean(visitor_data$satisfaction), digits = 1)

# looking at mean satisfaction for all visitors at the end of the day
final_mean_satisfaction <- 
  round(mean(visitor_data$satisfaction[visitor_data$time_step == cycle]), 
        digits = 1)

# looking at standard deviation of satisfaction
var_satisfaction <- round(var(visitor_data$satisfaction), digits = 1)

# looking at standard deviation of satisfaction at the end of the day
final_var_satisfaction <- 
  round(var(visitor_data$satisfaction[visitor_data$time_step == cycle]), 
        digits = 2)

# 3) descriptive stats waiting =================================================
# looking at the end of the cycle
final_visitor_tracker <- visitor_data[visitor_data$time_step == cycle,]

# looking at the visitors that spent the least and most time steps waiting
# at the end of the cycle
waited_range <- range(final_visitor_tracker$waited)

# finding min time steps waited at the end of the cycle
least_waited_visitor <- range(final_visitor_tracker$waited)[1]
# finding visitors with least time steps waited (uncomment the [3] to see ids only)
least_waited_visitor_id <- 
  final_visitor_tracker[final_visitor_tracker$waited == least_waited_visitor,]#[3]

# finding max time steps waited at the end of the cycle
most_waited_visitor <- range(final_visitor_tracker$waited)[2]
# finding visitors with least time steps waited (uncomment the [3] to see ids only)
most_waited_visitor_id <- 
  final_visitor_tracker[final_visitor_tracker$waited == most_waited_visitor,]#[3]

# looking at mean number of waited time steps for all visitors at the end of cycle
mean_waited <- round(mean(final_visitor_tracker$waited), digits = 1)

# looking at standard deviation of waited timesteps at the end of cycle
var_waited <- round(var(final_visitor_tracker$waited), digits = 1)

# looking at standard deviation of waited time steps at the end of the cycle
final_var_waited <- 
  round(var(final_visitor_tracker$waited), 
        digits = 2)
#___ end _______________________________________________________________________





