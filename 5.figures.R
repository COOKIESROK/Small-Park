
# === description ==============================================================
## brief description what the script file is about
# - change color of barplot
# - save figures as pdf

# === 1) visitor distribution time step 1 ======================================
# bar plot of visitor distribution at time step 1
visitor_dist_timestep_1 <- table(visitor_tracker$ride[1:park_capacity,])
barplot(visitor_dist_timestep_1, ylab = "Number of visitors", 
        xlab = "Ride", main = "Visitor distribution time step 1")

# === 2) visitor distribution time step 2 ======================================
# bar plot of visitor distribution at time step 1
visitor_dist_timestep_2 <- table(visitor_tracker_merged$ride[1:park_capacity,])
barplot(visitor_dist_timestep_2, ylab = "Number of visitors", 
        xlab = "Ride", main = "Visitor distribution time step 2")