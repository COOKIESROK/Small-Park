
# === description ==============================================================
# This script uses csv file "CompleteVisitorTracker.csv" generated in 
# 3.tracking.data.R to create and save figures that help visualize the distribution 
# of visitors and their satisfaction with their park experience.

# === installing and loading ggplot 2 =====
#install.packages("ggplot2")
#loading library
library("ggplot2")


# === 1) read data =============================================================
# reading data
visitor_data <- read.csv(paste(p.data, "/", "CompleteVisitorTracker.csv", sep = ""))

#inspecting data
head(visitor_data)
str(visitor_data)

# reading data
status_data <- read.csv(paste(p.data, "/", "StatusFrequencies.csv", sep = ""))

#inspecting data
head(status_data)
str(status_data)

# === setting colors ====
colors <- c("coolest" = "deepskyblue3", "lamest" = "coral2", "okayest" = "darkgoldenrod1" )

# === 2) loop for visitor distribution bar plot ================================
# starting loop
for(i in time_steps){
  # opening png
  png(paste(p.fig, "Visitor distribution time step", i, ".png", sep = ""), width = 650, 
       height = 650)
  
  # bar plot of visitor distribution at time step i
  visitor_dist_timestep_i <- 
    table(visitor_data[visitor_data$time_step == i,]$ride)
  
  # plot
  print(ggplot(data = as.data.frame(visitor_dist_timestep_i), aes(x=Var1, y=Freq)) +
    geom_bar(stat = "identity", fill = colors) +
    labs(y= "Frequency", x = "Ride") +
    ggtitle("Visitor Distribution"))
  
  # send off
  dev.off()
}


# === 3) cumulative points plot with mean points line ==========================
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

# opening png
png(paste(p.fig, "Cumulative visitor points.png", sep = ""), width = 650, 
     height = 650)

# adding 1 to time steps so i can have an extra line for the mean
park_capacity_plus_1 <- park_capacity + 1
visitors_plus_1 <- c(1:park_capacity_plus_1)

# plot
# specifying colors
# a red line can be added so I can focus on a particular guest's experience
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
  lines(unlist(time_steps), unlist(time_steps_data[time_steps, park_capacity+2]), col = "red",
        lwd = 2)
}
dev.off()
# === 3) cumulative points plot with mean points line GGPLOT ATTEMPT FAILED FOR NOW ==========================
# creating an empty data frame with the time step as the first column and each
# visitor as the next column
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
# # opening png
# png(paste(p.fig, "Cumulative visitor points.png", sep = ""), width = 650, 
#      height = 650)
# 
# # adding 1 to time steps so i can have an extra line for the mean
# park_capacity_plus_1 <- park_capacity + 1
# visitors_plus_1 <- c(1:park_capacity_plus_1)
# 
# # plot
# # specifying colors
# # a red line can be added so I can focus on a particular guest's experience
# col.t <- c(rep("grey", park_capacity))
# # specifying y limit
# ylim.t <- c(0, max(time_steps_data))
# 
# 
# # plot
# for(i in visitors){
#     print(ggplot(data = time_steps_data, aes(x = time_step)) +
#       geom_line(aes(y = time_steps_data[time_steps, i + 1]), size = 1))
#  }
# 
# #plotting
# plot(NA, xlim =  c(1, cycle), ylim = ylim.t, ylab = "cumulative points", 
#      xlab = "time step")
# # each visitors' lines
# for(i in visitors){
#   lines(time_steps, time_steps_data[time_steps, i + 1], col = col.t[i],
#         lwd = 2)
# }
# # the mean points line
# for(i in park_capacity){
#   lines(unlist(time_steps), unlist(time_steps_data[time_steps, park_capacity+2]), col = "red",
#         lwd = 2)
# }
# dev.off()


# === 4) satisfaction distribution BASE R ======================================

# # opening png
# png(paste(p.fig, "Visitor Satisfaction End of Cycle.png", sep = ""), width = 650, 
#      height = 650)
# # only looks at satisfaction after the last time step
# hist(visitor_data$satisfaction[visitor_data$time_step == 10], xlim = c(0,5), 
#      xlab = "Visitor Satisfaction", main = "Visitor Satisfaction End of Cycle", 
#      col = rainbow(10))
# dev.off()

# === 4) satisfaction distribution =============================================
# opening png
png(paste(p.fig, "Visitor Satisfaction End of Cycle.png", sep = ""), width = 650, 
     height = 650)

# only looks at satisfaction after the last time step
#plot 
ggplot(as.data.frame(visitor_data[visitor_data$time_step == 10,])
       , aes(x=satisfaction)) +
  geom_histogram(bins = 5, color="white") +
  labs(y= "Frequency", x = "Satisfaction") +
  ggtitle("Visitor Satisfaction End of Cycle") +
  scale_x_continuous(breaks = c(0:5))

#send off
dev.off()

# === 5) satisfaction vs waited time steps plot ================================

plot(visitor_data$waited[visitor_data$time_step == cycle], 
visitor_data$satisfaction[visitor_data$time_step == cycle], 
main="Time steps spent waiting
     against satisfaction", xlab="Time steps spent waiting", ylab="Satisfaction ",
     pch=19, xlim = c(0, waited_range[2]), col= "gray")
abline(lm(visitor_data$satisfaction[visitor_data$time_step == cycle] ~ 
         visitor_data$waited[visitor_data$time_step == cycle]), col="red")


# === riding visitors freq ====
# opening png
png(paste(p.fig, "Riding Visitors.png", sep = ""), width = 900, 
     height = 650)

# plot
ggplot(data = status_data, aes(x = X)) +
  geom_line(aes(y = r_coolest, color = "coolest"), size = 1) + 
  geom_line(aes(y = r_lamest, color = "lamest"), size = 1) + 
  geom_line(aes(y = r_okayest, color = "okayest"), size = 1) +
  labs(y= "Status Frequency", x = "Timestep") +
  scale_color_manual(name = "Rides", values = colors) +
  ggtitle("Riding Visitors") +
  scale_x_continuous(breaks = time_steps)

# send off
dev.off()

# === waiting visitors freq ====
# opening png
png(paste(p.fig, "Waiting Visitors.png", sep = ""), width = 900, 
     height = 650)
# plot
ggplot(data = status_data, aes(x = X)) +
  geom_line(aes(y = w_coolest, color = "coolest"), size = 1) + 
  geom_line(aes(y = w_lamest, color = "lamest"), size = 1) + 
  geom_line(aes(y = w_okayest, color = "okayest"), size = 1) +
  labs(y= "Status Frequency", x = "Timestep") +
  scale_color_manual(name = "Rides", values = colors) +
  ggtitle("Waiting Visitors") +
  scale_x_continuous(breaks = time_steps)

# send off
dev.off()


#___ end of 5.figures __________________________________________________________