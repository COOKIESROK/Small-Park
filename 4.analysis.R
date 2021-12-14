
# === description ===========================================================================
## brief description what the script file is about
#

# ******************************************************************************
## use descriptive names 
# 1) read clean data  load data from clean data folder and ...
# 2) anova      lm to test ...

# === 1) read data =============================================================
# reading data
visitor_data <- read.csv(paste(p.data, "/", "CompleteVisitorTracker.csv", sep = ""))

#inspecting data
head(visitor_data)
str(visitor_data)

# === analyzing visitor satisfaction ===============
# looking at the least and most satisfied visitors
satisfaction_range <- range(visitor_data$satisfaction)
least_satisfied_visitor <- range(visitor_data$satisfaction)[1]
least_satisfied_visitor_id <- 
  visitor_data[visitor_data$satisfaction == least_satisfied_visitor,][3]
most_satisfied_visitor <- range(visitor_data$satisfaction)[2]
most_satisfied_visitor_id <- 
  visitor_data[visitor_data$satisfaction == most_satisfied_visitor,][3]

# looking at mean satisfaction
mean_satisfaction <- mean(new_visitor_tracker$satisfaction)

# satisfaction distribution histogram?



#___ end _______________________________________________________________________





