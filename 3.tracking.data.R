
# === description ===========================================================================
## brief description what the script file is about
#

# === 1) visitor tracker =======================================================
# creating a list of time stamps that repeats each times tamp for each guest
repeated_stamps <- rep(time_stamps, park_capacity)

# creating data frame with the time stamps sorted in ascending order
visitor_tracker <- as.data.frame(matrix(sort(repeated_stamps)))
colnames(visitor_tracker) <- c("time stamp")

# adding visitor column to data frame
visitor_tracker$visitors <- rep(visitors)

# adding ride column to data frame
visitor_tracker$ride <- f.ride_picker(visitor_col, assigned_ride)

# adding spot in line column to the data frame
#visitor_tracker$spot_in_line <- NA
#visitor_tracker$spot_in_line <- f.get_spot_in_line(visitor_tracker)
visitor_tracker$spot_in_line <- f.get_spot_in_line_looped(visitor_tracker)


# adding status column to the data frame
# visitor_tracker$status <- NA
# visitor_tracker$status <- f.get_status(visitor_tracker)
visitor_tracker$status <- f.get_status_looped(visitor_tracker)


#___ end _______________________________________________________________________





