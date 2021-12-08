
# === description ===========================================================================
## brief description what the script file is about
#

# === 1) visitor tracker =======================================================
# creating a list of times tamps that repeats each times tamp for each guest
repeated_stamps <- rep(time_stamps, park_capacity)

# creating data frame with the time stamps sorted in ascending order
long_visitor_tracker <- as.data.frame(matrix(sort(repeated_stamps)))
colnames(long_visitor_tracker) <- c("time stamp")

# adding visitor column to data frame
long_visitor_tracker$visitors <- rep(visitors)

# === 2) first time stamp tracker ==============================================
# for this section to work properly time stamp must be 1
long_visitor_tracker$ride <- assigned_ride

# === 3) ..... =================================================================


#___ end _______________________________________________________________________





