
# === description ==============================================================

# This file calls the functions from 2.functions.R to create the main visitor 
# tracker and update it after each time step. 
# Each time step is created by running the loop cycle number of times. 
# Section 2 generates a data file that is populated by the data created in 
# section 3. This csv contains the complete visitor tracker and is used in
# 4.analysis.R and 5.figures.R

# === 1a) visitor tracker ts 1===================================================
# creating time step 1 (building the data frame from scratch)
visitor_tracker <- f.initializing()

# saving first time step as newest time step
new_visitor_tracker <- data.frame(visitor_tracker)

# === 1b) generating data file ==================================================
# generating data file and saving in data folder
random_tracker_file <- paste(p.data, "/", "RandomVisitorTracker.csv", sep = "")

# adding visitor tracker (first time step)
write.csv(visitor_tracker, random_tracker_file)

# === 1c) cycle loop ============================================================
#starting loop
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
  waiting_visitors <- visitor_tracker_i[visitor_tracker_i$spot_in_line >1,]
  
  # getting visitor tracker for next time step
  visitor_tracker_i <- f.get_next_time_step_random()
  
  # appending visitor_tracker_i to complete visitor tracker file
  write.table(visitor_tracker_i, random_tracker_file, sep = ",", 
              col.names = !file.exists(random_tracker_file), append = T)
  
  # turning new_visitor_tracker back into visitor_tracker_i and it fucking works!
  new_visitor_tracker <- visitor_tracker_i

}

#___ end of 3.tracking.data ____________________________________________________

# === 2a) visitor tracker ts 1 COOLER BETTER ====================================
# creating time step 1 (building the data frame from scratch)
visitor_tracker <- f.initializing()

# saving first time step as newest time step
new_visitor_tracker <- data.frame(visitor_tracker)

# === 2a) generating data file COOLER BETTER ====================================
# generating data file and saving in data folder
cooler_better_tracker_file <- paste(p.data, "/", 
                              "CoolerBetterVisitorTracker.csv", sep = "")

# adding visitor tracker (first time step)
write.csv(visitor_tracker, cooler_better_tracker_file)

# === 2c) cycle loop COOLER BETTER ==============================================
#starting loop
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
  waiting_visitors <- visitor_tracker_i[visitor_tracker_i$spot_in_line > 1,]
  
  # getting visitor tracker for next time step
  visitor_tracker_i <- f.get_next_time_step_cooler_better()
  
  # appending visitor_tracker_i to complete visitor tracker file
  write.table(visitor_tracker_i, cooler_better_tracker_file, sep = ",", 
              col.names = !file.exists(cooler_better_tracker_file), append = T)
  
  # turning new_visitor_tracker back into visitor_tracker_i and it fucking works!
  new_visitor_tracker <- visitor_tracker_i
  
}

#___ end of 3.tracking.data ____________________________________________________
# === 3a) visitor tracker ts 1 SHORTEST WAIT ====================================
# creating time step 1 (building the data frame from scratch)
visitor_tracker <- f.initializing()

# saving first time step as newest time step
new_visitor_tracker <- data.frame(visitor_tracker)

# === 3b) generating data file SHORTEST WAIT ====================================
# generating data file and saving in data folder
shortest_wait_tracker_file <- paste(p.data, "/", 
                              "ShortestWaitVisitorTracker.csv", sep = "")

# adding visitor tracker (first time step)
write.csv(visitor_tracker, shortest_wait_tracker_file)

# === 3c) cycle loop SHORTEST WAIT ==============================================
#starting loop
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
  waiting_visitors <- visitor_tracker_i[visitor_tracker_i$spot_in_line >1,]
  
  # getting visitor tracker for next time step
  visitor_tracker_i <- f.get_next_time_step_shortest_wait()
  
  # appending visitor_tracker_i to complete visitor tracker file
  write.table(visitor_tracker_i, shortest_wait_tracker_file, sep = ",", 
              col.names = !file.exists(shortest_wait_tracker_file), append = T)
  
  # turning new_visitor_tracker back into visitor_tracker_i and it fucking works!
  new_visitor_tracker <- visitor_tracker_i
  
}

#___ end of 3.tracking.data ____________________________________________________
