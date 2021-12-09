
# === description ===========================================================================
## brief description what the script file is about
#

# === 1) visitor tracker ts 1===================================================
# creating a list of time steps that repeats each times tamp for each guest
repeated_steps <- rep(time_steps[1], park_capacity)

# creating data frame with the time steps sorted in ascending order
visitor_tracker <- as.data.frame(matrix(sort(repeated_steps)))
colnames(visitor_tracker) <- c("time step")

# adding visitor column to data frame
visitor_tracker$visitors <- rep(visitors)

# adding ride column to data frame
visitor_tracker$ride <- f.ride_picker(visitor_col, assigned_ride)

# adding spot in line column to the data frame
visitor_tracker$spot_in_line <- f.get_spot_in_line_looped(visitor_tracker)

# adding status column to the data frame
visitor_tracker$status <- f.get_status_looped(visitor_tracker)

# === 2) visitor tracker ts 2===================================================
# copying visitor tracker
visitor_tracker2 <-data.frame(visitor_tracker)

# change the time steps
repeated_steps2 <- rep(time_steps[2], park_capacity)
visitor_tracker2[1] <- repeated_steps2

# done in 7 steps
# 1. create riding_visitors data frame
# 2. assign riding_visitors a new ride
# 3. create waiting visitors data frame
# 4. move waiting visitors one step up in line
# 5. merge both data frames
# 6. update everyones spot in line
# 7. update everyones status





#___ end _______________________________________________________________________





