
# === description ==============================================================
## brief description what the script file is about
# 

# === 1) ride picker =========================================================
# for random ride picking
f.ride_picker <- function(visitor_col,assigned_ride){
  # for random ride picking
  random_ride <- as.data.frame(sample(x = rides,
                                      size = park_capacity,
                                      replace = TRUE))
  colnames(random_ride) <- "ride"
  assigned_ride <- random_ride
  cbind(visitor_col, assigned_ride)
}

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
#   cbind(visitor_col, assigned_ride)
# }
# 
# f.ride_picker(visitor_col, assigned_ride)

# === 1) expanding ride column =================================================
# adding ride column to visitor tracker but this data frame is not tidy
# we tidy it so the rides are columns and presence is 1
long_visitor_tracker$ride <- assigned_ride

# creating columns for the rides
coolest_ride_vis <- as.data.frame(matrix(rep(visitors)))
okayest_ride_vis <- as.data.frame(matrix(rep(0,park_capacity)))
lamest_ride_vis <- as.data.frame(matrix(rep(0,park_capacity)))

# binding ride columns to long_visitor_tracker
visitor_tracker <- cbind(long_visitor_tracker, coolest_ride_vis, okayest_ride_vis, 
                         lamest_ride_vis)
colnames(visitor_tracker) <- c("time stamp", "visitors", "ride","coolest",
                               "okayest","lamest")

f.expand_ride_col <- function(long_visitor_tracker, visitor_tracker){
  for (i in visitors) {
    if(long_visitor_tracker$ride[i] == "coolest"){
      visitor_tracker$coolest[i] <- 1
    }
    if(long_visitor_tracker$ride[visitor] == "okayest"){
      visitor_tracker$okayest[visitor] <- 1
    }
    if(long_visitor_tracker$ride[visitor] == "lamest"){
      visitor_tracker$lamest[visitor] <- 1
    }
  }
}

f.expand_ride_col(long_visitor_tracker, tracker)

