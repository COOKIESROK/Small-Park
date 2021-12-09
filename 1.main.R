
# === general ==================================================================

# authors: Sofia
# 
# R version
# "R version 4.1.2 (2021-11-01)"
# NOTE: run the 1.main.R before starting your session.
#

# === notes ====================================================================

# various comments
# • numbering of files and folder is done to group based on same file type 
#   (folders, scripts and markdown files together in same sequence)
# •
# •
# 
## I often use this as a 'to do' list
#
# === script index =============================================================

# 1.main.R        
# 2.data.manip.R
# 3.analysis.R
# 4.functions.R
## and this can apply to figure functions too
# 5.figures.R
#
# === global variables =========================================================

wk.dir <- getwd() 
park_capacity <- 12
ride_capacity <- 3
rides <- c("coolest", "okayest", "lamest")
time_steps <- c(1:3)
visitors <- c(1:park_capacity)

# === libraries ================================================================

# # install packages needed for the project
# install.packages("tidyverse")
# 
# # load the libraries needed for the project to run 
# library("tidyverse")

# === folder management ========================================================

# folder names
## the a b c makes them ordered again, but not 
folder.names <- c("a.data.raw","b.data.clean", "c.results","d.figures")

# create folders if they don't exit yet. 
for(i in 1:length(folder.names)){ 
  if(file.exists(folder.names[i]) == FALSE){
    dir.create(folder.names[i])
  } 
}

# ******************************************************************************

# paths to the folders. The 'p.' indicates the variable is a path.
# make sure the variable names describe the folder.names
p.data.raw <- paste(wk.dir, "/", folder.names[1], "/", sep = "")
p.data.clean <- paste(wk.dir, "/", folder.names[2], "/", sep = "")
p.results <- paste(wk.dir, "/", folder.names[3], "/", sep = "")
p.fig <- paste(wk.dir, "/", folder.names[4], "/", sep = "")

# === run script ===============================================================

## you can run a scripts file as a batch the start. Only do this for code which  
## is really needed to run other script files. Take care not to force the user
## to run the whole project at once especially when computationally intensive

# run scripts needed to make other scripts files work (e.g. functions.R)
#source("your.code.R")

#___ end _______________________________________________________________________

