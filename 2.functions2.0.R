
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

# === 2) spot in line ==========================================================

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
  for(i in 1:nrow(visitor_tracker_merged)){
    for(j in 1:nrow(rides)){
      if(visitor_tracker_merged$ride[i] == rides$ride_name[j]){
        # counting visitors in line for the j ride
        ride_j_visitors <- length(which(visitor_tracker_merged$ride == rides$ride_name[j]))
        # assigning a spot in line to each of them (each spot repeats to accommodate 
        # for ride capacity)
        visitor_tracker_merged[visitor_tracker_merged$ride == rides$ride_name[j],
        ]$spot_in_line <- 
          sort(rep(visitors, rides$ride_capacity[j]))[1:ride_j_visitors]}
    }
  }
  return(visitor_tracker_merged)
}

# === 3) status assigner =======================================================
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
  for(i in 1:nrow(visitor_tracker_merged)){
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

# === 4) time in ride ==========================================================
# to see how long riding visitors have been riding for

# a function that takes in visitor_tracker and adds 1 to time in ride
f.get_time_in_ride <- function(visitor_tracker){
  visitor_tracker$time_in_ride <- 0
  for(i in visitors){
    if(visitor_tracker$spot_in_line[i] == 1){
      visitor_tracker$time_in_ride[i] <- visitor_tracker$time_in_ride[i] + 1
    }
  }
  return(visitor_tracker$time_in_ride)
  }

# update time in ride
f.get_new_time_in_ride <- function(visitor_tracker_merged){
  for(i in visitors){
    if((visitor_tracker_merged$spot_in_line[i] == 1) & 
       (visitor_tracker_merged$progress[i] != "last stage")){
      visitor_tracker_merged$time_in_ride[i] <- visitor_tracker_merged$time_in_ride[i] + 1
    } else {
      visitor_tracker_merged$time_in_ride[i] <- 0
    }
  }
  return(visitor_tracker_merged$time_in_ride)
}

# === 5) progress ==============================================================
# a function that takes in visitor_tracker and returns the stage of the ride that
# each visitor is in (which could be waiting, in progress or last time step)

f.get_progress <- function(visitor_tracker){
  visitor_tracker$progress <- NA
  for(i in visitors){
    for(j in 1:nrow(rides)){
      # checking if visitor i is at ride j
      if(visitor_tracker$ride[i] == rides$ride_name[j]){
        # checking if visitor i is riding ride j
        if(visitor_tracker$time_in_ride[i] > 0){
          # checking if visitor i is in the final stage of ride j
          if(visitor_tracker$time_in_ride[i] == rides$ride_duration[j]){
            visitor_tracker$progress[i] <- "final stage"
          } else {
            visitor_tracker$progress[i] <- "in progress"
          }
        } else {
          visitor_tracker$progress[i] <- "waiting"
        }
      }
    }
  }
  return(visitor_tracker$progress)
}

# update progress MIGHT WORK MIGHT NOT
f.get_new_progress <- function(visitor_tracker_merged){
  visitor_tracker_merged$progress <- NA
  for(i in visitors){
    for(j in 1:nrow(rides)){
      # checking if visitor i is at ride j
      if(visitor_tracker_merged$ride[i] == rides$ride_name[j]){
        # checking if visitor i is riding ride j
        if(visitor_tracker_merged$time_in_ride[i] > 0){
          # checking if visitor i is in the final stage of ride j
          if(visitor_tracker_merged$time_in_ride[i] == rides$ride_duration[j]){
            visitor_tracker_merged$progress[i] <- "final stage"
          } else {
            visitor_tracker_merged$progress[i] <- "in progress"
          }
        } else {
          visitor_tracker_merged$progress[i] <- "waiting"
        }
      }
    }
  }
  return(visitor_tracker_merged$progress)
}


# === 6) fun points ===========================================================

# adding a points column
visitor_tracker$points <- 0
# creating a function that will give users points based on the rides they ride
f.get_points <- function(visitor_tracker){
  for(i in visitors){
    if(visitor_tracker$progress[i] == "final stage"){
      for(j in 1:length(states)){
        # looking for visitors riding j ride
        if(visitor_tracker$status[i] == states[j]){
          # adding points for the visitors riding the j ride
          visitor_tracker$points[i] <- visitor_tracker$points[i] + fun_points[j] 
        }
      }
    }
  }
  return(visitor_tracker$points)
}

# updating points after first time step
f.get_new_points <- function(visitor_tracker_merged){
  for(i in visitors){
    if(visitor_tracker_merged$progress[i] == "final stage"){
      for(j in 1:length(states)){
        # looking for visitors riding j ride
        if(visitor_tracker_merged$status[i] == states[j]){
          # adding points for the visitors riding the j ride
          visitor_tracker_merged$points[i] <- visitor_tracker_merged$points[i] + 
            fun_points[j] 
        }
      }
    } else {
      visitor_tracker_merged$points[i] <- visitor_tracker_merged$points[i] + 0
    }
  }
  return(visitor_tracker_merged$points)
}

# === 7) satisfaction calculator ===============================================
# calculating satisfaction score out of 5 based on fun points earned by each 
# visitor
# adding a satisfaction column to visitor tracker
visitor_tracker$satisfaction <- 0
# for satisfaction levels to be more realistic I will be using a relative max
# satisfaction level instead of the true max satisfaction (because no mortal will
# ever achieve that)
# so I  will be using min-max normalization ((value-min)/(max-min)) on the points 
# and then multiplying that by 5

# function that calculates satisfaction of a visitor
f.get_satisfaction_score <- function(visitor_tracker){
  # fun points side of satisfaction
  # calculating range of points earned by visitors
  first_points_range <- range(visitor_tracker$points)
  first_least_points_visitor <- range(visitor_tracker$points)[1]
  first_most_points_visitor <- range(visitor_tracker$points)[2]
  
  # creating an empty vector to store fun points part
  fun_points_based <- vector()
  # filling in the vector
  for(i in visitors){
    fun_points_satisfaction <- round(((visitor_tracker$points[i] - 
                                           first_least_points_visitor)/
                                          (first_most_points_visitor - 
                                             first_least_points_visitor))*5, 
                                          digits = 1)
    fun_points_based <- c(fun_points_based, fun_points_satisfaction)
  }
  
  # ratio side of satisfaction
  # creating an empty vector to store ratio part
  ratio_based <- vector()
  # filling in the vector
  for(i in visitors){
    ratio_satisfaction <- round((visitor_tracker$ridden[i] / 
                                    visitor_tracker$time_step[i]), 
                                     digits = 1)
    ratio_based <- c(ratio_based, ratio_satisfaction)
  }
  
  # now putting both sides together
  almost_satisfaction <- round((0.75 * fun_points_based) + (0.25 * ratio_based), 
                               digits = 1)
  
  # now we min max standardization again
  first_satisfaction_range <- range(almost_satisfaction)
  first_least_satisfaction_visitor <- range(almost_satisfaction)[1]
  first_most_satisfaction_visitor <- range(almost_satisfaction)[2]
  
  # creating an empty vector to store complete satisfaction
  complete_satisfaction <- vector()
  # filling in the vector
  for(i in visitors){
    two_part_satisfaction <- round(((almost_satisfaction[i] - 
                                       first_least_satisfaction_visitor)/
                                        (first_most_satisfaction_visitor - 
                                           first_least_satisfaction_visitor))*5, 
                                     digits = 1)
    complete_satisfaction <- c(complete_satisfaction, two_part_satisfaction)
  }
  
 visitor_tracker$satisfaction <- complete_satisfaction
  
  return(visitor_tracker$satisfaction)
}

# function that updates satisfaction again once we have a complete visitor_tracker
# after each time step
f.get_new_satisfaction_score <-  function(visitor_tracker_merged){
  # fun points side of satisfaction
  # calculating range of points earned by visitors
  first_points_range <- range(visitor_tracker_merged$points)
  first_least_points_visitor <- range(visitor_tracker_merged$points)[1]
  first_most_points_visitor <- range(visitor_tracker_merged$points)[2]
  
  # creating an empty vector to store fun points part
  fun_points_based <- vector()
  # filling in the vector
  for(i in visitors){
    fun_points_satisfaction <- round(((visitor_tracker$points[i] - 
                                         first_least_points_visitor)/
                                        (first_most_points_visitor - 
                                           first_least_points_visitor))*5, 
                                     digits = 1)
    fun_points_based <- c(fun_points_based, fun_points_satisfaction)
  }
  
  # ratio side of satisfaction
  # creating an empty vector to store ratio part
  ratio_based <- vector()
  # filling in the vector
  for(i in visitors){
    ratio_satisfaction <- round((visitor_tracker$ridden[i] / 
                                   visitor_tracker$time_step[i]), 
                                digits = 1)
    ratio_based <- c(ratio_based, ratio_satisfaction)
  }
  
  # now putting both sides together
  almost_satisfaction <- round((0.75 * fun_points_based) + (0.25 * ratio_based), 
                               digits = 1)
  
  # now we min max standardization again
  first_satisfaction_range <- range(almost_satisfaction)
  first_least_satisfaction_visitor <- range(almost_satisfaction)[1]
  first_most_satisfaction_visitor <- range(almost_satisfaction)[2]
  
  # creating an empty vector to store complete satisfaction
  complete_satisfaction <- vector()
  # filling in the vector
  for(i in visitors){
    two_part_satisfaction <- round(((almost_satisfaction[i] - 
                                       first_least_satisfaction_visitor)/
                                      (first_most_satisfaction_visitor - 
                                         first_least_satisfaction_visitor))*5, 
                                   digits = 1)
    complete_satisfaction <- c(complete_satisfaction, two_part_satisfaction)
  }
  
  visitor_tracker_merged$satisfaction <- complete_satisfaction
  
  return(visitor_tracker_merged$satisfaction)
  return(round(visitor_tracker_merged$satisfaction, digits = 1))
}

# === 8) wait time =============================================================
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


# === 9) ride time =============================================================
# we want to know how many time steps visitors spend riding 
# adding a column to visitor tracker
visitor_tracker$ridden <- 0
# a function that takes in visitor_tracker and adds one waited time_step to 
# each waiting visitor
f.get_ridden <- function(visitor_tracker){
  for(i in visitors){
    if(visitor_tracker$progress[i] != "waiting"){
      visitor_tracker$ridden[i] <- visitor_tracker$ridden[i] + 1
    }
  }
  return(visitor_tracker$ridden)
}

# updating ridden after first time step
f.get_new_ridden <- function(visitor_tracker_merged){
  for(i in visitors){
    if(visitor_tracker_merged$progress[i] != "waiting"){
      visitor_tracker_merged$ridden[i] <- visitor_tracker_merged$ridden[i] + 1
    }
  }
  return(visitor_tracker_merged$ridden)
}

# === 10) complete rides =======================================================
# we want to know how many time steps visitors spend riding 
# adding a column to visitor tracker
visitor_tracker$completed_rides <- 0
# a function that takes in visitor_tracker and adds one waited time_step to 
# each waiting visitor
f.get_completed_rides <- function(visitor_tracker){
  for(i in visitors){
    if(visitor_tracker$progress[i] == "final stage"){
      visitor_tracker$completed_rides[i] <- visitor_tracker$completed_rides[i] + 1
    }
  }
  return(visitor_tracker$completed_rides)
}

# updating ridden after first time step
f.get_new_completed_rides <- function(visitor_tracker_merged){
  for(i in visitors){
    if(visitor_tracker_merged$progress[i] == "final stage"){
      visitor_tracker_merged$completed_rides[i] <- 
        visitor_tracker_merged$completed_rides[i] + 1
    }
  }
  return(visitor_tracker_merged$completed_rides)
}

# === 11) initializing =========================================================
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
  # adding time in ride column (to keep track of how long a visitor has been in
  # a ride for)
  visitor_tracker$time_in_ride <- NA
  # adding 1 to time in ride
  visitor_tracker$time_in_ride <- f.get_time_in_ride(visitor_tracker)
  # adding progress (stage) column
  visitor_tracker$progress <- NA
  # assigning a progress stage based on time in ride and ride duration
  visitor_tracker$progress <- f.get_progress(visitor_tracker)
  # adding points column to the data frame
  visitor_tracker$points <- 0
  # calculating points based on status
  visitor_tracker$points <- f.get_points(visitor_tracker)
  # adding waited column to data frame
  visitor_tracker$waited <- 0
  # adding a waited time column to all waiting visitors
  # this keeps track of the number of time steps each visitor has waited so far
  visitor_tracker$waited <- f.get_waited(visitor_tracker)
  # adding ridden column to data frame
  visitor_tracker$ridden <- 0
  # this keeps track of how the number of how many time steps each visitor has spent
  # riding a ride
  visitor_tracker$ridden <- f.get_ridden(visitor_tracker)
  # adding completed rides column to data frame
  visitor_tracker$completed_rides <- 0
  # this keeps track of how the number of rides each visitor has ridden so far
  visitor_tracker$completed_rides <- f.get_completed_rides(visitor_tracker)
  #adding satisfaction column to data frame
  visitor_tracker$satisfaction <- 0
  # calculating satisfaction based on points
  visitor_tracker$satisfaction <- f.get_satisfaction_score(visitor_tracker)

  # return visitor_tracker
  return(visitor_tracker)
}

# === 12) move up in line function =============================================
# the visitors that didn't get to go on a ride this time step move up one spot
# in line
# we create a new data frame that includes only the waiters 
waiting_visitors <- visitor_tracker_i[visitor_tracker_i$spot_in_line >1,]

# move waiting visitors up in line
f.move_up_waiting_visitors <- function(waiting_visitors){
  waiting_visitors$spot_in_line <- waiting_visitors$spot_in_line - 1
  return(waiting_visitors)
}

# === next ride shortest line function
f.get_next_ride_shortest_wait <- function(final_stage_visitors){
# testing
# f.get_next_ride_shortest_wait <- function(){
  # riding_visitors <- visitor_tracker_i[visitor_tracker_i$spot_in_line == 1,]
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
  next_ride <- sample(x = rides$ride_name, size = nrow(final_stage_visitors),
                      replace = TRUE, prob = probs)
  
  return(next_ride)
}  

# === 13a) get next time step RANDOM ===========================================
f.get_next_time_step_random <- function(){
  # step 1
  # the visitors that went through the final stage of a ride in the previous time 
  # step will now go to a new one
  # we create a new data frame that includes only the visitors at the final stage
  # of their ride
  final_stage_visitors <- visitor_tracker_i[visitor_tracker_i$progress == "final stage",]
  
  # step 2
  # we reset final stage visitors time_in_ride counter
  final_stage_visitors$time_in_ride <- 0
  
  # step 3
  # we randomly assign them a new ride
  next_ride <- sample(x = rides$ride_name, size = nrow(final_stage_visitors),
  replace = TRUE)
  # assigning ride now - we replace the old ride with the new one in the data frame
  final_stage_visitors$ride <- next_ride
  
  # step 4
  # we find the visitors currently riding a ride (not in final stage)
  # these visitors will just continue riding
  # so we create a new data frame that includes only in progress riders 
  riding_visitors <- visitor_tracker_i[visitor_tracker_i$progress == "in progress",]
  
  # step 5
  # the visitors that didn't get to go on a ride this time step move up one spot
  # in line
  # we create a new data frame that includes only the waiters 
  waiting_visitors <- visitor_tracker_i[visitor_tracker_i$spot_in_line > 1,]
  # and move them up in line
  waiting_visitors <- f.move_up_waiting_visitors(waiting_visitors)
  
  # step 6 
  # we merge waiting and final stage visitors
  visitor_tracker_merged <- rbind(waiting_visitors, final_stage_visitors)
  
  # step 7
  # we update their spot in line 
  visitor_tracker_merged <- f.get_new_spot_in_line(visitor_tracker_merged)
  
  # step 8
  # then we update their status
  visitor_tracker_merged <- f.get_new_status(visitor_tracker_merged)
  
  # step 9
  # now we merge ALL the visitor data frames by merging the riding visitors
  # to the previously merged data frames
  visitor_tracker_merged <- rbind(riding_visitors, visitor_tracker_merged)
  
  # step 10
  # we add 1 to time in ride (for the current riders)
  visitor_tracker_merged$time_in_ride <- f.get_new_time_in_ride(visitor_tracker_merged)
  
  # step 11
  # we update their progress
  visitor_tracker_merged$progress <- f.get_new_progress(visitor_tracker_merged)
  
  # step 12
  # then we give them their points
  visitor_tracker_merged$points <- f.get_new_points(visitor_tracker_merged)
  
  # step 13
  # we add one waited time step to waiting visitors
  visitor_tracker_merged$waited <- f.get_new_waited(visitor_tracker_merged)
  
  # step 14
  # and one ridden time step to riding visitors
  visitor_tracker_merged$ridden <- f.get_new_ridden(visitor_tracker_merged)
  
  # step 15
  # also 1 completed ride to final stage visitors
  visitor_tracker_merged$completed_rides <- 
    f.get_new_completed_rides(visitor_tracker_merged)
  
  # step 16
  # we get satisfaction score
  visitor_tracker_merged$satisfaction <-
    f.get_new_satisfaction_score(visitor_tracker_merged)
  
  # the end
  return(visitor_tracker_merged)
}

# === 13b) get next time step COOLER BETTER ====================================
f.get_next_time_step_cooler_better <- function(){
  
  # step 1
  # the visitors that went through the final stage of a ride in the previous time 
  # step will now go to a new one
  # we create a new data frame that includes only the visitors at the final stage
  # of their ride
  final_stage_visitors <- visitor_tracker_i[visitor_tracker_i$progress == "final stage",]
  
  # step 2
  # we reset final stage visitors time_in_ride counter
  final_stage_visitors$time_in_ride <- 0
  
  # step 3
  # we assign them a new ride based on the cooler is better strategy
  next_ride <- sample(x = rides$ride_name, size = nrow(final_stage_visitors),
                      replace = TRUE, prob = rides$ride_prob)
  # assigning ride now - we replace the old ride with the new one in the data frame
  final_stage_visitors$ride <- next_ride
  
  # step 4
  # we find the visitors currently riding a ride (not in final stage)
  # these visitors will just continue riding
  # so we create a new data frame that includes only in progress riders 
  riding_visitors <- visitor_tracker_i[visitor_tracker_i$progress == "in progress",]
  
  # step 5
  # the visitors that didn't get to go on a ride this time step move up one spot
  # in line
  # we create a new data frame that includes only the waiters 
  waiting_visitors <- visitor_tracker_i[visitor_tracker_i$spot_in_line > 1,]
  # and move them up in line
  waiting_visitors <- f.move_up_waiting_visitors(waiting_visitors)
  
  # step 6 
  # we merge waiting and final stage visitors
  visitor_tracker_merged <- rbind(waiting_visitors, final_stage_visitors)
  
  # step 7
  # we update their spot in line 
  visitor_tracker_merged <- f.get_new_spot_in_line(visitor_tracker_merged)
  
  # step 8
  # then we update their status
  visitor_tracker_merged <- f.get_new_status(visitor_tracker_merged)
  
  # step 9
  # now we merge ALL the visitor data frames by merging the riding visitors
  # to the previously merged data frames
  visitor_tracker_merged <- rbind(riding_visitors, visitor_tracker_merged)
  
  # step 10
  # we add 1 to time in ride (for the current riders)
  visitor_tracker_merged$time_in_ride <- f.get_new_time_in_ride(visitor_tracker_merged)
  
  # step 11
  # we update their progress
  visitor_tracker_merged$progress <- f.get_new_progress(visitor_tracker_merged)
  
  # step 12
  # then we give them their points
  visitor_tracker_merged$points <- f.get_new_points(visitor_tracker_merged)
  
  # step 13
  # we add one waited time step to waiting visitors
  visitor_tracker_merged$waited <- f.get_new_waited(visitor_tracker_merged)
  
  # step 14
  # and one ridden time step to riding visitors
  visitor_tracker_merged$ridden <- f.get_new_ridden(visitor_tracker_merged)
  
  # step 15
  # also 1 completed ride to final stage visitors
  visitor_tracker_merged$completed_rides <- 
    f.get_new_completed_rides(visitor_tracker_merged)
  
  # step 16
  # we get satisfaction score
  visitor_tracker_merged$satisfaction <-
    f.get_new_satisfaction_score(visitor_tracker_merged)
  
  # the end
  return(visitor_tracker_merged)
}

# === 13c) get next time step SHORTEST WAIT ====================================
f.get_next_time_step_shortest_wait <- function(){
  # step 1
  # the visitors that went through the final stage of a ride in the previous time 
  # step will now go to a new one
  # we create a new data frame that includes only the visitors at the final stage
  # of their ride
  final_stage_visitors <- visitor_tracker_i[visitor_tracker_i$progress == "final stage",]
  
  # step 2
  # we reset final stage visitors time_in_ride counter
  final_stage_visitors$time_in_ride <- 0
  
  # step 3
  # we assign them a new ride based on shortest wait time
  next_ride <- f.get_next_ride_shortest_wait(final_stage_visitors)
  # assigning ride now - we replace the old ride with the new one in the data frame
  final_stage_visitors$ride <- next_ride
  
  # step 4
  # we find the visitors currently riding a ride (not in final stage)
  # these visitors will just continue riding
  # so we create a new data frame that includes only in progress riders 
  riding_visitors <- visitor_tracker_i[visitor_tracker_i$progress == "in progress",]
  
  # step 5
  # the visitors that didn't get to go on a ride this time step move up one spot
  # in line
  # we create a new data frame that includes only the waiters 
  waiting_visitors <- visitor_tracker_i[visitor_tracker_i$spot_in_line > 1,]
  
  # step 6
  # and move them up in line
  waiting_visitors <- f.move_up_waiting_visitors(waiting_visitors)
  
  # step 7 
  # we merge waiting and final stage visitors
  visitor_tracker_merged <- rbind(waiting_visitors, final_stage_visitors)
  
  # step 8
  # we update their spot in line 
  visitor_tracker_merged <- f.get_new_spot_in_line(visitor_tracker_merged)
  
  # step 9
  # then we update their status
  visitor_tracker_merged <- f.get_new_status(visitor_tracker_merged)
  
  # step 10
  # now we merge ALL the visitor data frames by merging the riding visitors
  # to the previously merged data frames
  visitor_tracker_merged <- rbind(riding_visitors, visitor_tracker_merged)
  
  # step 11
  # we add 1 to time in ride (for the current riders)
  visitor_tracker_merged$time_in_ride <- f.get_new_time_in_ride(visitor_tracker_merged)
  
  # step 12
  # we update their progress
  visitor_tracker_merged$progress <- f.get_new_progress(visitor_tracker_merged)
  
  # step 13
  # we add one waited time step to waiting visitors
  visitor_tracker_merged$waited <- f.get_new_waited(visitor_tracker_merged)
  
  # step 14
  # and one ridden time step to riding visitors
  visitor_tracker_merged$ridden <- f.get_new_ridden(visitor_tracker_merged)
  
  # step 15
  # also 1 completed ride to final stage visitors
  visitor_tracker_merged$completed_rides <- 
    f.get_new_completed_rides(visitor_tracker_merged)
  
  # step 16
  # then we give them their points
  visitor_tracker_merged$points <- f.get_new_points(visitor_tracker_merged)
  
  # the end
  return(visitor_tracker_merged)
}


#___ end of 2.functions_________________________________________________________
# Note that when file 2.functions is fully ran a number of errors indicating that
# objects 'visitor_tracker' and 'visitor_tracker_i" are not found will pop up.
# These objects will be defined and generated in the next file and so it is not 
# a problem.

