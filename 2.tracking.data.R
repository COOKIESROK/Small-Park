
# === description ===========================================================================
## brief description what the script file is about
#

# === 1) ride assigner =========================================================
# for random ride picking
random_ride <- as.data.frame(sample(x = rides,
                                    size = park_capacity,
                                    replace = TRUE))
colnames(random_ride) <- "ride"

assigned_ride <- random_ride

### I will start by working with random but eventually switch to biased rides
### so comment out a chunk of this section to use one or the other
# # for biased ride picking
# biased_ride <- sample(x = rides,
#                          size = park_capacity,
#                          replace = TRUE,
#                          prob = c(0.6, 0.4, 0.1))
# assigned_ride <- biased_ride

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

# this works now we need to tidy it so the rides are columns and presence is 1
visitor_tracker <- pivot_wider(long_visitor_tracker, names_from = "ride", 
                               values_from = "visitors")

# === 3) ..... =================================================================


#___ end _______________________________________________________________________





