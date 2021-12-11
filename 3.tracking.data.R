
# === description ===========================================================================
## brief description what the script file is about
#

# === 1) visitor tracker ts 1===================================================
visitor_tracker <- f.initializing()

# # === extra ========
# 
# # creating a list of time steps that repeats each times tamp for each guest
# repeated_steps <- rep(time_steps[1], park_capacity)
# 
# # creating data frame with the time steps sorted in ascending order
# visitor_tracker <- as.data.frame(matrix(sort(repeated_steps)))
# colnames(visitor_tracker) <- c("time step")
# 
# # adding visitor column to data frame
# visitor_tracker$visitors <- rep(visitors)
# 
# # adding ride column to data frame
# visitor_tracker$ride <- f.ride_picker(visitor_col, assigned_ride)
# 
# # adding spot in line column to the data frame
# visitor_tracker$spot_in_line <- f.get_spot_in_line(visitor_tracker)
# 
# # adding status column to the data frame
# visitor_tracker$status <- f.get_status(visitor_tracker)

# === 2) visitor tracker ts 2===================================================
# copying visitor tracker
new_visitor_tracker <-data.frame(visitor_tracker)

# we create a new data frame that includes only the waiters 
waiting_visitors <- new_visitor_tracker[new_visitor_tracker[4] >1,]

# change the time steps
repeated_steps2 <- rep(time_steps[2], park_capacity)
new_visitor_tracker[1] <- repeated_steps2

new_visitor_tracker <- f.get_next_time_step()
#rownames(new_visitor_tracker) <- c((park_capacity+1):(2*park_capacity))
rownames(new_visitor_tracker) = make.names(c((park_capacity+1):(2*park_capacity)), 
                                           unique=TRUE)

complete_visitor_tracker <- rbind(visitor_tracker, new_visitor_tracker)

# done in 7 steps
# 1. create riding_visitors data frame
# 2. assign riding_visitors a new ride
# 3. create waiting visitors data frame
# 4. move waiting visitors one step up in line
# 5. merge both data frames
# 6. update everyones spot in line
# 7. update everyones status





#___ end _______________________________________________________________________





