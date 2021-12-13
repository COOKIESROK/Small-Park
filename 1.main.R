
# === general ==================================================================

# authors: Sofia Graves
# 
# R version
# "R version 4.1.2 (2021-11-01)"
# NOTE: run the 1.main.R before starting your session.
#
#
# === script index =============================================================

# 1.main.R        
# 2.functions.R
# 3.tracking.data.R
# 4.analysis.R
# 5.figures.R

# === global variables =========================================================

wk.dir <- getwd() 
park_capacity <- 12
ride_capacity <- 3
rides <- c("coolest", "okayest", "lamest")
cycle <- 10
time_steps <- c(1:cycle)
visitors <- c(1:park_capacity)
cool_points <- c(10,5,1)

# === libraries ================================================================
# I haven't needed any libraries yet but might use ggplot later

# === folder management ========================================================
# folder names
folder.names <- c("a.data", "b.results","c.figures")

# create folders if they don't exit yet.
for(i in 1:length(folder.names)){
  if(file.exists(folder.names[i]) == FALSE){
    dir.create(folder.names[i])
  }
}

# ******************************************************************************

# paths to the folders. The 'p.' indicates the variable is a path.
# make sure the variable names describe the folder.names
p.data <- paste(wk.dir, "/", folder.names[1], "/", sep = "")
p.results <- paste(wk.dir, "/", folder.names[2], "/", sep = "")
p.fig <- paste(wk.dir, "/", folder.names[3], "/", sep = "")

# === run script ===============================================================

## you can run a scripts file as a batch the start. Only do this for code which  
## is really needed to run other script files. Take care not to force the user
## to run the whole project at once especially when computationally intensive

# run scripts needed to make other scripts files work (e.g. functions.R)
#source("your.code.R")

#___ end _______________________________________________________________________

