
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
# f.get_spot_in_line <- function(visitor_tracker){
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

f.get_spot_in_line_looped <- function(visitor_tracker){
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
}

# === 2) status assigner =======================================================
# creating states for visitors, they can either be riding or waiting to ride
# any of the rides
states <- c("r_coolest", "w_coolest", "r_okayest", "w_okayest", "r_lamest", "w_lamest")

# ride_capacity visitors get status riding for each ride, the rest get waiting

# a function that takes in visitor_tracker and returns status of each visitor
# f.get_status <- function(visitor_tracker){
  # for the visitors riding the coolest ride
  visitor_tracker[(visitor_tracker$ride == "coolest") &
                    (visitor_tracker$spot_in_line <= 1), ]$status <- states[1]
  # for the visitors waiting to ride the coolest ride
  if(coolest_visitors > ride_capacity){
    visitor_tracker[(visitor_tracker$ride == "coolest") &
                      (visitor_tracker$spot_in_line >= 2), ]$status <- states[2]}
  # for the visitors riding the okayest ride
  visitor_tracker[(visitor_tracker$ride == "okayest") &
                    (visitor_tracker$spot_in_line <= 1), ]$status <- states[3]
  # for the visitors waiting to ride the okayest ride
  if(okayest_visitors > ride_capacity){
    visitor_tracker[(visitor_tracker$ride == "okayest") &
                      (visitor_tracker$spot_in_line >= 2), ]$status <- states[4]}
  # for the visitors riding the lamest ride
  visitor_tracker[(visitor_tracker$ride == "lamest") &
                    (visitor_tracker$spot_in_line <= 1), ]$status <- states[5]
  # for the visitors waiting to ride the lamest ride
  if(lamest_visitors > ride_capacity){
    visitor_tracker[(visitor_tracker$ride == "lamest") &
                      (visitor_tracker$spot_in_line >= 2), ]$status <- states[6]}
}

f.get_status_looped <- function(visitor_tracker){
  visitor_tracker$status <- NA
  for(i in visitors){
    if(visitor_tracker$ride[i,] == "coolest"){
      # for the visitors riding the coolest ride
      visitor_tracker[(visitor_tracker$ride == "coolest") &
                        (visitor_tracker$spot_in_line <= 1), ]$status <- states[1]
      # for the visitors waiting to ride the coolest ride
      if(coolest_visitors > ride_capacity){
        visitor_tracker[(visitor_tracker$ride == "coolest") &
                          (visitor_tracker$spot_in_line >= 2), ]$status <- states[2]}}
    if(visitor_tracker$ride[i,] == "okayest"){
      # for the visitors riding the okayest ride
      visitor_tracker[(visitor_tracker$ride == "okayest") &
                        (visitor_tracker$spot_in_line <= 1), ]$status <- states[3]
      # for the visitors waiting to ride the okayest ride
      if(okayest_visitors > ride_capacity){
        visitor_tracker[(visitor_tracker$ride == "okayest") &
                          (visitor_tracker$spot_in_line >= 2), ]$status <- states[4]}}
    if(visitor_tracker$ride[i,] == "lamest"){
      # for the visitors riding the lamest ride
      visitor_tracker[(visitor_tracker$ride == "lamest") &
                        (visitor_tracker$spot_in_line <= 1), ]$status <- states[5]
      # for the visitors waiting to ride the lamest ride
      if(lamest_visitors > ride_capacity){
        visitor_tracker[(visitor_tracker$ride == "lamest") &
                          (visitor_tracker$spot_in_line >= 2), ]$status <- states[6]}}
  }
}

# === TIME TO FIGURE OUT LOOPS ONCE AND FOR ALL ====









