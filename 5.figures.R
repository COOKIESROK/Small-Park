
# === description ==============================================================
## brief description what the script file is about
# - change color of barplot
# - save figures as pdf

# === 1) time step 1 ======================================
# bar plot of visitor distribution at time step 1
visitor_dist_timestep_1 <- 
  table(complete_visitor_tracker[complete_visitor_tracker$time_step == 1,]$ride)
barplot(visitor_dist_timestep_1, ylab = "Number of visitors", 
        xlab = "Ride", main = "Visitor distribution time step 1")

# bar plot of waiting visitors at time step 1
waiting_visitors_timestep_1 <- 
  table(complete_visitor_tracker[complete_visitor_tracker$time_step == 1,]$spot_in_line)
barplot(waiting_visitors_timestep_1, ylab = "Number of visitors", 
        xlab = "Ride", main = "Waiting visitors in time step 1")

# === 1) visitor distribution time step 2 ======================================
# bar plot of visitor distribution at time step 2
visitor_dist_timestep_2 <- 
  table(complete_visitor_tracker[complete_visitor_tracker$time_step == 2,]$ride)
barplot(visitor_dist_timestep_2, ylab = "Number of visitors", 
        xlab = "Ride", main = "Visitor distribution time step 2")

# === 1) visitor distribution time step 3 ======================================
# bar plot of visitor distribution at time step 3
visitor_dist_timestep_3 <- 
  table(complete_visitor_tracker[complete_visitor_tracker$time_step == 3,]$ride)
barplot(visitor_dist_timestep_3, ylab = "Number of visitors", 
        xlab = "Ride", main = "Visitor distribution time step 3")

# === 2) visitor distribution time steps looped ================================
# === line plot ========

table(complete_visitor_tracker[complete_visitor_tracker$time_step == 1,]$ride) +
  table(complete_visitor_tracker[complete_visitor_tracker$time_step == 2,]$ride)+
  table(complete_visitor_tracker[complete_visitor_tracker$time_step == 3,]$ride)+
  table(complete_visitor_tracker[complete_visitor_tracker$time_step == 4,]$ride)+

aggregate(table(complete_visitor_tracker[complete_visitor_tracker$time_step,]$ride), 
          by = list(rides), FUN = sum)
?aggregate







