
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

# === loop for visitor distribution bar plot =====
# starting loop
for(i in time_steps){
  # opening jpeg
  jpeg(paste(p.fig, "Visitor distribution time step", i, ".jpeg", sep = ""), width = 650, 
       height = 650)
  # bar plot of visitor distribution at time step i
  visitor_dist_timestep_i <- 
    table(visitor_data[visitor_data$time_step == i,]$ride)
  bar_plot_i <- barplot(visitor_dist_timestep_i, ylab = "Number of visitors", 
                       xlab = "Ride", main = (paste("Visitor distribution time step", 
                                                    i, ".jpeg", sep = "")),
                       ylim = c(0, park_capacity))
  # the line marks ride capacity (everyone above the line is waiting in line)
  abline(h = ride_capacity, col = "red", lwd = 2)
  dev.off()
}

# # === 5) real cumulative points plot ===========================================
# # creating an empty data frame with the time step as the first column and each
# # visitor as the next column
# time_steps_data <- as.data.frame(matrix(NA, ncol = park_capacity+1, nrow = cycle))
# colnames(time_steps_data) <- c("time_step", visitors)
# time_steps_data$time_step <- time_steps
# head(time_steps_data)
# 
# # adding the (already cumulative) points to the data frame
# for(i in visitors){
#   time_steps_data[time_steps, i+1]<- 
#     visitor_data$points[visitor_data$visitors == i]
# }
# 
# # adding extra column to time steps data frame for mean points
# time_steps_data$mean_points <- 0
# 
# # populating the mean points column with mean points calculated in 4.analysis
# time_steps_data$mean_points <- mean_points_tracker[2]
# 
# # opening jpeg
# jpeg(paste(p.fig, "Cumulative visitor points.jpeg", sep = ""), width = 650, 
#      height = 650)
# 
# # adding 1 to time steps so i can have an extra line for the mean
# park_capacity_plus_1 <- park_capacity + 1
# 
# # plot
# # specifying colors
# # the red line is created so I can focus on a particular guest's experience
# col.t <- c(rep("grey", park_capacity), "red")
# # specifying y limit
# ylim.t <- c(0, max(time_steps_data))
# #plotting
# plot(NA, xlim =  c(1, cycle), ylim = ylim.t, ylab = "cumulative points", 
#      xlab = "time step")
# for(i in time_steps){
#   lines(time_steps, time_steps_data[time_steps, i + 1], col = col.t[i], 
#         lwd = 2)
# }
# 
# dev.off()

# === 5) messing with real cumulative points plot to add mean red line =========
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

# adding extra column to time steps data frame for mean points
time_steps_data$mean_points <- 0

# populating the mean points column with mean points calculated in 4.analysis
time_steps_data$mean_points <- mean_points_tracker[2]

# opening jpeg
jpeg(paste(p.fig, "Cumulative visitor points.jpeg", sep = ""), width = 650, 
     height = 650)

# adding 1 to time steps so i can have an extra line for the mean
park_capacity_plus_1 <- park_capacity + 1
visitors_plus_1 <- c(1:park_capacity_plus_1)

# plot
# specifying colors
# the red line is created so I can focus on a particular guest's experience
col.t <- c(rep("grey", park_capacity))
# specifying y limit
ylim.t <- c(0, max(time_steps_data))
#plotting
plot(NA, xlim =  c(1, cycle), ylim = ylim.t, ylab = "cumulative points", 
     xlab = "time step")
# each visitors' lines
for(i in visitors){
  lines(time_steps, time_steps_data[time_steps, i + 1], col = col.t[i],
        lwd = 2)
}
# the mean points line
for(i in park_capacity){
  lines(unlist(time_steps), unlist(time_steps_data[time_steps, 14]), col = "red",
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




