# Small-Park
Where are you waiting?
An exploration of amusement park visitor distribution
Sofia Graves

Introduction.
The goal of an amusement park is to get visitors to come back (over and over). This means that visitor satisfaction is very important. In 2017, a study focused on finding the factors that influence a visitors’ satisfaction (and in turn evaluation) of their overall amusement park experience. This was done by analysing the comments left on Trip Advisor for the top 20 North American amusement parks.  They found one of the main causes of outrage to be long wait times (Torres et al., 2017). Crowding is often worse than it has to be because park visitors tend to distribute themselves unevenly and inefficiently (Geissler & Rucks, 2011). Eliminating or even reducing the impacts of large crowds by increasing capacity is not sustainable so amusement parks must look for other strategies to improve visitor distribution. Geissler and Rucks suggest that well timed rewards and incentives could be offered to route visitors to less crowded areas of the park (Geissler & Rucks, 2011). First though, amusement park operators must figure out how their visitors are distributed throughout the park. Amusement parks employ a range of strategies and technologies to track their guests such as wearables (Disney’s magic bands) or the guests’ own smartphones (Augur, 2016). Unfortunately, they do not release these data. This model uses simulated data imitate a small amusement park. This allows researchers to set and experiment with different parameters to track the wait time and movement of the visitors. Their satisfaction with their visit is calculated at the end of the day. 

The main goal of this project is to explore how different visitor distributions affect overall guest satisfaction. A secondary goal is to find a form of distribution that maximizes visitor satisfaction as compared to a random distribution (and look for similarities). In the future, this research could be used to create route-planning algorithms and incentives programs. These will allow amusement park operators to better distribute their visitors keeping in mind real-time wait times, reservation facilities and fast passes as well as the different kinds of rides (Brown et al., 2013; Ohwada et al., 2014). Better distribution can have a huge impact in visitor satisfaction and therefore repeat visits fulfilling the amusement park goals. 

Methods.
This model aims to imitate an amusement park which, at its simplest, includes 3 rides (coolest, okayest and lamest), has a park capacity of 12 visitors and a ride capacity (number of people that can go on a ride in one time step) of 3. At the beginning of a cycle (every 10 time steps), each visitor is randomly assigned to one of the 3 rides (in the future bias will be added to this assignment) using the function f.ride_picker (built up from the sample function) and given a spot in line using the function f.get_spot_in_line (which is a loop that counts how many visitors are in line for each ride and sorts them in sets of 3). A visitor’s status is based on a combination of the last 2 variables and is generated using the function f.get_status. How it works is the spots in line repeat 3 (ride capacity) times (meaning the line looks something like 1, 1, 1, 2, 2, 2, 3…), and so the first 3 visitors of each ride get the status of riding (r). The visitors in a spot larger than 1 get the status of waiting (w). There are a total of 6 states a visitor can be in: r_coolest, r_okayest, r_lamest, w_coolest, w_okayest and w_lamest.  All the observations for the variables described above are kept in a data frame.

The main data frame used in this model is called visitor_tracker because, well, it tracks the park’s visitors at all times. It is made up of the variables time_step, visitor, ride, spot_in_line and status. This data frame is updated in 7 steps the end of each time step:
1) A riding_visitors data frame is created to contain all the visitors whose status starts with “r”.
2) A new ride is assigned to the visitors in riding_visitors using the random sample function.
3) A waiting_visitors data frame is created to contain all the visitors whose status starts with “w”.
4) The visitors in waiting_visitors are moved up one step in line by subtracting 1 from their spot_in_line. 
5) The riding_visitors and waiting_visitors data frames are merged (using the rbind function and keeping the waiting_visitors on the top rows) to create visitor_tracker_merged.
6) Spots in line are given to the visitors in the bottom rows of visitor_tracker_merged. 
7) All the visitors’ statuses are updated (adjusted to accommodate for their new ride and spot in line).

## this is as far as I am as of Friday morning but in my final draft I will talk about the loop that I will have created so that a cycle can be run with just 2 functions (f.initializer and f.next_step) and how visitor satisfaction will be calculated.

Results.
## I don’t have any results yet but they will be discussed here when I do and I will also have figures. 

Discussion.
Some of the assumptions this model makes include: a) all visitors arrive at the same time, b) visitors teleport from one ride to the next (they don’t spend time walking), c) visitors don’t take any sort of breaks between rides (in other words, visitors are waiting in line at all times) and d) a visitor can only be in one ride at a time.
For now, all ride capacities are the same, rides are chosen randomly and there are no fast passes in the park. Future research could expand this model by changing ride capacities (and therefore speed at which different lines move). Also choosing rides at random is not very realistic. Future models could account for this by biasing the rides chosen by adding the “prob =” section to the sample function used to assign rides to visitors. The probability a ride is assigned to a visitor (or chosen by the visitor) could be based on how cool the ride is (it’s cool points) or maybe how long the line is (1/length of line). 
Although I’ve had a lot of fun and enjoyed the challenge, this project has been much more difficult than I imaged. Creating a model from scratch involves a lot more planning than I had expected. Building the functions was not difficult, making them work was the hard part, but once I figured out all I was missing was the return function everything went smoothly.
## Now going back to try and figure out how to create a single function that will run a full cycle and still keep track of the visitors at each time step is definitely going to be a fun challenge for the weekend. 
Sources.
Augur, H. (2016, June 9). Three Times Big Data Made Amusement Parks Better—Dataconomy. https://dataconomy.com/2016/06/three-times-big-data-made-amusement-parks-better/
Brown, A., Kappes, J., & Marks, J. (2013). Mitigating Theme Park Crowding with Incentives and Information on Mobile Devices. Journal of Travel Research, 52(4), 426–436. https://doi.org/10.1177/0047287512475216
Geissler, G. L., & Rucks, C. T. (2011). The overall theme park experience: A visitor satisfaction tracking study. Journal of Vacation Marketing, 17(2), 127–138. https://doi.org/10.1177/1356766710392480
Ohwada, H., Okada, M., & Kanamori, K. (2014). Route-Planning Algorithms for Amusement-Park Navigation. International Journal of Software Science and Computational Intelligence (IJSSCI), 6(2), 78–92. https://doi.org/10.4018/ijssci.2014040105
Torres, E. N., Milman, A., & Park, S. (2017). Delighted or outraged? Uncovering key drivers of exceedingly positive and negative theme park guest experiences. Journal of Hospitality and Tourism Insights, 1(1), 65–85. https://doi.org/10.1108/JHTI-10-2017-0011




![image](https://user-images.githubusercontent.com/79480336/145656525-aa2d62d7-e4f3-4b83-a6f3-5bf9f7d6aa1f.png)
