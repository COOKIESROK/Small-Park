
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
jpeg(paste(p.fig, "Visitor distribution time step 1.jpeg", sep = ""), width = 550, 
     height = 550)
# bar plot of visitor distribution at time step 1
visitor_dist_timestep_1 <- 
  table(complete_visitor_tracker[complete_visitor_tracker$time_step == 1,]$ride)
bar_plot1 <- barplot(visitor_dist_timestep_1, ylab = "Number of visitors", 
        xlab = "Ride", main = "Visitor distribution time step 1",
        ylim = c(0, park_capacity))
abline(h = ride_capacity, col = "red", lwd = 2)
dev.off()

# === 3) visitor distribution time step 2 ======================================
# opening jpeg
jpeg(paste(p.fig, "Visitor distribution time step 2.jpeg", sep = ""), width = 550, 
     height = 550)
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
jpeg(paste(p.fig, "Visitor distribution time step 3.jpeg", sep = ""), width = 550, 
     height = 550)
# bar plot of visitor distribution at time step 3
visitor_dist_timestep_3 <- 
  table(complete_visitor_tracker[complete_visitor_tracker$time_step == 3,]$ride)
barplot(visitor_dist_timestep_3, ylab = "Number of visitors", 
        xlab = "Ride", main = "Visitor distribution time step 3",
        ylim = c(0, park_capacity))
abline(h = ride_capacity, col = "red", lwd = 2)
dev.off()

# === 5) cumulative points plot ================================================
# After doing all this work I realized my points were alreay cumulative. I felt
# very dumb (trust me) so I decided to keep all this code here as a reminder to 
#  think about what I wanna do before diving in. 

# time_steps_data <- as.data.frame(matrix(NA, ncol = park_capacity+1, nrow = cycle))
# # colnames(years.data) <- c("years", 1:30)
# colnames(time_steps_data) <- c("time_step", visitors)
# # years.data$years <- years
# time_steps_data$time_step <- time_steps
# head(time_steps_data)
# 
# # make cumulative data frame
# time_steps_data_cum <- time_steps_data
# for(i in visitors){
#   time_steps_data_cum[time_steps, i+1]<- 
#     cumsum(as.numeric(visitor_data$points[visitor_data$visitors == i]))
# }
# 
# # opening jpeg
# jpeg(paste(p.fig, "Cumulative visitor points.jpeg", sep = ""), width = 550, 
#      height = 550)
# 
# # plot
# col.t <- c("red", rep("grey", park_capacity-1))
# ylim.t <- c(0, max(time_steps_data_cum))
# # pdf(paste(path.figures, "November.in.Squamish.pdf", sep = ""), width = 10, 
# #     height = 5)
# plot(NA, xlim =  c(1, cycle), ylim = ylim.t, ylab = "cumulative points", 
#      xlab = "time step")
# for(i in time_steps){
#   lines(time_steps, time_steps_data_cum[time_steps, i+1], col = col.t[i], 
#         lwd = 2)
# }
# dev.off()

# === 5)  real cumulative points plot ==========================================
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
jpeg(paste(p.fig, "Cumulative visitor points.jpeg", sep = ""), width = 550, 
     height = 550)

# plot
# specifying colors
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
jpeg(paste(p.fig, "Overall Visitor Satisfaction.jpeg", sep = ""), width = 550, 
     height = 550)
# includes all satisfaction scores across all cycle
hist(visitor_data$satisfaction, xlab = "Visitor Satisfaction", 
     main = "Overall Visitor Satisfaction")
dev.off()

# opening jpeg
jpeg(paste(p.fig, "Visitor Satisfaction End of Cycle.jpeg", sep = ""), width = 550, 
     height = 550)
# only looks at satisfaction after the last time step
hist(visitor_data$satisfaction[visitor_data$time_step == 10], xlim = c(0,5), 
     xlab = "Visitor Satisfaction", main = "Visitor Satisfaction End of Cycle")
dev.off()







