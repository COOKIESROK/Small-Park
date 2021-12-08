
# === description ==============================================================
## brief description what the script file is about
# - change color of barplot
# - save figures as pdf

# === 1) visitor distribution time stamp 1 =====================================
# bar plot of visitor distribution at time stamp 1
visitor_dist_timestamp_1 <- table(visitor_tracker$ride[1:park_capacity,])
barplot(visitor_dist_timestamp_1, ylab = "Number of visitors", 
        xlab = "Ride", main = "Visitor distribution time stamp 1")