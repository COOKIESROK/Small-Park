
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

str(visitor_tracker$ride)


# === 2) visitor tracker ts 2===================================================
# copying visitor tracker
new_visitor_tracker <-data.frame(visitor_tracker)

# we create a new data frame that includes only the waiters 
waiting_visitors <- new_visitor_tracker[new_visitor_tracker[4] >1,]

# change the time steps
repeated_steps2 <- rep(time_steps[2], park_capacity)
new_visitor_tracker[1] <- repeated_steps2

# getting visitor tracker for time step 2
new_visitor_tracker <- f.get_next_time_step()

# merging both visitor trackers into a single data frame
complete_visitor_tracker <- rbind(visitor_tracker, new_visitor_tracker)

#___ end _______________________________________________________________________





