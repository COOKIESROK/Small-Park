
# === description ===========================================================================
## brief description what the script file is about
#

# This file calls the functions from 2.functions.R to create the main visitor 
# tracker and update it after each time step. 
# Each tie step is created by running each section of the file. I tried to create 
# a loop (section 12) but ended up deciding against it because I wanted to 
# save the separate time step trackers (I am not sure why I wanted to save them
# but I did).
# This file can be run one time step at a time or all at once. Section 11 saves
# a csv file with the complete visitor tracker. This data file is used in
# 4.analysis.R and 5.figures.R

# === 1) visitor tracker ts 1===================================================
visitor_tracker <- f.initializing()

# === 11) generating data file =================================================
# generating data file and saving in data folder
visitor_tracker_file <- paste(p.data, "/", "CompleteVisitorTracker.csv", sep = "")

# adding visitor tracker (first time step)
write.csv(visitor_tracker, visitor_tracker_file)

# === loop ====
#starting loop
for(i in time_steps){
  # we skip the first time step because it was already created using initializing 
  # function
  if(i==1) next
  
  # copying visitor tracker
  visitor_tracker_i <-data.frame(visitor_tracker)
  new_visitor_tracker <- visitor_tracker_i
  
  # changing time step
  repeated_steps_i <- rep(time_steps[i], park_capacity)
  new_visitor_tracker[1] <- repeated_steps_i
  
  # we create a new data frame that includes only the waiters (this is also done 
  # within the next time step function but for some reason the program only runs 
  # if the line is repeated here)
  waiting_visitors <- new_visitor_tracker[new_visitor_tracker[4] >1,]
  
  # getting visitor tracker for next time step
  new_visitor_tracker <- f.get_next_time_step()
  
  # appending new_visitor_tracker to complete visitor tracker file
  write.table(new_visitor_tracker, visitor_tracker_file, sep = ",", 
              col.names = !file.exists(visitor_tracker_file), append = T)
  
  # merging both visitor trackers into a single data frame
  # complete_visitor_tracker <- rbind(visitor_tracker, new_visitor_tracker)
  
  # what if complete visitor tracker never existed
  
  
  # turning new visitor tracker back into visitor tracker i
  visitor_tracker_i <- new_visitor_tracker
}


#___ end _______________________________________________________________________





