
# === description ==============================================================
## brief description what the script file is about
# 

# === 1) ride picker =========================================================
visitor_col <- as.data.frame(matrix(visitors))
colnames(visitor_col) <- "visitors"
# for random ride picking
f.ride_picker <- function(visitor_col,assigned_ride){
  # for random ride picking
  random_ride <- as.data.frame(sample(x = rides,
                                      size = park_capacity,
                                      replace = TRUE))
  colnames(random_ride) <- "ride"
  assigned_ride <- random_ride
}
# added to visitor tracker in file 2
f.ride_picker(visitor_col, assigned_ride)

### I will start by working with random but eventually switch to biased rides
### so comment out a chunk of this section to use one or the other
# # for biased ride picking
# f.ride_picker <- function(visitor_col,assigned_ride){
#   # for biased ride picking
#   biased_ride <- as.data.frame(sample(x = rides,
#                                       size = park_capacity,
#                                       replace = TRUE, 
#                                       prob = c(0.6, 0.4, 0.1)))
#   colnames(biased_ride) <- "ride"
#   assigned_ride <- biased_ride
# }
# 
# f.ride_picker(visitor_col, assigned_ride)
#visitor_tracker$ride <- f.ride_picker(visitor_col, assigned_ride)

# === 2) spot in line ==========================================================
# this is so that it is possible for ALL visitors to be in line at the same ride
spots <- visitors
# creating spot in line column
# must be filtered by ride 
visitor_tracker$spot_in_line <- sort(rep(spots, ride_capacity))[1:park_capacity]

# attempt 2

visitor_tracker[visitor_tracker$ride == "coolest", ]$spot_in_line <- 
  sort(rep(spots, ride_capacity))[1:ride_capacity]

visitor_tracker[visitor_tracker$ride == "okayest", ]$spot_in_line <- 
  sort(rep(spots, ride_capacity))[1:ride_capacity]

visitor_tracker[visitor_tracker$ride == "lamest", ]$spot_in_line <- 
  sort(rep(spots, ride_capacity))[1:lamest_visitors]



# now let's turn that into a function
f.get_spot_in_line <- function(visitor_tracker){
  # counting visitors in line for the coolest ride
  coolest_visitors <- length(which(visitor_tracker$ride == "coolest"))
  # assigning a spot in line to each of them (each spot repeats to accommodate 
  # for ride capacity)
  visitor_tracker[visitor_tracker$ride == "coolest", ]$spot_in_line <- 
    sort(rep(spots, ride_capacity))[1:coolest_visitors]
  # counting visitors in line for the lamest ride
  okayest_visitors <- length(which(visitor_tracker$ride == "okayest"))
  # assigning a spot in line to each of them (each spot repeats to accommodate 
  # for ride capacity)
  visitor_tracker[visitor_tracker$ride == "okayest", ]$spot_in_line <- 
    sort(rep(spots, ride_capacity))[1:okayest_visitors]
  # counting visitors in line for the lamest ride
  lamest_visitors <- length(which(visitor_tracker$ride == "lamest"))
  # assigning a spot in line to each of them (each spot repeats to accommodate 
  # for ride capacity)
  visitor_tracker[visitor_tracker$ride == "lamest", ]$spot_in_line <- 
    sort(rep(spots, ride_capacity))[1:lamest_visitors]
}

f.get_spot_in_line(visitor_tracker)

# # === 2) status assigner =======================================================
# # creating states for visitors, they can either be riding or waiting to ride 
# # any of the rides
# states <- c("r_coolest", "w_coolest", "r_okayest", "w_okayest", "r_lamest", "w_lamest")
# 
# # adding status column to visitor_tracker
# visitor_tracker$status <- NA
# 
# # ride_capacity visitors get status riding for each ride
# for(i in visitors){
#   if(visitor_tracker$ride[i,] == "coolest"){
#     visitor_tracker$status <- states[1]
#   }
# }









