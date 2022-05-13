
# === general ==================================================================

# author: Sofia Graves
# R version
# "R version 4.1.2 (2021-11-01)"
# NOTE: run the 1.main.R before starting your session.

# === script index and note ====================================================
# 1.main.R        
# 2.functions.R
# 3.tracking.data.R
# 4.analysis.R
# 5.figures.R

# this script only assigns values to global variables and creates the folders
# where data and figures will be stored. It is not computationally intensive and
# should be run fully before moving on to script 2.functions.R


# === global variables =========================================================

wk.dir <- getwd()
# max number of visitors
park_capacity <- 12
visitors <- c(1:park_capacity)
# max number of visitors that can ride a ride at each time
ride_capacity <- 3
# the 3 rides in the park
rides <- c("coolest", "okayest", "lamest")
# the number of time steps in a day
cycle <- 5
time_steps <- c(1:cycle)
# cool points that each ride gives a visitor (coolest, okayest, lamest)
cool_points <- c(10,5,1)
# true max satisfaction would come from riding the coolest ride every time step
true_max_satisfaction <- cool_points[1]*cycle

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

#___ end _______________________________________________________________________

