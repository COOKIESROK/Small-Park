
# === description ==============================================================
# This file contains all the functions needed to run file 3.tracking.data.R
# 1) f.ride_picker randomly assigns a ride to each visitor.
# 2) f.get_spot_in_line and f.get_new_spot_in_line assign a spot in line to each 
# visitor.
# 3) f.get_status and f.get_new_status assign one of 6 states to each visitor.
# 4) f.get_points and f.get_new_points assign a number of points to the visitors 
# that went on a ride in the time step. The number of points depends on which 
# ride they went on (points are cumulative). 
# 5) f.get_satisfaction_score calculates the satisfaction of each visitor beased
# on the amount of points they have. 
# 6) f.initializing sets up the main data frame (visitor_tracker for time step 1).
# 7) f.move_up moves waiting visitors one spot up in line.
# 8) f.get_next_time_step updates the main data frame to the next time step in 9 
# steps: 
# 1. create riding_visitors data frame.
# 2. assign riding_visitors a new ride.
# 3. create waiting visitors data frame.
# 4. move waiting visitors one step up in line.
# 5. merge both data frames.
# 6. update everyone's spot in line.
# 7. update everyone's status.
# 8. update everyone's points. 
# 9. update everyone's satisfaction. 

# === 1) ride picker ===========================================================
# visitor_col <- as.data.frame(matrix(visitors))
# colnames(visitor_col) <- "visitors"
# for random ride picking
f.ride_picker <- function(){
  # for random ride picking
  random_ride <- sample(x = rides, size = park_capacity, replace = TRUE)
  return(random_ride)
}

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
states <- c("r_coolest", "w_coolest", "r_okayest", "w_okayest", "r_lamest", 
            "w_lamest")

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

# # === 4) cool points ===========================================================
# # adding a points column
# visitor_tracker$points <- 0
# # creating a function that will give users points based on the rides they ride
# f.get_points <- function(visitor_tracker){
#   for(i in visitors){
#     # looking for visitors riding coolest ride
#     if(visitor_tracker$status[i] == "r_coolest"){
#       # adding points for the visitors riding the coolest ride
#       visitor_tracker$points[i] <- visitor_tracker$points[i] + cool_points[1] 
#     }
#     # looking for visitors riding okayest ride
#     if(visitor_tracker$status[i] == "r_okayest"){
#       # adding points for the visitors riding the okayest ride
#       visitor_tracker$points[i] <- visitor_tracker$points[i] + cool_points[2]
#     }
#     # looking for visitors riding lamest ride
#     if(visitor_tracker$status[i] == "r_lamest"){
#       # adding points for the visitors riding the lamest ride
#       visitor_tracker$points[i] <- visitor_tracker$points[i] + cool_points[3]
#     }
#   }
#   return(visitor_tracker$points)
# }
# 
# # updating points after first time step
# f.get_new_points <- function(visitor_tracker_merged){
#   for(i in visitors){
#     # looking for visitors riding coolest ride
#     if(visitor_tracker_merged$status[i] == "r_coolest"){
#       # adding points for the visitors riding the coolest ride
#       visitor_tracker_merged$points[i] <- visitor_tracker_merged$points[i] + cool_points[1] 
#     }
#     # looking for visitors riding okayest ride
#     if(visitor_tracker_merged$status[i] == "r_okayest"){
#       # adding points for the visitors riding the okayest ride
#       visitor_tracker_merged$points[i] <- visitor_tracker_merged$points[i] + cool_points[2]
#     }
#     # looking for visitors riding lamest ride
#     if(visitor_tracker_merged$status[i] == "r_lamest"){
#       # adding points for the visitors riding the lamest ride
#       visitor_tracker_merged$points[i] <- visitor_tracker_merged$points[i] + cool_points[3]
#     }
#   }
#   #return(visitor_tracker_merged$points)
#   
#   # what if it simply returned the tracker 
#   return(visitor_tracker_merged)
# }

# === 4) messing with cool points function =====================================
# adding a points column
visitor_tracker$points <- 0
# creating a function that will give users points based on the rides they ride
f.get_points <- function(visitor_tracker){
  for(i in visitors){
    # looking for visitors riding coolest ride
    if(visitor_tracker$status[i] == "r_coolest"){
      # adding points for the visitors riding the coolest ride
      visitor_tracker$points[i] <- visitor_tracker$points[i] + cool_points[1] 
    }
    # looking for visitors riding okayest ride
    if(visitor_tracker$status[i] == "r_okayest"){
      # adding points for the visitors riding the okayest ride
      visitor_tracker$points[i] <- visitor_tracker$points[i] + cool_points[2]
    }
    # looking for visitors riding lamest ride
    if(visitor_tracker$status[i] == "r_lamest"){
      # adding points for the visitors riding the lamest ride
      visitor_tracker$points[i] <- visitor_tracker$points[i] + cool_points[3]
    }
  }
  return(visitor_tracker$points)
}

# updating points after first time step
f.get_new_points <- function(visitor_tracker_merged){
  for(i in visitors){
    # looking for visitors riding coolest ride
    if(visitor_tracker_merged$status[i] == "r_coolest"){
      # adding points for the visitors riding the coolest ride
      visitor_tracker_merged$points[i] <- visitor_tracker_merged$points[i] + cool_points[1] 
    }
    # looking for visitors riding okayest ride
    if(visitor_tracker_merged$status[i] == "r_okayest"){
      # adding points for the visitors riding the okayest ride
      visitor_tracker_merged$points[i] <- visitor_tracker_merged$points[i] + cool_points[2]
    }
    # looking for visitors riding lamest ride
    if(visitor_tracker_merged$status[i] == "r_lamest"){
      # adding points for the visitors riding the lamest ride
      visitor_tracker_merged$points[i] <- visitor_tracker_merged$points[i] + cool_points[3]
    }
  }
  #return(visitor_tracker_merged$points)
  
  # what if it simply returned the tracker 
  return(visitor_tracker_merged)
}

# === 5) satisfaction calculator ===============================================
# calculating satisfaction score out of 5 based on cool points earned by each 
# visitor
# adding a satisfaction column to visitor tracker
visitor_tracker$satisfaction <- 0
# for satisfaction levels to be more realistic I will be using a relative max
# satisfaction level instead of the true max satisfaction (because no mortal will
# ever achieve that)
# so I  will be using min-max normalization ((value-min)/(max-min)) on the points and then multiplying 
# that by 5

# function that calculates satisfaction of a customer
f.get_satisfaction_score <- function(visitor_tracker){
  # calculating range of points earned by visitors
  first_points_range <- range(visitor_tracker$points)
  first_least_points_visitor <- range(visitor_tracker$points)[1]
  first_most_points_visitor <- range(visitor_tracker$points)[2]
  for(i in visitors){
    visitor_tracker$satisfaction[i] <- ((visitor_tracker$points[i] - 
                                           first_least_points_visitor)/
                                          (first_most_points_visitor - 
                                             first_least_points_visitor))*5
  }
  return(visitor_tracker$satisfaction)
}

# function that updates satisfaction again once we have a complete visitor_tracker
# after each time step
f.get_new_satisfaction_score <- 
  function(visitor_tracker_merged){
    # calculating range of points earned by visitors
    points_range <- range(visitor_tracker_merged$points)
    least_points_visitor <- range(visitor_tracker_merged$points)[1]
    most_points_visitor <- range(visitor_tracker_merged$points)[2]
    for(i in visitors){
      visitor_tracker_merged$satisfaction[i] <-
        ((visitor_tracker_merged$points[i] - least_points_visitor)/
           (most_points_visitor - least_points_visitor))*5
    }
    return(round(visitor_tracker_merged$satisfaction, digits = 1))
  }

# === 6) initializing ==========================================================
# functin that builds the original data base from scratch (1st time step)
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
  #assigning a ride to each visitor
  visitor_tracker$ride <- f.ride_picker()
  # adding spot in line column to the data frame
  visitor_tracker$spot_in_line <- f.get_spot_in_line(visitor_tracker)
  # adding status column to the data frame
  visitor_tracker$status <- f.get_status(visitor_tracker)
  # adding points column to the data frame
  visitor_tracker$points <- 0
  # calculating points based on status
  visitor_tracker$points <- f.get_points(visitor_tracker)
  #adding satisfaction column to data frame
  visitor_tracker$satisfaction <- 0
  # calculating satisfaction based on points
  visitor_tracker$satisfaction <- f.get_satisfaction_score(visitor_tracker)
  # return visitor_tracker
  return(visitor_tracker)
}

# === 7) move up in line function ==============================================
# the visitors that didn't get to go on a ride this time step move up one spot
# in line
# we create a new data frame that includes only the waiters 
waiting_visitors <- new_visitor_tracker[new_visitor_tracker[4] >1,]

# move up in line
f.move_up <- function(new_visitor_tracker){
  waiting_visitors$spot_in_line <- waiting_visitors$spot_in_line - 1
  return(waiting_visitors)
}



# === 8) get next time step ====================================================
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
  # testing changing visitor_tracker merged to visitor_tracker
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
  #visitor_tracker_merged$points <- f.get_new_points(visitor_tracker_merged)
  
  # testting for returning tracker rather than column
  visitor_tracker_merged <- f.get_new_points(visitor_tracker_merged)
  
  # step 9
  # get satisfaction score
  visitor_tracker_merged$satisfaction <-
    f.get_new_satisfaction_score(visitor_tracker_merged)
  return(visitor_tracker_merged)
}

