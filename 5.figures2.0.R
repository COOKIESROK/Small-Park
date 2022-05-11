
# === description ==============================================================
# This script uses csv file "CompleteVisitorTracker.csv" generated in 
# 3.tracking.data.R to create and save figures that help visualize the distribution 
# of visitors and their satisfaction with their park experience.

# === 1) read data =============================================================
# reading data
visitor_data <- read.csv(paste(p.data, "/", "CompleteVisitorTracker.csv", sep = ""))

#inspecting data
head(visitor_data)
str(visitor_data)

# === 2) visitor distribution time step 1 ======================================
# opening jpeg
jpeg(paste(p.fig, "Visitor distribution time step 1.jpeg", sep = ""), width = 650, 
     height = 650)
# bar plot of visitor distribution at time step 1
visitor_dist_timestep_1 <- 
  table(complete_visitor_tracker[complete_visitor_tracker$time_step == 1,]$ride)
bar_plot1 <- barplot(visitor_dist_timestep_1, ylab = "Number of visitors", 
        xlab = "Ride", main = "Visitor distribution time step 1",
        ylim = c(0, park_capacity))
# the line marks rice capacity (everyone above the line is waiting in line)
abline(h = ride_capacity, col = "red", lwd = 2)
dev.off()

# === 3) visitor distribution time step 2 ======================================
# opening jpeg
jpeg(paste(p.fig, "Visitor distribution time step 2.jpeg", sep = ""), width = 650, 
     height = 650)
# bar plot of visitor distribution at time step 2
visitor_dist_timestep_2 <- 
  table(complete_visitor_tracker[complete_visitor_tracker$time_step == 2,]$ride)
barplot(visitor_dist_timestep_2, ylab = "Number of visitors", 
        xlab = "Ride", main = "Visitor distribution time step 2",
        ylim = c(0, park_capacity))
abline(h = ride_capacity, col = "red", lwd = 2)
dev.off()

# === 4) visitor distribution time step 3 ======================================
# opening jpeg
jpeg(paste(p.fig, "Visitor distribution time step 3.jpeg", sep = ""), width = 650, 
     height = 650)
# bar plot of visitor distribution at time step 3
visitor_dist_timestep_3 <- 
  table(complete_visitor_tracker[complete_visitor_tracker$time_step == 3,]$ride)
barplot(visitor_dist_timestep_3, ylab = "Number of visitors", 
        xlab = "Ride", main = "Visitor distribution time step 3",
        ylim = c(0, park_capacity))
abline(h = ride_capacity, col = "red", lwd = 2)
dev.off()

# === 5) real cumulative points plot ===========================================
# After realizing my points were already cumulative I just needed to adjust my 
# certain parts of my plot (i no longer need the cum sum function) 

# creating an empty data frame with the time step as the first column and each
# visitor as the next column
time_steps_data <- as.data.frame(matrix(NA, ncol = park_capacity+1, nrow = cycle))
colnames(time_steps_data) <- c("time_step", visitors)
time_steps_data$time_step <- time_steps
head(time_steps_data)

# adding the (already cumulative) points to the data frame
for(i in visitors){
  time_steps_data[time_steps, i+1]<- 
    visitor_data$points[visitor_data$visitors == i]
}

# opening jpeg
jpeg(paste(p.fig, "Cumulative visitor points.jpeg", sep = ""), width = 650, 
     height = 650)

# plot
# specifying colors
# the red line is created so i can focus on a particular guest's experience
col.t <- c("red", rep("grey", park_capacity-1))
# specifying y limit
ylim.t <- c(0, max(time_steps_data))
#plotting
plot(NA, xlim =  c(1, cycle), ylim = ylim.t, ylab = "cumulative points", 
     xlab = "time step")
for(i in time_steps){
  lines(time_steps, time_steps_data[time_steps, i+1], col = col.t[i], 
        lwd = 2)
}
dev.off()
# === 6) satisfaction distribution =============================================
# opening jpeg
jpeg(paste(p.fig, "Overall Visitor Satisfaction.jpeg", sep = ""), width = 650, 
     height = 650)
# includes all satisfaction scores across all cycle
hist(visitor_data$satisfaction, xlab = "Visitor Satisfaction", 
     main = "Overall Visitor Satisfaction")
dev.off()

# opening jpeg
jpeg(paste(p.fig, "Visitor Satisfaction End of Cycle.jpeg", sep = ""), width = 650, 
     height = 650)
# only looks at satisfaction after the last time step
hist(visitor_data$satisfaction[visitor_data$time_step == 10], xlim = c(0,5), 
     xlab = "Visitor Satisfaction", main = "Visitor Satisfaction End of Cycle")
dev.off()

# === 7) experiment figure =====================================================
# explanatory variable
ride_caps <- c(25, 30, 35)
# response variable
mean_satis <- c(2.84, 2.87, 2.91)

# opening jpeg
jpeg(paste(p.fig, "Experiment plot.jpeg", sep = ""), width = 650, 
     height = 650)
plot(NA, ylab = "Mean vivisor satisfaction", ylim = c(0,5), xlim = c(0,4),
     xlab = "Ride capacity")
plot(ride_caps, mean_satis, pch = 19, cex = 2, col = "grey")
lines(ride_caps, mean_satis, col = "red", lwd = 2)
dev.off()




