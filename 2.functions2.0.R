
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
# for random ride picking
f.ride_picker <- function(){
  # for random ride picking
  random_ride <- sample(x = rides$ride_name, size = park_capacity, replace = TRUE)
  return(random_ride)
}

# this is always used for initiating no matter the strategy

# # === 2) spot in line ==========================================================
# # this is so that it is possible for ALL visitors to be in line at the same ride
# spots <- visitors
# 
# # creating a function that takes in visitor tracker and returns each visitor's 
# # spot in line
# f.get_spot_in_line <- function(visitor_tracker){
#   visitor_tracker$spot_in_line <- NA
#   for(i in visitors){
#     if(visitor_tracker$ride[i] == rides[1]){
#       # counting visitors in line for the coolest ride
#       coolest_visitors <- length(which(visitor_tracker$ride == rides[1]))
#       # assigning a spot in line to each of them (each spot repeats to accommodate 
#       # for ride capacity)
#       visitor_tracker[visitor_tracker$ride == rides[1], ]$spot_in_line <- 
#         sort(rep(spots, ride_capacity[1]))[1:coolest_visitors]}
#     if(visitor_tracker$ride[i] == rides[2]){
#       # counting visitors in line for the okayest ride
#       okayest_visitors <- length(which(visitor_tracker$ride == rides[2]))
#       # assigning a spot in line to each of them (each spot repeats to accommodate 
#       # for ride capacity)
#       visitor_tracker[visitor_tracker$ride == rides[2], ]$spot_in_line <- 
#         sort(rep(spots, ride_capacity[2]))[1:okayest_visitors]}
#     if(visitor_tracker$ride[i] == rides[3]){
#       # counting visitors in line for the lamest ride
#       lamest_visitors <- length(which(visitor_tracker$ride == rides[3]))
#       # assigning a spot in line to each of them (each spot repeats to accommodate 
#       # for ride capacity)
#       visitor_tracker[visitor_tracker$ride == rides[3], ]$spot_in_line <- 
#         sort(rep(spots, ride_capacity[3]))[1:lamest_visitors]}
#   }
#   return(visitor_tracker$spot_in_line)
# }
# 
# # update spot in line
# f.get_new_spot_in_line <- function(visitor_tracker_merged){
#   visitor_tracker_merged$spot_in_line <- NA
#   for(i in visitors){
#     if(visitor_tracker_merged$ride[i] == rides[1]){
#       # counting visitors in line for the coolest ride
#       coolest_visitors <- length(which(visitor_tracker_merged$ride == rides[1]))
#       # assigning a spot in line to each of them (each spot repeats to accommodate 
#       # for ride capacity)
#       visitor_tracker_merged[visitor_tracker_merged$ride == rides[1], ]$spot_in_line <- 
#         sort(rep(spots, ride_capacity[1]))[1:coolest_visitors]}
#     if(visitor_tracker_merged$ride[i] == rides[2]){
#       # counting visitors in line for the okayest ride
#       okayest_visitors <- length(which(visitor_tracker_merged$ride == rides[2]))
#       # assigning a spot in line to each of them (each spot repeats to accommodate 
#       # for ride capacity)
#       visitor_tracker_merged[visitor_tracker_merged$ride == rides[2], ]$spot_in_line <- 
#         sort(rep(spots, ride_capacity[2]))[1:okayest_visitors]}
#     if(visitor_tracker_merged$ride[i] == rides[3]){
#       # counting visitors in line for the lamest ride
#       lamest_visitors <- length(which(visitor_tracker_merged$ride == rides[3]))
#       # assigning a spot in line to each of them (each spot repeats to accommodate 
#       # for ride capacity)
#       visitor_tracker_merged[visitor_tracker_merged$ride == rides[3], ]$spot_in_line <- 
#         sort(rep(spots, ride_capacity[3]))[1:lamest_visitors]}
#   }
#   return(visitor_tracker_merged)
# }


# === 2) spot in line (LOOPED RIDES) ==========================================================

# creating a function that takes in visitor tracker and returns each visitor's 
# spot in line
f.get_spot_in_line <- function(visitor_tracker){
  visitor_tracker$spot_in_line <- NA
  for(i in visitors){
    for(j in 1:nrow(rides)){
      if(visitor_tracker$ride[i] == rides$ride_name[j]){
        # counting visitors in line for the j ride
        ride_j_visitors <- length(which(visitor_tracker$ride == rides$ride_name[j]))
        # assigning a spot in line to each of them (each spot repeats to 
        # accommodate for ride capacity)
        visitor_tracker[visitor_tracker$ride == rides$ride_name[j], ]$spot_in_line <- 
          sort(rep(visitors, rides$ride_capacity[j]))[1:ride_j_visitors]
        }
      }
    }
  return(visitor_tracker$spot_in_line)
}

# update spot in line
f.get_new_spot_in_line <- function(visitor_tracker_merged){
  visitor_tracker_merged$spot_in_line <- NA
  for(i in visitors){
    for(j in 1:nrow(rides)){
      if(visitor_tracker_merged$ride[i] == rides$ride_name[j]){
        # counting visitors in line for the j ride
        ride_j_visitors <- length(which(visitor_tracker_merged$ride == rides$ride_name[j]))
        # assigning a spot in line to each of them (each spot repeats to accommodate 
        # for ride capacity)
        visitor_tracker_merged[visitor_tracker_merged$ride == rides$ride_name[j], ]$spot_in_line <- 
          sort(rep(visitors, rides$ride_capacity[j]))[1:ride_j_visitors]}
    }
  }
  return(visitor_tracker_merged)
}

# # === 3) status assigner =======================================================
# # ride_capacity visitors get status riding for each ride, the rest get waiting
# 
# # a function that takes in visitor_tracker and returns status of each visitor
# f.get_status <- function(visitor_tracker){
#   visitor_tracker$status <- NA
#   for(i in visitors){
#     coolest_visitors <- length(which(visitor_tracker$ride == rides[1]))
#     if(visitor_tracker$ride[i] == rides[1]){
#       # for the visitors riding the coolest ride
#       visitor_tracker[(visitor_tracker$ride == rides[1]) &
#                         (visitor_tracker$spot_in_line <= 1), ]$status <- states[1]
#       # for the visitors waiting to ride the coolest ride
#       if(coolest_visitors > ride_capacity[1]){
#         visitor_tracker[(visitor_tracker$ride == rides[1]) &
#                           (visitor_tracker$spot_in_line >= 2), ]$status <- states[2]}}
#     okayest_visitors <- length(which(visitor_tracker$ride == rides[2]))
#     if(visitor_tracker$ride[i] == rides[2]){
#       # for the visitors riding the okayest ride
#       visitor_tracker[(visitor_tracker$ride == rides[2]) &
#                         (visitor_tracker$spot_in_line <= 1), ]$status <- states[3]
#       # for the visitors waiting to ride the okayest ride
#       if(okayest_visitors > ride_capacity[2]){
#         visitor_tracker[(visitor_tracker$ride == rides[2]) &
#                           (visitor_tracker$spot_in_line >= 2), ]$status <- states[4]}}
#     lamest_visitors <- length(which(visitor_tracker$ride == rides[3]))
#     if(visitor_tracker$ride[i] == rides[3]){
#       # for the visitors riding the lamest ride
#       visitor_tracker[(visitor_tracker$ride == rides[3]) &
#                         (visitor_tracker$spot_in_line <= 1), ]$status <- states[5]
#       # for the visitors waiting to ride the lamest ride
#       if(lamest_visitors > ride_capacity[3]){
#         visitor_tracker[(visitor_tracker$ride == rides[3]) &
#                           (visitor_tracker$spot_in_line >= 2), ]$status <- states[6]}}
#   }
#   return(visitor_tracker$status)
# }
# 
# # update status WORKING (possibly, fairly sure) (definitely works)
# f.get_new_status <- function(visitor_tracker_merged){
#   visitor_tracker_merged$status <- NA
#   for(i in visitors){
#     coolest_visitors <- length(which(visitor_tracker_merged$ride == rides[1]))
#     if(visitor_tracker_merged$ride[i] == rides[1]){
#       # for the visitors riding the coolest ride
#       visitor_tracker_merged[(visitor_tracker_merged$ride == rides[1]) &
#                                (visitor_tracker_merged$spot_in_line <= 1), ]$status <- 
#         states[1]
#       # for the visitors waiting to ride the coolest ride
#       if(coolest_visitors > ride_capacity[1]){
#         visitor_tracker_merged[(visitor_tracker_merged$ride == rides[1]) &
#                                  (visitor_tracker_merged$spot_in_line >= 2), ]$status <- 
#           states[2]}}
#     okayest_visitors <- length(which(visitor_tracker_merged$ride == rides[2]))
#     if(visitor_tracker_merged$ride[i] == rides[2]){
#       # for the visitors riding the okayest ride
#       visitor_tracker_merged[(visitor_tracker_merged$ride == rides[2]) &
#                                (visitor_tracker_merged$spot_in_line <= 1), ]$status <- 
#         states[3]
#       # for the visitors waiting to ride the okayest ride
#       if(okayest_visitors > ride_capacity[2]){
#         visitor_tracker_merged[(visitor_tracker_merged$ride == rides[2]) &
#                                  (visitor_tracker_merged$spot_in_line >= 2), ]$status <- 
#           states[4]}}
#     lamest_visitors <- length(which(visitor_tracker_merged$ride == rides[3]))
#     if(visitor_tracker_merged$ride[i] == rides[3]){
#       # for the visitors riding the lamest ride
#       visitor_tracker_merged[(visitor_tracker_merged$ride == rides[3]) &
#                                (visitor_tracker_merged$spot_in_line <= 1), ]$status <- 
#         states[5]
#       # for the visitors waiting to ride the lamest ride
#       if(lamest_visitors > ride_capacity[3]){
#         visitor_tracker_merged[(visitor_tracker_merged$ride == rides[3]) &
#                                  (visitor_tracker_merged$spot_in_line >= 2), ]$status <- 
#           states[6]}}
#   }
#   return(visitor_tracker_merged)
# }

# === 3) status assigner (LOOPED RIDES) =======================================================
# ride_capacity visitors get status riding for each ride, the rest get waiting

# a function that takes in visitor_tracker and returns status of each visitor
f.get_status <- function(visitor_tracker){
  visitor_tracker$status <- NA
  for(i in visitors){
    for(j in 1:nrow(rides)){
      # counting j ride visitors
      ride_j_visitors <- length(which(visitor_tracker$ride == rides$ride_name[j]))
      # checking if visitors are riding j ride
      if(visitor_tracker$ride[i] == rides$ride_name[j]){
        # for the visitors riding the coolest ride
        visitor_tracker[(visitor_tracker$ride == rides$ride_name[j]) &
                          (visitor_tracker$spot_in_line == 1), ]$status <- 
          paste("r_", rides$ride_name[j], sep = "")
        # for the visitors waiting to ride the j ride
        if(ride_j_visitors > rides$ride_capacity[j]){
          visitor_tracker[(visitor_tracker$ride == rides$ride_name[j]) &
                            (visitor_tracker$spot_in_line >= 2), ]$status <- 
            paste("w_", rides$ride_name[j], sep = "")
          }}
      }
  }
  return(visitor_tracker$status)
}

# update status WORKING (possibly, fairly sure) (definitely works)
f.get_new_status <- function(visitor_tracker_merged){
  visitor_tracker_merged$status <- NA
  for(i in visitors){
    for(j in 1:nrow(rides)){
      # counting j ride visitors
      ride_j_visitors <- length(which(visitor_tracker_merged$ride == rides$ride_name[j]))
      # checking if visitors are riding j ride
      if(visitor_tracker_merged$ride[i] == rides$ride_name[j]){
        # for the visitors riding the coolest ride
        visitor_tracker_merged[(visitor_tracker_merged$ride == rides$ride_name[j]) &
                          (visitor_tracker_merged$spot_in_line == 1), ]$status <- 
          paste("r_", rides$ride_name[j], sep = "")
        # for the visitors waiting to ride the j ride
        if(ride_j_visitors > rides$ride_capacity[j]){
          visitor_tracker_merged[(visitor_tracker_merged$ride == rides$ride_name[j]) &
                            (visitor_tracker_merged$spot_in_line >= 2), ]$status <- 
            paste("w_", rides$ride_name[j], sep = "")
        }}
      }
  }
  return(visitor_tracker_merged)
}()

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

# === 4) cool points (LOOPED STATES) ===========================================================

# adding a points column
visitor_tracker$points <- 0
# creating a function that will give users points based on the rides they ride
f.get_points <- function(visitor_tracker){
  for(i in visitors){
    for(j in 1:length(states)){
      # looking for visitors riding j ride
      if(visitor_tracker$status[i] == states[j]){
        # adding points for the visitors riding the j ride
        visitor_tracker$points[i] <- visitor_tracker$points[i] + cool_points[j] 
    }
  }
  }
  return(visitor_tracker$points)
}

# updating points after first time step
f.get_new_points <- function(visitor_tracker_merged){
  for(i in visitors){
    for(j in 1:length(states)){
      # looking for visitors riding j ride
      if(visitor_tracker_merged$status[i] == states[j]){
        # adding points for the visitors riding the j ride
        visitor_tracker_merged$points[i] <- visitor_tracker_merged$points[i] + 
          cool_points[j] 
      }
    }
  }
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
# so I  will be using min-max normalization ((value-min)/(max-min)) on the points 
# and then multiplying that by 5

# function that calculates satisfaction of a customer
f.get_satisfaction_score <- function(visitor_tracker){
  # calculating range of points earned by visitors
  first_points_range <- range(visitor_tracker$points)
  first_least_points_visitor <- range(visitor_tracker$points)[1]
  first_most_points_visitor <- range(visitor_tracker$points)[2]
  for(i in visitors){
    visitor_tracker$satisfaction[i] <- round(((visitor_tracker$points[i] - 
                                           first_least_points_visitor)/
                                          (first_most_points_visitor - 
                                             first_least_points_visitor))*5, 
    digits = 1)
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

# === wait time =====
# we want to know how many time steps visitors spend waiting 
# adding a column to visitor tracker
visitor_tracker$waited <- 0
# a function that takes in visitor_tracker and adds one waited time_step to 
# each waiting visitor
f.get_waited <- function(visitor_tracker){
  for(i in visitors){
    if(visitor_tracker$spot_in_line[i] > 1){
      visitor_tracker$waited[i] <- visitor_tracker$waited[i] + 1
    }
  }
  return(visitor_tracker$waited)
}

# add to initializer
#visitor_tracker$waited <- f.get_waited(visitor_tracker)

# updating waited after first time step
f.get_new_waited <- function(visitor_tracker_merged){
  for(i in visitors){
    if(visitor_tracker_merged$spot_in_line[i] > 1){
      visitor_tracker_merged$waited[i] <- visitor_tracker_merged$waited[i] + 1
    }
  }
  return(visitor_tracker_merged$waited)
}

#add to get_next_time_step
#visitor_tracker_merged$waited <- f.get_new_waited(visitor_tracker_merged)


# === ride time =====
# we want to know how many time steps visitors spend riding 
# adding a column to visitor tracker
visitor_tracker$ridden <- 0
# a function that takes in visitor_tracker and adds one waited time_step to 
# each waiting visitor
f.get_ridden <- function(visitor_tracker){
  for(i in visitors){
    if(visitor_tracker$spot_in_line[i] == 1){
      visitor_tracker$ridden[i] <- visitor_tracker$ridden[i] + 1
    }
  }
  return(visitor_tracker$ridden)
}

# add to initializer
#visitor_tracker$ridden <- f.get_ridden(visitor_tracker)

# updating ridden after first time step
f.get_new_ridden <- function(visitor_tracker_merged){
  for(i in visitors){
    if(visitor_tracker_merged$spot_in_line[i] == 1){
      visitor_tracker_merged$ridden[i] <- visitor_tracker_merged$ridden[i] + 1
    }
  }
  return(visitor_tracker_merged$ridden)
}

#add to get_next_time_step
#visitor_tracker_merged$waited <- f.get_new_waited(visitor_tracker_merged)


# === 6) initializing ==========================================================
# function that builds the original data base from scratch (1st time step)
f.initializing <- function(){
  # creating a list of time steps that repeats each times tamp for each guest
  repeated_steps <- rep(time_steps[1], park_capacity)
  # creating data frame with the time steps sorted in ascending order
  visitor_tracker <- as.data.frame(matrix(sort(repeated_steps)))
  colnames(visitor_tracker) <- c("time_step")
  # adding runs column (only used when looking at multiple runs)
  visitor_tracker <- cbind(run = NA, visitor_tracker)
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
  # adding waited column to data frame
  visitor_tracker$waited <- 0
  # adding a waited time column to all waiting visitors
  # this keeps track of the number of time steps each visitor has waited so far
  visitor_tracker$waited <- f.get_waited(visitor_tracker)
  # adding ridden column to data frame
  visitor_tracker$ridden <- 0
  # this keeps track of how the number of rides each visitor has ridden so far
  visitor_tracker$ridden <- f.get_ridden(visitor_tracker)
  
  # return visitor_tracker
  return(visitor_tracker)
}

# === 7) move up in line function ==============================================
# the visitors that didn't get to go on a ride this time step move up one spot
# in line
# we create a new data frame that includes only the waiters 
waiting_visitors <- visitor_tracker_i[visitor_tracker_i$spot_in_line >1,]

# move up in line
f.move_up <- function(visitor_tracker_i){
  waiting_visitors$spot_in_line <- waiting_visitors$spot_in_line - 1
  return(waiting_visitors)
}



# === next ride shortest line function
f.get_next_ride_shortest_wait <- function(visitor_tracker_i){
# testing
# f.get_next_ride_shortest_wait <- function(){
  riding_visitors <- visitor_tracker_i[visitor_tracker_i$spot_in_line == 1,]
  # first we create a waits vector
  waits <- vector()
  # then we fill it in. To do that...
  # first we look at the wait time at j ride (by looking at the greatest spot in line)
  for (i in 1:length(states)) {
    # if any of the visitors waiting in line
    if(any(visitor_tracker_i$status == states[i] & (i %% 2) == 0)){
      # then coolest wait is the greatest spot in line
      wait_j_ride <- max(visitor_tracker_i[visitor_tracker_i$status == states[i],
                                           ]$spot_in_line)
      }else{
        # else wait coolest is 1 making the prob of choosing coolest 1
        wait_j_ride <- 1
      }
    # wait_ride_loop <- paste(1, "/" , wait_j_ride, sep = "")
    
    wait_ride_loop <- wait_j_ride
    waits <- c(waits, wait_ride_loop)
  }

  final_waits <- vector()
  
  for (i in 1:length(waits)){
    inter_waits <- 1/waits[i]
    final_waits <- c(final_waits, inter_waits)
  }
  
  # first we create an empty vector 
  probs <- vector()
  
  for (i in 1:length(final_waits)){
    if ((i %% 2) == 0) {
      this_wait <- final_waits[i]
      probs <- c(probs, this_wait)
    }
  }
  
  # with this info we can move on to
  # step 2
  # we assign them a new ride based on the shortest wait strategy
  next_ride <- sample(x = rides$ride_name, size = nrow(riding_visitors),
                      replace = TRUE, prob = probs)
  
  return(next_ride)
}  

# === 8a) get next time step RANDOM =============================================
f.get_next_time_step_random <- function(){
  # step 1
  # the visitors that went on a ride in the previous time step now go to a new one
  # we create a new data frame that includes only the riders 
  riding_visitors <- visitor_tracker_i[visitor_tracker_i$spot_in_line == 1,]
  # step 2
  # we randomly assign them a new ride
  next_ride <- sample(x = rides$ride_name, size = nrow(riding_visitors),
  replace = TRUE)
  # assigning ride now
  riding_visitors$ride <- next_ride
  # we replace the old ride with the new one in the data frame
  # step 3
  # the visitors that didn't get to go on a ride this time step move up one spot
  # in line
  # we create a new data frame that includes only the waiters 
  waiting_visitors <- visitor_tracker_i[visitor_tracker_i$spot_in_line > 1,]
  # step 4
  waiting_visitors <- f.move_up(visitor_tracker_i)
  # step 5
  # now we merge waiting and riding visitors
  visitor_tracker_merged <- rbind(waiting_visitors, riding_visitors)
  # step 6 
  # we update spot in line
  visitor_tracker_merged <- f.get_new_spot_in_line(visitor_tracker_merged)
  # step 7 
  # then we update status
  visitor_tracker_merged <- f.get_new_status(visitor_tracker_merged)
  # returns visitor tracker merged
  # step 8
  # then we get points
  visitor_tracker_merged <- f.get_new_points(visitor_tracker_merged)
  # step 9
  # we get satisfaction score
  visitor_tracker_merged$satisfaction <-
    f.get_new_satisfaction_score(visitor_tracker_merged)
  
  # we add one waited time step to waiting visitors
  visitor_tracker_merged$waited <- f.get_new_waited(visitor_tracker_merged)
  
  # and one ridden time step to riding visitors
  visitor_tracker_merged$ridden <- f.get_new_ridden(visitor_tracker_merged)
  
  return(visitor_tracker_merged)
}

# === 8b) get next time step COOLER BETTER ======================================
f.get_next_time_step_cooler_better <- function(){
  # step 1
  # the visitors that went on a ride in the previous time step now go to a new one
  # we create a new data frame that includes only the riders 
  riding_visitors <- visitor_tracker_i[visitor_tracker_i$spot_in_line == 1,]
  # step 2
  # we assign them a new ride based on the cooler is better strategy
  next_ride <- sample(x = rides$ride_name$ride_name, size = nrow(riding_visitors),
                      replace = TRUE, prob = rides$ride_prob)
  
  # assigning ride now
  riding_visitors$ride <- next_ride
  # we replace the old ride with the new one in the data frame
  # step 3
  # the visitors that didn't get to go on a ride this time step move up one spot
  # in line
  # we create a new data frame that includes only the waiters 
  waiting_visitors <- visitor_tracker_i[visitor_tracker_i$spot_in_line >1,]
  # step 4
  waiting_visitors <- f.move_up(visitor_tracker_i)
  # step 5
  # now we merge waiting and riding visitors
  visitor_tracker_merged <- rbind(waiting_visitors, riding_visitors)
  # step 6 
  # we update spot in line
  visitor_tracker_merged <- f.get_new_spot_in_line(visitor_tracker_merged)
  # step 7 
  # then we update status
  visitor_tracker_merged <- f.get_new_status(visitor_tracker_merged)
  # returns visitor tracker merged
  # step 8
  # then we get points
  visitor_tracker_merged <- f.get_new_points(visitor_tracker_merged)
  # step 9
  # we get satisfaction score
  visitor_tracker_merged$satisfaction <-
    f.get_new_satisfaction_score(visitor_tracker_merged)
  #step 10
  # we add one waited time step to waiting visitors
  visitor_tracker_merged$waited <- f.get_new_waited(visitor_tracker_merged)
  # and one ridden time step to riding visitors
  visitor_tracker_merged$ridden <- f.get_new_ridden(visitor_tracker_merged)
  
  return(visitor_tracker_merged)
}

# === 8c) get next time step SHORTEST WAIT ======================================
f.get_next_time_step_shortest_wait <- function(){
  # step 1
  # the visitors that went on a ride in the previous time step now go to a new one
  # we create a new data frame that includes only the riders 
  riding_visitors <- visitor_tracker_i[visitor_tracker_i$spot_in_line == 1,]
  # and assign them a new ride
  riding_visitors$ride <- f.get_next_ride_shortest_wait(visitor_tracker_i)
  # we replace the old ride with the new one in the data frame
  # step 3
  # the visitors that didn't get to go on a ride this time step move up one spot
  # in line
  # we create a new data frame that includes only the waiters 
  waiting_visitors <- visitor_tracker_i[visitor_tracker_i$spot_in_line >1,]
  # step 4
  waiting_visitors <- f.move_up(visitor_tracker_i)
  # step 5
  # now we merge waiting and riding visitors
  visitor_tracker_merged <- rbind(waiting_visitors, riding_visitors)
  # step 6 
  # we update spot in line
  visitor_tracker_merged <- f.get_new_spot_in_line(visitor_tracker_merged)
  # step 7 
  # then we update status
  visitor_tracker_merged <- f.get_new_status(visitor_tracker_merged)
  # returns visitor tracker merged
  # step 8
  # then we get points
  visitor_tracker_merged <- f.get_new_points(visitor_tracker_merged)
  # step 9
  # we get satisfaction score
  visitor_tracker_merged$satisfaction <-
    f.get_new_satisfaction_score(visitor_tracker_merged)
  
  # we add one waited time step to waiting visitors
  visitor_tracker_merged$waited <- f.get_new_waited(visitor_tracker_merged)
  
  # and one ridden time step to riding visitors
  visitor_tracker_merged$ridden <- f.get_new_ridden(visitor_tracker_merged)
  
  return(visitor_tracker_merged)
}


#___ end of 2.functions_________________________________________________________
# Note that when file 2.functions is fully ran a number of errors indicating that
# objects 'visitor_tracker' and 'visitor_tracker_i" are not found will pop up.
# These objects will be defined and generated in the next file and so it is not 
# a problem.

