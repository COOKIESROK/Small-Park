
# === general ==================================================================

# author: Sofia Graves
# R version
# "R version 4.1.2 (2021-11-01)"
# NOTE: run the 1.main.R file before starting your session.

# === script index and note ====================================================
# 1.main.R        
# 2.functions.R
# 3.tracking.data.R
# 4.analysis.R
# 5.figures.R

# this script only assigns values to global variables and creates the folders
# where data and figures will be stored. It is not computationally intensive and
# should be run fully before moving on to script 2.functions.R


# === user input ====
# max number of visitors
park_capacity <- 15

# rides data frame
# ride_name column
rides <- as.data.frame(c("coolest", "okayest", "lamest", "newest"))
#changing name of column
colnames(rides) <- "ride_name"

# max number of visitors that can ride a ride at each time
# the first number corresponds to the capacity of the coolest ride (see rides)
# adding to rides data frame
rides$ride_capacity <- c(2, 2, 2, 2)

# cool points that each ride gives a visitor (in the same order as the rides - 
# coolest first)
rides$ride_points <- c(10, 5, 1, 12)

# probability a rider will choose a given ride
# the first number corresponds to the probability of the coolest ride (see rides)
# adding to rides data frame
rides$ride_prob <- c(0.8, 0.4, 0.2, 0.8)

# how many time steps each ride lasts 
rides$ride_duration <- c(1, 2, 3, 4)

# the number of time steps in a day
cycle <- 4

# number of times each strategy will run
run_for <- 10

# === global variables =========================================================
# getting working directory
wk.dir <- getwd()

# counting visitors
visitors <- c(1:park_capacity)

# creating states for visitors, they can either be riding or waiting to ride
# any of the rides
# this vector will be replaced with the loop I just created 
# states <- c("r_coolest", "w_coolest", "r_okayest", "w_okayest", "r_lamest", 
#             "w_lamest")
states <- vector()
# filling in the states vector
for(i in 1:length(rides)) {
  new_states <- c(paste("r_", rides$ride_name[i], sep = ""), 
                  paste("w_", rides$ride_name[i], sep = ""))     
  states <- c(states, new_states) 
}

# creating stages for the rides, a ride can either be in progress or in its final 
# time step
stages <- vector()
# filling in the states vector
for(i in 1:length(rides)) {
  new_stages <- c(paste("p_", rides$ride_name[i], sep = ""), 
                  paste("f_", rides$ride_name[i], sep = ""))     
  stages <- c(stages, new_stages) 
}

# counting time steps
time_steps <- c(1:cycle)

# loop for cool points
cool_points <- vector()
for(i in 1:length(rides$ride_points)){
  add_points <- c(rides$ride_points[i], 0)
  cool_points <- c(cool_points, add_points)
}

# true max satisfaction would come from riding the coolest ride every time step
true_max_satisfaction <- cool_points[1]*cycle

# counting runs
runs <- c(1:run_for)

# === folder management ========================================================
# folder names
folder.names <- c("a.data", "b.figures")

# create folders if they don't exit yet
for(i in 1:length(folder.names)){
  if(file.exists(folder.names[i]) == FALSE){
    dir.create(folder.names[i])
  }
}

# paths to the folders. The 'p.' indicates the variable is a path.
p.data <- paste(wk.dir, "/", folder.names[1], "/", sep = "")
p.fig <- paste(wk.dir, "/", folder.names[2], "/", sep = "")

#___ end of 1.main _____________________________________________________________
