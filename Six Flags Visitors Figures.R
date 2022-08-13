# === description ==============================================================


# === installing and loading ggplot 2 =====
#install.packages("ggplot2")
#loading library
library("ggplot2")

# === lists ====
# these might or might not be useful 
# list of six flags parks
six_flags_parks <- c("La Ronde", "Discovery Kingdom", "Fiesta Texas", "Great Adventure",
                     "Great America", "Magic Mountain", "Mexico", "New England",
                     "Over Georgia", "Over Texas", "St Louis")

color_scheme_11 <- c("#ec664d", "#fcc542", "#84bbc4", "083452", "#818186", "#ec664d", 
                     "#fcc542", "#84bbc4", "083452", "#818186", "#ec664d")

color_scheme <- c("#ec664d", "#fcc542", "#84bbc4", "083452")
color_scheme <- c("#ec664d", "#fcc542", "royalblue4", "#84bbc4")



# === 1) reading data ==========================================================
# reading data
six_flags_data <- read.csv(file = "SixFlagsData.csv")

#inspecting data
head(six_flags_data)
str(six_flags_data)

# === mean wait time bar plot =======
# finding mean wait time for each park


ggplot(six_flags_data, aes(Park, Average.wait.time)) +    
  geom_bar(position = "dodge",
           stat = "summary",
           fun = "mean",
           fill = "#ec664d") +
  theme_classic() +
  # theme(axis.text.x = element_text(angle = 30, vjust = 1, hjust = 1)) +
  theme(axis.text.x = element_text(angle = -30, vjust = 1, hjust = 0.2)) +
  ylab("Mean wait time") +
  xlab("Six Flags Parks")

ggsave("Mean wait time.png")

# === mean distance bar plot =======
ggplot(six_flags_data, aes(Park, Distance.from.main.gate)) +    
  geom_bar(position = "dodge",
           stat = "summary",
           fun = "mean",
           fill = "#fcc542") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = -30, vjust = 1, hjust = 0.2)) +
  ylab("Mean Distance from Main Gate") +
  xlab("Six Flags Parks")

ggsave("Mean distance.png")
        



# === type of ride ======

ggplot(six_flags_data, aes(fill = Type.of.ride, x = Park)) + 
  geom_bar(position = "dodge", stat = "count") +
  theme_classic() +
  ylab("Number of Rides") +
  xlab("Six Flags Parks") +
  theme(axis.text.x = element_text(angle = -30, vjust = 1, hjust = 0.2)) +
  guides(fill=guide_legend(title="Types of Rides")) +
  scale_fill_manual(values = color_scheme)

ggsave("Type of rides.png")



# === distance vs wait time ======
ggplot(six_flags_data, aes(x = Distance.from.main.gate, y = Average.wait.time)) + 
  geom_point(color = "#84bbc4") +
  theme_classic() +
  ylab("Average Wait Time") +
  xlab("Distance from Main Gate") +
  geom_smooth(method = lm, color = "black", se = FALSE)

ggsave("Distance vs wait times.png")









