
# === description ===========================================================================
## brief description what the script file is about
#

# This file calls the functions from 2.functions.R to create the main visitor 
# tracker and update it after each time step. Currently to update a time step, 
# the previous one is duplicated, time step number updated, and then the information
# within the frame is also updated (using the functions I created). 
# 
# For some reason though, line 36 breaks the program because it claims the row names
# are being duplicated. I have tried different methods to fix this but none seem to work.


# === 1) visitor tracker ts 1===================================================
visitor_tracker <- f.initializing()

# === 2) visitor tracker ts 2===================================================
# copying visitor tracker
visitor_tracker2 <-data.frame(visitor_tracker)
new_visitor_tracker <- visitor_tracker2

# change the time steps
repeated_steps2 <- rep(time_steps[2], park_capacity)
new_visitor_tracker[1] <- repeated_steps2

# we create a new data frame that includes only the waiters (this is also done 
# within the next time step function but for some reason the program only runs 
# if the line is repeated here)
waiting_visitors <- new_visitor_tracker[new_visitor_tracker[4] >1,]

# getting visitor tracker for time step 2
new_visitor_tracker <- f.get_next_time_step()

# merging both visitor trackers into a single data frame
complete_visitor_tracker <- rbind(visitor_tracker, new_visitor_tracker)

# === 2) visitor tracker ts 3===================================================
# following the exact same steps as the previous time step
visitor_tracker3 <-data.frame(visitor_tracker2)
new_visitor_tracker <- visitor_tracker3
repeated_steps3 <- rep(time_steps[3], park_capacity)
new_visitor_tracker[1] <- repeated_steps3
waiting_visitors <- new_visitor_tracker[new_visitor_tracker[4] >1,]
new_visitor_tracker <- f.get_next_time_step()
complete_visitor_tracker <- rbind(complete_visitor_tracker, new_visitor_tracker)

# === 2) visitor tracker ts 4 ==================================================
# following the exact same steps as the previous time step
visitor_tracker4 <-data.frame(visitor_tracker3)
new_visitor_tracker <- visitor_tracker4
repeated_steps4 <- rep(time_steps[4], park_capacity)
new_visitor_tracker[1] <- repeated_steps4
waiting_visitors <- new_visitor_tracker[new_visitor_tracker[4] >1,]
new_visitor_tracker <- f.get_next_time_step()
complete_visitor_tracker <- rbind(complete_visitor_tracker, new_visitor_tracker)

# === 2) visitor tracker ts 5 ==================================================
# following the exact same steps as the previous time step
visitor_tracker5 <-data.frame(visitor_tracker4)
new_visitor_tracker <- visitor_tracker5
repeated_steps5 <- rep(time_steps[5], park_capacity)
new_visitor_tracker[1] <- repeated_steps5
waiting_visitors <- new_visitor_tracker[new_visitor_tracker[4] >1,]
new_visitor_tracker <- f.get_next_time_step()
complete_visitor_tracker <- rbind(complete_visitor_tracker, new_visitor_tracker)

# === 2) visitor tracker ts 6 ==================================================
# following the exact same steps as the previous time step
visitor_tracker6 <-data.frame(visitor_tracker5)
new_visitor_tracker <- visitor_tracker6
repeated_steps6 <- rep(time_steps[6], park_capacity)
new_visitor_tracker[1] <- repeated_steps6
waiting_visitors <- new_visitor_tracker[new_visitor_tracker[4] >1,]
new_visitor_tracker <- f.get_next_time_step()
complete_visitor_tracker <- rbind(complete_visitor_tracker, new_visitor_tracker)

# === 2) visitor tracker ts 7 ==================================================
# following the exact same steps as the previous time step
visitor_tracker7 <-data.frame(visitor_tracker6)
new_visitor_tracker <- visitor_tracker7
repeated_steps7 <- rep(time_steps[7], park_capacity)
new_visitor_tracker[1] <- repeated_steps7
waiting_visitors <- new_visitor_tracker[new_visitor_tracker[4] >1,]
new_visitor_tracker <- f.get_next_time_step()
complete_visitor_tracker <- rbind(complete_visitor_tracker, new_visitor_tracker)

# === 2) visitor tracker ts 8 ==================================================
# following the exact same steps as the previous time step
visitor_tracker8 <-data.frame(visitor_tracker7)
new_visitor_tracker <- visitor_tracker8
repeated_steps8 <- rep(time_steps[8], park_capacity)
new_visitor_tracker[1] <- repeated_steps8
waiting_visitors <- new_visitor_tracker[new_visitor_tracker[4] >1,]
new_visitor_tracker <- f.get_next_time_step()
complete_visitor_tracker <- rbind(complete_visitor_tracker, new_visitor_tracker)

# === 2) visitor tracker ts 9 ==================================================
# following the exact same steps as the previous time step
visitor_tracker9 <-data.frame(visitor_tracker8)
new_visitor_tracker <- visitor_tracker9
repeated_steps9 <- rep(time_steps[9], park_capacity)
new_visitor_tracker[1] <- repeated_steps9
waiting_visitors <- new_visitor_tracker[new_visitor_tracker[4] >1,]
new_visitor_tracker <- f.get_next_time_step()
complete_visitor_tracker <- rbind(complete_visitor_tracker, new_visitor_tracker)

# === 2) visitor tracker ts 10 ==================================================
# following the exact same steps as the previous time step
visitor_tracker10 <-data.frame(visitor_tracker9)
new_visitor_tracker <- visitor_tracker9
repeated_steps9 <- rep(time_steps[10], park_capacity)
new_visitor_tracker[1] <- repeated_steps9
waiting_visitors <- new_visitor_tracker[new_visitor_tracker[4] >1,]
new_visitor_tracker <- f.get_next_time_step()
complete_visitor_tracker <- rbind(complete_visitor_tracker, new_visitor_tracker)

# === testing for loop===================================================
# # The problem here is that it only ever saves 2 time steps and I wanna save 
# # them all.
# for(i in time_steps){
#   complete_visitor_tracker <- rbind(visitor_tracker, new_visitor_tracker)
#   # copying visitor tracker
#   new_visitor_tracker <-data.frame(visitor_tracker)
# 
#   # change the time steps
#   next_repeated_steps <- rep(time_steps[i], park_capacity)
#   new_visitor_tracker[1] <- next_repeated_steps
# 
#   # we create a new data frame that includes only the waiters (this is also done
#   # within the next time step function but for some reason the program only runs
#   # if the line is repeated here)
#   waiting_visitors <- new_visitor_tracker[new_visitor_tracker[4] >1,]
# 
#   # getting visitor tracker for time step 2
#   new_visitor_tracker <- f.get_next_time_step()
# 
#   # merging both visitor trackers into a single data frame
#   complete_visitor_tracker <- rbind(complete_visitor_tracker, new_visitor_tracker)
#   }

# === generating data file =====================================================
# generating data file and saving in data folder
visitor_tracker_file <- paste(p.data, "/", "CompleteVisitorTracker.csv", sep = "")
write.csv(complete_visitor_tracker, visitor_tracker_file)
#___ end _______________________________________________________________________





