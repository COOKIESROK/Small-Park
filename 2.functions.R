
# === description ==============================================================
# This file contains all the functions needed to run file 3.
# 1) f.ride_picker randomly assigns a ride to each visitor.
# 2) f.get_spot_in_line and f.get_new_spot_in_line assign a spot in line to each 
# visitor.
# 3) f.get_status and f.get_new_status assign one of 6 states to each visitor.
# 4) f.initializing sets up the main data frame (visitor_tracker for time step 1).
# 5) f.move_up moves waiting visitors one spot up in line.
# 6) f.get_next_time_step updates the main data frame to the next time step in 7 
# steps: 
  # 1. create riding_visitors data frame.
  # 2. assign riding_visitors a new ride.
  # 3. create waiting visitors data frame.
  # 4. move waiting visitors one step up in line.
  # 5. merge both data frames.
  # 6. update everyones spot in line.
  # 7. update everyones status.

# === 1) ride picker =========================================================
# visitor_col <- as.data.frame(matrix(visitors))
# colnames(visitor_col) <- "visitors"
# for random ride picking
f.ride_picker <- function(){
  # for random ride picking
  random_ride <- sample(x = rides, size = park_capacity, replace = TRUE)
  return(random_ride)
}

str(random_ride)

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
    if(visitor_tracker$ride[i] == "coolest"){
      # counting visitors in line for the coolest ride
      coolest_visitors <- length(which(visitor_tracker$ride == "coolest"))
      # assigning a spot in line to each of them (each spot repeats to accommodate 
      # for ride capacity)
      visitor_tracker[visitor_tracker$ride == "coolest", ]$spot_in_line <- 
        sort(rep(spots, ride_capacity))[1:coolest_visitors]}
    if(visitor_tracker$ride[i] == "okayest"){
      # counting visitors in line for the okayest ride
      okayest_visitors <- length(which(visitor_tracker$ride == "okayest"))
      # assigning a spot in line to each of them (each spot repeats to accommodate 
      # for ride capacity)
      visitor_tracker[visitor_tracker$ride == "okayest", ]$spot_in_line <- 
        sort(rep(spots, ride_capacity))[1:okayest_visitors]}
    if(visitor_tracker$ride[i] == "lamest"){
      # counting visitors in line for the lamest ride
      lamest_visitors <- length(which(visitor_tracker$ride == "lamest"))
      # assigning a spot in line to each of them (each spot repeats to accommodate 
      # for ride capacity)
      visitor_tracker[visitor_tracker$ride == "lamest", ]$spot_in_line <- 
        sort(rep(spots, ride_capacity))[1:lamest_visitors]}
  }
  return(visitor_tracker$spot_in_line)
}

# update spot in line
f.get_new_spot_in_line <- function(visitor_tracker_merged){
  visitor_tracker_merged$spot_in_line <- NA
  for(i in visitors){
    if(visitor_tracker_merged$ride[i] == "coolest"){
      # counting visitors in line for the coolest ride
      coolest_visitors <- length(which(visitor_tracker_merged$ride == "coolest"))
      # assigning a spot in line to each of them (each spot repeats to accommodate 
      # for ride capacity)
      visitor_tracker_merged[visitor_tracker_merged$ride == "coolest", ]$spot_in_line <- 
        sort(rep(spots, ride_capacity))[1:coolest_visitors]}
    if(visitor_tracker_merged$ride[i] == "okayest"){
      # counting visitors in line for the okayest ride
      okayest_visitors <- length(which(visitor_tracker_merged$ride == "okayest"))
      # assigning a spot in line to each of them (each spot repeats to accommodate 
      # for ride capacity)
      visitor_tracker_merged[visitor_tracker_merged$ride == "okayest", ]$spot_in_line <- 
        sort(rep(spots, ride_capacity))[1:okayest_visitors]}
    if(visitor_tracker_merged$ride[i] == "lamest"){
      # counting visitors in line for the lamest ride
      lamest_visitors <- length(which(visitor_tracker_merged$ride == "lamest"))
      # assigning a spot in line to each of them (each spot repeats to accommodate 
      # for ride capacity)
      visitor_tracker_merged[visitor_tracker_merged$ride == "lamest", ]$spot_in_line <- 
        sort(rep(spots, ride_capacity))[1:lamest_visitors]}
  }
  return(visitor_tracker_merged)
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
    if(visitor_tracker$ride[i] == "coolest"){
      # for the visitors riding the coolest ride
      visitor_tracker[(visitor_tracker$ride == "coolest") &
                        (visitor_tracker$spot_in_line <= 1), ]$status <- states[1]
      # for the visitors waiting to ride the coolest ride
      if(coolest_visitors > ride_capacity){
        visitor_tracker[(visitor_tracker$ride == "coolest") &
                          (visitor_tracker$spot_in_line >= 2), ]$status <- states[2]}}
    okayest_visitors <- length(which(visitor_tracker$ride == "okayest"))
    if(visitor_tracker$ride[i] == "okayest"){
      # for the visitors riding the okayest ride
      visitor_tracker[(visitor_tracker$ride == "okayest") &
                        (visitor_tracker$spot_in_line <= 1), ]$status <- states[3]
      # for the visitors waiting to ride the okayest ride
      if(okayest_visitors > ride_capacity){
        visitor_tracker[(visitor_tracker$ride == "okayest") &
                          (visitor_tracker$spot_in_line >= 2), ]$status <- states[4]}}
    lamest_visitors <- length(which(visitor_tracker$ride == "lamest"))
    if(visitor_tracker$ride[i] == "lamest"){
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

# update status WORKING (possibly, fairly sure) (definitely works)
f.get_new_status <- function(visitor_tracker_merged){
  visitor_tracker_merged$status <- NA
  for(i in visitors){
    coolest_visitors <- length(which(visitor_tracker_merged$ride == "coolest"))
    if(visitor_tracker_merged$ride[i] == "coolest"){
      # for the visitors riding the coolest ride
      visitor_tracker_merged[(visitor_tracker_merged$ride == "coolest") &
                               (visitor_tracker_merged$spot_in_line <= 1), ]$status <- 
        states[1]
      # for the visitors waiting to ride the coolest ride
      if(coolest_visitors > ride_capacity){
        visitor_tracker_merged[(visitor_tracker_merged$ride == "coolest") &
                                 (visitor_tracker_merged$spot_in_line >= 2), ]$status <- 
          states[2]}}
    okayest_visitors <- length(which(visitor_tracker_merged$ride == "okayest"))
    if(visitor_tracker_merged$ride[i] == "okayest"){
      # for the visitors riding the okayest ride
      visitor_tracker_merged[(visitor_tracker_merged$ride == "okayest") &
                               (visitor_tracker_merged$spot_in_line <= 1), ]$status <- 
        states[3]
      # for the visitors waiting to ride the okayest ride
      if(okayest_visitors > ride_capacity){
        visitor_tracker_merged[(visitor_tracker_merged$ride == "okayest") &
                                 (visitor_tracker_merged$spot_in_line >= 2), ]$status <- 
          states[4]}}
    lamest_visitors <- length(which(visitor_tracker_merged$ride == "lamest"))
    if(visitor_tracker_merged$ride[i] == "lamest"){
      # for the visitors riding the lamest ride
      visitor_tracker_merged[(visitor_tracker_merged$ride == "lamest") &
                               (visitor_tracker_merged$spot_in_line <= 1), ]$status <- 
        states[5]
      # for the visitors waiting to ride the lamest ride
      if(lamest_visitors > ride_capacity){
        visitor_tracker_merged[(visitor_tracker_merged$ride == "lamest") &
                                 (visitor_tracker_merged$spot_in_line >= 2), ]$status <- 
          states[6]}}
  }
  return(visitor_tracker_merged)
}

# === 4) cool points =====
# adding a points column
visitor_tracker$points <- 0
# creating a function that will give users points based on the rides they ride
f.get_points <- function(visitor_tracker){
  for(i in visitors){
    # looking for visitors riding coolest ride
    if(visitor_tracker$status[i] == "r_coolest"){
      # for the visitors riding the coolest ride
      visitor_tracker[(visitor_tracker$status == "r_coolest"), ]$points <-
        # add points for coolest
        visitor_tracker[(visitor_tracker$status == "r_coolest"), ]$points + cool_points[1]}

    if(visitor_tracker$status[i] == "r_okayest"){
      # for the visitors riding the okayest ride
      visitor_tracker[(visitor_tracker$status == "r_okayest"), ]$points <-
        # add points for okayest
        visitor_tracker[(visitor_tracker$status == "r_okayest"), ]$points + cool_points[2]}

    if(visitor_tracker$status[i] == "r_lamest"){
      # for the visitors riding the lamest ride
      visitor_tracker[(visitor_tracker$status == "r_lamest"), ]$points <-
        # add points for lamest
        visitor_tracker[(visitor_tracker$status == "r_lamest"), ]$points + cool_points[3]
    }
  }
  return(visitor_tracker$points)
}

# calling function to test
visitor_tracker$points <- f.get_points(visitor_tracker)

# 
# # cool points calculator
# sum(complete_visitor_tracker[complete_visitor_tracker$visitors == 1,]$points)
# 
# total_points <- for (i in park_capacity){
#   as.integer(sum(complete_visitor_tracker[complete_visitor_tracker$visitors == 1,]$points))
#   }
# 
# str(total_points)

# === 4) initializer ===========================================================
f.initializing <- function(){
  # creating a list of time steps that repeats each times tamp for each guest
  repeated_steps <- rep(time_steps[1], park_capacity)
  # creating data frame with the time steps sorted in ascending order
  visitor_tracker <- as.data.frame(matrix(sort(repeated_steps)))
  colnames(visitor_tracker) <- c("time_step")
  # adding visitor column to data frame
  visitor_tracker$visitors <- rep(visitors)
  # adding ride column to data frame
  visitor_tracker$ride <- NA
  visitor_tracker$ride <- f.ride_picker()
  # adding spot in line column to the data frame
  visitor_tracker$spot_in_line <- f.get_spot_in_line(visitor_tracker)
  # adding status column to the data frame
  visitor_tracker$status <- f.get_status(visitor_tracker)
  # visitor_tracker$points <- 0
  # visitor_tracker$points <- f.get_points()
  # return visitor_tracker
  return(visitor_tracker)
}


# === 5) move up in line function ==============================================
# the visitors that didn't get to go on a ride this time step move up one spot
# in line
# we create a new data frame that includes only the waiters 
waiting_visitors <- new_visitor_tracker[new_visitor_tracker[4] >1,]

# move up in line
f.move_up <- function(new_visitor_tracker){
  waiting_visitors$spot_in_line <- waiting_visitors$spot_in_line - 1
  return(waiting_visitors)
}



# === 6) get next time step ====================================================
f.get_next_time_step <- function(){
  # step 1
  # the visitors that went on a ride in the previous time step now go to a new one
  # we create a new data frame that includes only the riders 
  riding_visitors <- new_visitor_tracker[new_visitor_tracker[4] == 1,]
  # step 2
  # we randomly assign them a new ride
  next_ride <- sample(x = rides, size = nrow(riding_visitors), 
                        replace = TRUE)
  # we replace the old ride with the new one in the data frame
  riding_visitors$ride <- next_ride
  # step 3
  # the visitors that didn't get to go on a ride this time step move up one spot
  # in line
  # we create a new data frame that includes only the waiters 
  waiting_visitors <- new_visitor_tracker[new_visitor_tracker[4] >1,]
  # step 4
  waiting_visitors <- f.move_up(new_visitor_tracker)
  # step 5
  # now we merge waiting and riding visitors
  visitor_tracker_merged <- rbind(waiting_visitors, riding_visitors)
  # step 6 
  # update spot in line
  visitor_tracker_merged <- f.get_new_spot_in_line(visitor_tracker_merged)
  # step 7 
  # update status
  visitor_tracker_merged <- f.get_new_status(visitor_tracker_merged)
  # returns visitor tracker merged
  # step 8
  # get points
  # visitor_tracker$points <- f.get_points()
  return(visitor_tracker_merged)
}



