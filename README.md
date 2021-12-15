## Where are you waiting?
An exploration of amusement park visitor distribution
Sofia Graves

## Introduction.
The goal of an amusement park is to get visitors to come back (over and over). This means that visitor satisfaction is very important. In 2017, a study focused on finding the factors that influence a visitors’ satisfaction (and in turn evaluation) of their overall amusement park experience. This was done by analysing the comments left on Trip Advisor for the top 20 North American amusement parks.  They found one of the main causes of outrage to be long wait times (Torres et al., 2017). Crowding is often worse than it has to be because park visitors tend to distribute themselves unevenly and inefficiently (Geissler & Rucks, 2011). Eliminating or even reducing the impacts of large crowds by increasing capacity is not sustainable so amusement parks must look for other strategies to improve visitor distribution. Geissler and Rucks suggest that well timed rewards and incentives could be offered to route visitors to less crowded areas of the park (Geissler & Rucks, 2011). First though, amusement park operators must figure out how their visitors are distributed. Amusement parks employ a range of strategies and technologies to track their guests such as wearables (Disney’s magic bands) or the guests’ own smartphones (Augur, 2016). Unfortunately, they do not release these data. The model created for this project uses simulated data to imitate a small amusement park. This allows researchers to set and experiment with different parameters to track the wait time and movement of the visitors. The visitors’ satisfaction with their visit is calculated at the end of the day. A couple advantages of generating data rather than collecting it include: 1) researchers have an idea of what they are expecting so it is easier to catch mistakes and 2) being able to modify parameters (such as cycle length, park and ride capacity) allows researchers to start with a very simple model and then add complexity to it.
The main goal of this project is to explore how different visitor distributions (as a result of different biases when choosing a ride or changes in park or ride capacities) affect overall guest satisfaction. A secondary goal is to find a form of distribution that maximizes visitor satisfaction as compared to a random distribution (and look for similarities). In the future, this research could be used to create route-planning algorithms and incentives programs. These will allow amusement park operators to better distribute their visitors keeping in mind real-time wait times, reservation facilities and fast passes as well as the different kinds of rides (Brown et al., 2013; Ohwada et al., 2014). Better distribution can have a huge impact in visitor satisfaction and therefore repeat visits fulfilling the amusement park goals. 

## Methods.
This model aims to imitate an amusement park which, at its simplest, includes 3 rides (coolest, okayest and lamest), has a park capacity of 12 visitors and a ride capacity (number of people that can go on each ride in one time step) of 3 (currently the same for all rides but this can be changed in the future). This model works by analyzing the data created by a combination of the first 3 scripts (as shown in Figure 1): 1.main.R (which includes setting global variables, and generating folders and file paths for a reproducible repo), 2.functions.R (which contains the definitions for all the functions used in the next script) and 3.tracking.data.R (which uses the functions defined in the previous script to create a csv file that tracks all visitors at all times and will be further explained). 

Figure 1.
 

At the beginning of a cycle (10 time steps), each visitor is randomly assigned to one of the 3 rides (in the future, bias will be added to this assignment) using the function f.ride_picker (built up from the sample function) and given a spot in line using the function f.get_spot_in_line (which is a loop that counts how many visitors are in line for each ride and sorts them in sets of 3). A visitor’s status is based on a combination of the previous 2 variables and is generated using the function f.get_status. How it works is the spots in line repeat 3 (ride capacity) times (meaning the line looks something like 1, 1, 1, 2, 2, 2, 3…), and so the first 3 visitors at each ride get the status of riding (r). The visitors in a spot larger than 1 get the status of waiting (w). There are a total of 6 states a visitor can be in: r_coolest, r_okayest, r_lamest, w_coolest, w_okayest and w_lamest. 
The visitors then earn cool points based on their status (f.get_points), those riding the coolest ride get 10 points, the okayest 5 points and the lamest 1 point. The waiting visitors don’t get points. Lastly, the visitors satisfaction scores are calculated based on the total number of points they have received by the function f.get_satisfaction_score. All the observations for the variables described above are kept in a data frame. 
The main data frame used in this model is called visitor_tracker because, well, it tracks the park’s visitors at all times. It is made up of the variables time_step, visitor, ride, spot_in_line, status, points and satisfaction (Figure 2 shows a snapshot). This data frame is updated in 9 steps the end of each time step (illustrated in Figure 3):
1) A riding_visitors data frame is created to contain all the visitors whose status starts with “r”.
2) A new ride is assigned to the visitors in riding_visitors using the random sample function.
3) A waiting_visitors data frame is created to contain all the visitors whose status starts with “w”.
4) The visitors in waiting_visitors are moved up one step in line by subtracting 1 from their spot_in_line. 
5) The riding_visitors and waiting_visitors data frames are merged (using the rbind function and keeping the waiting_visitors on the top rows) to create visitor_tracker_merged.
6) Spots in line are given to the visitors in the bottom rows of visitor_tracker_merged. 
7) All the visitors’ statuses are updated (adjusted to accommodate for their new ride and spot in line).
8) Each visitors’ points are updated to match their new status. 
9) Each visitors’ satisfaction scores are updated based on their new points. 

Figure 2.
 

Figure 3.
 

As previously mentioned, each ride gives a visitor a different number of cool points (10 for the coolest, 5 for okayest and 1 for lamest). These points are then used to calculate a visitor’s satisfaction (out of 5 stars on Yelp). Based on the assumption that the goal is to earn as many points as possible, true maximum satisfaction should come from riding the coolest ride every single time step. However, this is not possible given the design of the model so min-max normalization ((visitor satisfaction score satisfaction score range) * 5) was applied.
Other assumptions this model makes include a) all visitors arrive at the same time, b) visitors teleport from one ride to the next (they don’t spend time walking), c) visitors don’t take any sort of breaks between rides (in other words, visitors are waiting in line at all times) and d) a visitor can only be in one ride at a time.
In script 5.figures.R, a number of figures are created based on the data file generated by the model. These include bar plots to show the count of visitors at each ride in the first 3 time steps, a cumulative line plot of the points earned by each visitor, a histogram showing the distribution of satisfaction scores and a scatter plot based on the following experiment.
Due to the short time frame of the project, instead of comparing distributions with different biases toward each ride, distributions with different ride capacities were compared. Satisfaction is based on points earned and points are earned when a visitor goes on a ride. It stands to reason that if more visitors can earn points each time step, mean satisfaction score will increase. The question then, becomes “is the increase in mean satisfaction linear?” To answer the question, the model was run 3 times with a park capacity of 120 and ride capacity varying each time (25, 30 and 35). 



## Results.
At the end of the first cycle (park capacity = 120, ride capacity = 25), the mean satisfaction score was 2.84. As expected, the mean satisfaction score at the end of the second cycle (park capacity = 120, ride capacity = 30), was larger with a value of 2.87. Finally, the mean satisfaction score at the end of the third cycle (park capacity = 120, ride capacity = 35), was 2.91. Figure 4 shows a scatter plot illustrating the relationship between ride capacity and visitor satisfaction. 

Figure 4.
 

## Discussion.
The results of the experiment show an interesting pattern. The points line up almost perfectly which would suggest a linear relationship. However, 3 points are not enough to tell for sure. Ideally, the model would be run (testing different ride capacities) many more times to generate more data points which would give a more accurate answer to the question. Also, it would be smart to run the model a few times for each different ride capacity. Because the rides are chosen at random each time step and each time the model is run there is potentially significant variation in the mean visitor satisfaction at the end of each cycle. 
For now, all ride capacities are the same, rides are chosen randomly and there are no fast passes in the park. Future research could expand this model by changing ride capacities (and therefore speed at which different lines move). Also choosing rides at random is not very realistic. Future models could account for this by biasing the rides chosen by adding the “prob =” section to the sample function used to assign rides to visitors. The probability a ride is assigned to a visitor (or chosen by the visitor) could be based on how cool the ride is (it’s cool points) or maybe how long the line is (1/length of line). 


## The code.
https://github.com/COOKIESROK/Small-Park

## Reflection. 
Although I had a lot of fun and enjoyed the challenge, this project was much more difficult than I imaged. Creating a model from scratch involves a lot more planning than I initially expected. Building the functions was not difficult, making them work was the hard part, but once I figured out all I was missing was the return function everything went smoothly. Throughout the project I battled with random little bugs that would do crazy things to my data (like multiply points by 3 or give satisfaction scores of values higher than 5). This slowed me down given that many of my variables depended on previous oens. When I proposed the project, I thought I would be able to code my data generator much quicker and that I’d be able to add much more complexity to it. Turns out I grossly overestimated my abilities. Or maybe I was a little too excited about coding and creating my model. A few times I found myself doing a lot of extra work (like figuring out the cumsum() loop I needed for my cumulative points figure only to later realize that my points were already cumulative) because I didn’t always take the time to stop and see what I actually had so far and what I needed from there. I was looking at the big picture and small details at the same time but glazed over everything else. From now on, I’ll definitely pay more attention to that. I am excited to expand on this model and add more complexity to it as part of my keystone. 

 
## Sources.
Augur, H. (2016, June 9). Three Times Big Data Made Amusement Parks Better—Dataconomy. https://dataconomy.com/2016/06/three-times-big-data-made-amusement-parks-better/
Brown, A., Kappes, J., & Marks, J. (2013). Mitigating Theme Park Crowding with Incentives and Information on Mobile Devices. Journal of Travel Research, 52(4), 426–436. https://doi.org/10.1177/0047287512475216
Geissler, G. L., & Rucks, C. T. (2011). The overall theme park experience: A visitor satisfaction tracking study. Journal of Vacation Marketing, 17(2), 127–138. https://doi.org/10.1177/1356766710392480
Ohwada, H., Okada, M., & Kanamori, K. (2014). Route-Planning Algorithms for Amusement-Park Navigation. International Journal of Software Science and Computational Intelligence (IJSSCI), 6(2), 78–92. https://doi.org/10.4018/ijssci.2014040105
Torres, E. N., Milman, A., & Park, S. (2017). Delighted or outraged? Uncovering key drivers of exceedingly positive and negative theme park guest experiences. Journal of Hospitality and Tourism Insights, 1(1), 65–85. https://doi.org/10.1108/JHTI-10-2017-0011




![image](https://user-images.githubusercontent.com/79480336/146240787-6f686f06-5e82-4953-bfcf-cd2b4bc3bf78.png)

