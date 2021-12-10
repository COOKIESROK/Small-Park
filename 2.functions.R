
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
# added to visitor tracker in file 3
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

# creating a function that takes in visitor tracker and returns each visitor's 
# spot in line
f.get_spot_in_line <- function(visitor_tracker){
  visitor_tracker$spot_in_line <- NA
  for(i in visitors){
    if(visitor_tracker$ride[i,] == "coolest"){
      # counting visitors in line for the coolest ride
      coolest_visitors <- length(which(visitor_tracker$ride == "coolest"))
      # assigning a spot in line to each of them (each spot repeats to accommodate 
      # for ride capacity)
      visitor_tracker[visitor_tracker$ride == "coolest", ]$spot_in_line <- 
        sort(rep(spots, ride_capacity))[1:coolest_visitors]}
    if(visitor_tracker$ride[i,] == "okayest"){
      # counting visitors in line for the okayest ride
      okayest_visitors <- length(which(visitor_tracker$ride == "okayest"))
      # assigning a spot in line to each of them (each spot repeats to accommodate 
      # for ride capacity)
      visitor_tracker[visitor_tracker$ride == "okayest", ]$spot_in_line <- 
        sort(rep(spots, ride_capacity))[1:okayest_visitors]}
    if(visitor_tracker$ride[i,] == "lamest"){
      # counting visitors in line for the lamest ride
      lamest_visitors <- length(which(visitor_tracker$ride == "lamest"))
      # assigning a spot in line to each of them (each spot repeats to accommodate 
      # for ride capacity)
      visitor_tracker[visitor_tracker$ride == "lamest", ]$spot_in_line <- 
        sort(rep(spots, ride_capacity))[1:lamest_visitors]}
  }
  return(visitor_tracker$spot_in_line)
}

# === 3) status assigner =======================================================
# creating states for visitors, they can either be riding or waiting to ride
# any of the rides
states <- c("r_coolest", "w_coolest", "r_okayest", "w_okayest", "r_lamest", "w_lamest")

# ride_capacity visitors get status riding for each ride, the rest get waiting

# a function that takes in visitor_tracker and returns status of each visitor
f.get_status <- function(visitor_tracker){
  visitor_tracker$status <- NA
  for(i in visitors){
    coolest_visitors <- length(which(visitor_tracker$ride == "coolest"))
    if(visitor_tracker$ride[i,] == "coolest"){
      # for the visitors riding the coolest ride
      visitor_tracker[(visitor_tracker$ride == "coolest") &
                        (visitor_tracker$spot_in_line <= 1), ]$status <- states[1]
      # for the visitors waiting to ride the coolest ride
      if(coolest_visitors > ride_capacity){
        visitor_tracker[(visitor_tracker$ride == "coolest") &
                          (visitor_tracker$spot_in_line >= 2), ]$status <- states[2]}}
    okayest_visitors <- length(which(visitor_tracker$ride == "okayest"))
    if(visitor_tracker$ride[i,] == "okayest"){
      # for the visitors riding the okayest ride
      visitor_tracker[(visitor_tracker$ride == "okayest") &
                        (visitor_tracker$spot_in_line <= 1), ]$status <- states[3]
      # for the visitors waiting to ride the okayest ride
      if(okayest_visitors > ride_capacity){
        visitor_tracker[(visitor_tracker$ride == "okayest") &
                          (visitor_tracker$spot_in_line >= 2), ]$status <- states[4]}}
    lamest_visitors <- length(which(visitor_tracker$ride == "lamest"))
    if(visitor_tracker$ride[i,] == "lamest"){
      # for the visitors riding the lamest ride
      visitor_tracker[(visitor_tracker$ride == "lamest") &
                        (visitor_tracker$spot_in_line <= 1), ]$status <- states[5]
      # for the visitors waiting to ride the lamest ride
      if(lamest_visitors > ride_capacity){
        visitor_tracker[(visitor_tracker$ride == "lamest") &
                          (visitor_tracker$spot_in_line >= 2), ]$status <- states[6]}}
  }
  return(visitor_tracker$status)
}

# === 4) initializer ===========================================================

f.initializing <- function(){
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
  visitor_tracker$spot_in_line <- f.get_spot_in_line(visitor_tracker)
  # adding status column to the data frame
  visitor_tracker$status <- f.get_status(visitor_tracker)
  # return visitor_tracker
  return(visitor_tracker)
}
# === next ride picker ====

# the visitors that went on a ride in the previous time step now go to a new one
# we create a new data frame that includes only the riders 
riding_visitors <- visitor_tracker2[visitor_tracker2[4] == 1,]
# we randomly assign a new ride
next_ride <- sample(x = rides, size = nrow(riding_visitors), 
       replace = TRUE)
# we replace the old ride with the new one in the data frame
riding_visitors$ride <- as.data.frame(next_ride)

# === move up in line function ====
# the visitors that didn't get to go on a ride this time step move up one spot
# in line
# we create a new data frame that includes only the waiters 
waiting_visitors <- visitor_tracker2[visitor_tracker2[4] >1,]

f.move_up <- function(visitor_tracker2){
  waiting_visitors$spot_in_line <- waiting_visitors$spot_in_line - 1
  return(visitor_tracker2)
}

f.move_up(visitor_tracker2)

# === merge new data frames ====
# now we merge waiting and riding visitors
visitor_tracker_merged <- rbind(waiting_visitors, riding_visitors)

# update spot in line
f.get_spot_in_line_looped <- function(visitor_tracker_merged){
  visitor_tracker_merged$spot_in_line <- NA
  for(i in visitors){
    if(visitor_tracker_merged$ride[i,] == "coolest"){
      # counting visitors in line for the coolest ride
      coolest_visitors <- length(which(visitor_tracker_merged$ride == "coolest"))
      # assigning a spot in line to each of them (each spot repeats to accommodate 
      # for ride capacity)
      visitor_tracker_merged[visitor_tracker_merged$ride == "coolest", ]$spot_in_line <- 
        sort(rep(spots, ride_capacity))[1:coolest_visitors]}
    if(visitor_tracker_merged$ride[i,] == "okayest"){
      # counting visitors in line for the okayest ride
      okayest_visitors <- length(which(visitor_tracker_merged$ride == "okayest"))
      # assigning a spot in line to each of them (each spot repeats to accommodate 
      # for ride capacity)
      visitor_tracker_merged[visitor_tracker_merged$ride == "okayest", ]$spot_in_line <- 
        sort(rep(spots, ride_capacity))[1:okayest_visitors]}
    if(visitor_tracker_merged$ride[i,] == "lamest"){
      # counting visitors in line for the lamest ride
      lamest_visitors <- length(which(visitor_tracker_merged$ride == "lamest"))
      # assigning a spot in line to each of them (each spot repeats to accommodate 
      # for ride capacity)
      visitor_tracker_merged[visitor_tracker_merged$ride == "lamest", ]$spot_in_line <- 
        sort(rep(spots, ride_capacity))[1:lamest_visitors]}
  }
  return(visitor_tracker_merged)
}

# update status
f.get_status_looped <- function(visitor_tracker_merged){
  visitor_tracker_merged$status <- NA
  for(i in visitors){
    if(visitor_tracker_merged$ride[i,] == "coolest"){
      # for the visitors riding the coolest ride
      visitor_tracker_merged[(visitor_tracker_merged$ride == "coolest") &
                        (visitor_tracker_merged$spot_in_line <= 1), ]$status <- states[1]
      # for the visitors waiting to ride the coolest ride
      if(coolest_visitors > ride_capacity){
        visitor_tracker_merged[(visitor_tracker_merged$ride == "coolest") &
                          (visitor_tracker_merged$spot_in_line >= 2), ]$status <- states[2]}}
    if(visitor_tracker_merged$ride[i,] == "okayest"){
      # for the visitors riding the okayest ride
      visitor_tracker_merged[(visitor_tracker_merged$ride == "okayest") &
                        (visitor_tracker_merged$spot_in_line <= 1), ]$status <- states[3]
      # for the visitors waiting to ride the okayest ride
      if(okayest_visitors > ride_capacity){
        visitor_tracker_merged[(visitor_tracker_merged$ride == "okayest") &
                          (visitor_tracker_merged$spot_in_line >= 2), ]$status <- states[4]}}
    if(visitor_tracker_merged$ride[i,] == "lamest"){
      # for the visitors riding the lamest ride
      visitor_tracker_merged[(visitor_tracker_merged$ride == "lamest") &
                        (visitor_tracker_merged$spot_in_line <= 1), ]$status <- states[5]
      # for the visitors waiting to ride the lamest ride
      if(lamest_visitors > ride_capacity){
        visitor_tracker_merged[(visitor_tracker_merged$ride == "lamest") &
                          (visitor_tracker_merged$spot_in_line >= 2), ]$status <- states[6]}}
  }
  return(visitor_tracker_merged)
}






