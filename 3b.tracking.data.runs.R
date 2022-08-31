
# === description ==============================================================
# This file can be run instead of 3a.tracking.data 
# The following loops run the simulation many (run_for) times.
# This repetition generates more data that can be averaged to provide a
# more robust comparison between the strategies so we can see which one is better.

# === 1a) generating data file RANDOM ==========================================
# generating data file and saving in data folder
visitor_tracker_file <- paste(p.data, "/", "RandomRun.csv", sep = "")

# === 1b) first run RANDOM =====================================================
# visitor tracker ts 1 
# creating time step 1 (building the data frame from scratch)
visitor_tracker <- f.initializing()

# adding visitor tracker (first time step) to data file
write.csv(visitor_tracker, visitor_tracker_file)

# saving first time step as newest time step
new_visitor_tracker <- data.frame(visitor_tracker)

# starting loop (rest of the time steps)
for(i in time_steps){
  # we skip the first time step because it was already created using initializing 
  # function
  if(i==1) next
  
  # visitor_tracker_i becomes the newest visitor tracker
  visitor_tracker_i <- new_visitor_tracker
  
  # changing time step
  repeated_steps_i <- rep(time_steps[i], park_capacity)
  visitor_tracker_i$time_step <- repeated_steps_i
  
  # we create a new data frame that includes only the waiters (this is also done 
  # within the next time step function but for some reason the program only runs 
  # if the line is repeated here)
  waiting_visitors <- visitor_tracker_i[visitor_tracker_i[5] >1,]
  
  # getting visitor tracker for next time step
  visitor_tracker_i <- f.get_next_time_step_random()
  
  # appending visitor_tracker_i to complete visitor tracker file
  write.table(visitor_tracker_i, visitor_tracker_file, sep = ",", 
              col.names = !file.exists(visitor_tracker_file), append = T)
  
  # turning new_visitor_tracker back into visitor_tracker_i and it fucking works!
  new_visitor_tracker <- visitor_tracker_i
}

# === 1c) runs loop RANDOM =====================================================
# opening runs loop
for(i in runs){
  # we skip first run coz we already did that
  if(i == 1) next
  
  # === visitor tracker ts 1====================================================
  # creating time step 1 (building the data frame from scratch)
  visitor_tracker <- f.initializing()
  
  # saving first time step as newest time step
  new_visitor_tracker <- data.frame(visitor_tracker)
  
  # appending visitor_tracker to complete visitor tracker file
  write.table(visitor_tracker, visitor_tracker_file, sep = ",", 
              col.names = !file.exists(visitor_tracker_file), append = T)
  
  # === cycle loop =============================================================
  #starting loop
  for(j in time_steps){
    # we skip the first time step because it was already created using initializing 
    # function
    if(j == 1) next
    
    # visitor_tracker_i becomes the newest visitor tracker
    visitor_tracker_i <- new_visitor_tracker
    
    # changing time step
    repeated_steps_i <- rep(time_steps[j], park_capacity)
    visitor_tracker_i$time_step <- repeated_steps_i
    
    # we create a new data frame that includes only the waiters (this is also done 
    # within the next time step function but for some reason the program only runs 
    # if the line is repeated here)
    waiting_visitors <- visitor_tracker_i[visitor_tracker_i[5] >1,]
    
    # getting visitor tracker for next time step
    visitor_tracker_i <- f.get_next_time_step_random()
    
    # appending visitor_tracker_i to complete visitor tracker file
    write.table(visitor_tracker_i, visitor_tracker_file, sep = ",", 
                col.names = !file.exists(visitor_tracker_file), append = T)
    
    # turning new_visitor_tracker back into visitor_tracker_i and it fucking works!
    new_visitor_tracker <- visitor_tracker_i
  }
}

# === 1d) final data file RANDOM ===============================================

# reading data
visitor_data <- read.csv(paste(p.data, "/", "RandomRun.csv", sep = ""))

# deleting X column
visitor_data <- subset(visitor_data, select = -X)

# filling in run column
visitor_data$run <- sort(c(rep(runs, park_capacity*cycle)))

# now we add it back to the file
write.csv(visitor_data, visitor_tracker_file)

#___ end of 3.tracking.data.runs _______________________________________________

# === 2a) generating data files COOLER BETTER ==================================
# generating data file and saving in data folder
visitor_tracker_file <- paste(p.data, "/", "CoolerBetterRun.csv", sep = "")

# === 2b) first run COOLER BETTER ======================================================
# visitor tracker ts 1 
# creating time step 1 (building the data frame from scratch)
visitor_tracker <- f.initializing()

# adding visitor tracker (first time step) to data file
write.csv(visitor_tracker, visitor_tracker_file)

# saving first time step as newest time step
new_visitor_tracker <- data.frame(visitor_tracker)

# starting loop (rest of the time steps)
for(i in time_steps){
  # we skip the first time step because it was already created using initializing 
  # function
  if(i==1) next
  
  # visitor_tracker_i becomes the newest visitor tracker
  visitor_tracker_i <- new_visitor_tracker
  
  # changing time step
  repeated_steps_i <- rep(time_steps[i], park_capacity)
  visitor_tracker_i$time_step <- repeated_steps_i
  
  # we create a new data frame that includes only the waiters (this is also done 
  # within the next time step function but for some reason the program only runs 
  # if the line is repeated here)
  waiting_visitors <- visitor_tracker_i[visitor_tracker_i[5] >1,]
  
  # getting visitor tracker for next time step
  visitor_tracker_i <- f.get_next_time_step_cooler_better()
  
  # appending visitor_tracker_i to complete visitor tracker file
  write.table(visitor_tracker_i, visitor_tracker_file, sep = ",", 
              col.names = !file.exists(visitor_tracker_file), append = T)
  
  # turning new_visitor_tracker back into visitor_tracker_i and it fucking works!
  new_visitor_tracker <- visitor_tracker_i
}

# === 2c) runs loop COOLER BETTER ======================================================
# opening runs loop
for(i in runs){
  # we skip first run coz we already did that
  if(i == 1) next
  
  # === visitor tracker ts 1====================================================
  # creating time step 1 (building the data frame from scratch)
  visitor_tracker <- f.initializing()
  
  # saving first time step as newest time step
  new_visitor_tracker <- data.frame(visitor_tracker)
  
  # appending visitor_tracker to complete visitor tracker file
  write.table(visitor_tracker, visitor_tracker_file, sep = ",", 
              col.names = !file.exists(visitor_tracker_file), append = T)
  
  # === cycle loop =============================================================
  #starting loop
  for(j in time_steps){
    # we skip the first time step because it was already created using initializing 
    # function
    if(j == 1) next
    
    # visitor_tracker_i becomes the newest visitor tracker
    visitor_tracker_i <- new_visitor_tracker
    
    # changing time step
    repeated_steps_i <- rep(time_steps[j], park_capacity)
    visitor_tracker_i$time_step <- repeated_steps_i
    
    # we create a new data frame that includes only the waiters (this is also done 
    # within the next time step function but for some reason the program only runs 
    # if the line is repeated here)
    waiting_visitors <- visitor_tracker_i[visitor_tracker_i[5] >1,]
    
    # getting visitor tracker for next time step
    visitor_tracker_i <- f.get_next_time_step_cooler_better()
    
    # appending visitor_tracker_i to complete visitor tracker file
    write.table(visitor_tracker_i, visitor_tracker_file, sep = ",", 
                col.names = !file.exists(visitor_tracker_file), append = T)
    
    # turning new_visitor_tracker back into visitor_tracker_i and it fucking works!
    new_visitor_tracker <- visitor_tracker_i
  }
}

# === 2d) final data file COOLER BETTER ================================================

# reading data
visitor_data <- read.csv(paste(p.data, "/", "CoolerBetterRun.csv", sep = ""))

# deleting X column
visitor_data <- subset(visitor_data, select = -X)

# filling in run column
visitor_data$run <- sort(c(rep(runs, park_capacity*cycle)))

# now we add it back to the file
write.csv(visitor_data, visitor_tracker_file)

#___ end of 3.tracking.data.runs _______________________________________________

# === 3a) generating data files SHORTEST WAIT ==================================
# generating data file and saving in data folder
visitor_tracker_file <- paste(p.data, "/", "ShortestWaitRun.csv", sep = "")

# === 3b) first run SHORTEST WAIT ===============================================
# visitor tracker ts 1 
# creating time step 1 (building the data frame from scratch)
visitor_tracker <- f.initializing()

# adding visitor tracker (first time step) to data file
write.csv(visitor_tracker, visitor_tracker_file)

# saving first time step as newest time step
new_visitor_tracker <- data.frame(visitor_tracker)

# starting loop (rest of the time steps)
for(i in time_steps){
  # we skip the first time step because it was already created using initializing 
  # function
  if(i==1) next
  
  # visitor_tracker_i becomes the newest visitor tracker
  visitor_tracker_i <- new_visitor_tracker
  
  # changing time step
  repeated_steps_i <- rep(time_steps[i], park_capacity)
  visitor_tracker_i$time_step <- repeated_steps_i
  
  # we create a new data frame that includes only the waiters (this is also done 
  # within the next time step function but for some reason the program only runs 
  # if the line is repeated here)
  waiting_visitors <- visitor_tracker_i[visitor_tracker_i[5] >1,]
  
  # getting visitor tracker for next time step
  visitor_tracker_i <- f.get_next_time_step_shortest_wait()
  
  # appending visitor_tracker_i to complete visitor tracker file
  write.table(visitor_tracker_i, visitor_tracker_file, sep = ",", 
              col.names = !file.exists(visitor_tracker_file), append = T)
  
  # turning new_visitor_tracker back into visitor_tracker_i and it fucking works!
  new_visitor_tracker <- visitor_tracker_i
}

# === 3c) runs loop SHORTEST WAIT ===============================================
# opening runs loop
for(i in runs){
  # we skip first run coz we already did that
  if(i == 1) next
  
  # === visitor tracker ts 1====================================================
  # creating time step 1 (building the data frame from scratch)
  visitor_tracker <- f.initializing()
  
  # saving first time step as newest time step
  new_visitor_tracker <- data.frame(visitor_tracker)
  
  # appending visitor_tracker to complete visitor tracker file
  write.table(visitor_tracker, visitor_tracker_file, sep = ",", 
              col.names = !file.exists(visitor_tracker_file), append = T)
  
  # === cycle loop =============================================================
  #starting loop
  for(j in time_steps){
    # we skip the first time step because it was already created using initializing 
    # function
    if(j == 1) next
    
    # visitor_tracker_i becomes the newest visitor tracker
    visitor_tracker_i <- new_visitor_tracker
    
    # changing time step
    repeated_steps_i <- rep(time_steps[j], park_capacity)
    visitor_tracker_i$time_step <- repeated_steps_i
    
    # we create a new data frame that includes only the waiters (this is also done 
    # within the next time step function but for some reason the program only runs 
    # if the line is repeated here)
    waiting_visitors <- visitor_tracker_i[visitor_tracker_i[5] >1,]
    
    # getting visitor tracker for next time step
    visitor_tracker_i <- f.get_next_time_step_shortest_wait()
    
    # appending visitor_tracker_i to complete visitor tracker file
    write.table(visitor_tracker_i, visitor_tracker_file, sep = ",", 
                col.names = !file.exists(visitor_tracker_file), append = T)
    
    # turning new_visitor_tracker back into visitor_tracker_i and it fucking works!
    new_visitor_tracker <- visitor_tracker_i
  }
}

# === 3d) final data file SHORTEST WAIT =========================================

# reading data
visitor_data <- read.csv(paste(p.data, "/", "ShortestWaitRun.csv", sep = ""))

# deleting X column
visitor_data <- subset(visitor_data, select = -X)

# filling in run column
visitor_data$run <- sort(c(rep(runs, park_capacity*cycle)))

# now we add it back to the file
write.csv(visitor_data, visitor_tracker_file)

#___ end of 3.tracking.data.runs _______________________________________________

