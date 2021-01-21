# When to cluster?
In which of these scenarios would clustering methods likely be appropriate?
1) Using consumer behavior data to identify distinct segments within a market.
2) Predicting whether a given user will click on an ad.
3) Identifying distinct groups of stocks that follow similar trading patterns.
4) Modeling & predicting GDP growth.

# 1 & 3

-----

# Calculate & plot the distance between two players
Youve obtained the coordinates relative to the center of the field for two players in a soccer match and would like to calculate the distance between them.
In this exercise you will plot the positions of the 2 players and manually calculate the distance between them by using the Euclidean distance formula.

# Plot the positions of the players
ggplot(two_players, aes(x = x, y = y)) + 
  geom_point() +
  # Assuming a 40x60 field
  lims(x = c(-30,30), y = c(-20, 20))
# Split the players data frame into two observations
player1 <- two_players[1, ]
player2 <- two_players[2, ]
# Calculate and print their distance using the Euclidean Distance formula
player_distance <- sqrt( (player1$x - player2$x)^2 + (player1$y - player2$y)^2 )
player_distance

-----

# Using the dist() function
Using the Euclidean formula manually may be practical for 2 observations but can get more complicated rather quickly when measuring the distance between many observations.
The dist() function simplifies this process by calculating distances between our observations (rows) using their features (columns). In this case the observations are the player positions and the dimensions are their x and y coordinates.
Note: The default distance calculation for the dist() function is Euclidean distance

# Calculate the Distance Between two_players
dist_two_players <- dist(two_players)
dist_two_players
# Calculate the Distance Between three_players
dist_three_players <- dist(three_players)
dist_three_players

-----

# Who are the closest players?
You are given the data frame containing the positions of 4 players on a soccer field.
This data is preloaded as four_players in your environment and is displayed below.
Player	x	y
1	5	4
2	15	10
3	0	20
4	-5	5
Work in the R console to answer the following question:
Which two players are closest to one another?

# 1 & 4

-----

# Effects of scale
You have learned that when a variable is on a larger scale than other variables in your data it may disproportionately influence the resulting distance calculated between your observations. Lets see this in action by observing a sample of data from the trees data set.
You will leverage the scale() function which by default centers & scales our column features.
Our variables are the following:
Girth - tree diameter in inches
Height - tree height in inches

# Calculate distance for three_trees 
dist_trees <- dist(three_trees)
# Scale three trees & calculate the distance  
scaled_three_trees <- scale(three_trees)
dist_scaled_trees <- dist(scaled_three_trees)
# Output the results of both Matrices
print('Without Scaling')
dist_trees
print('With Scaling')
dist_scaled_trees

-----

# When to scale data?
Below are examples of datasets and their corresponding features.
In which of these examples would scaling not be necessary?

# None of the above, they all should be scaled when measuring distance.

-----

# Calculating distance between categorical variables
In this exercise you will explore how to calculate binary (Jaccard) distances. In order to calculate distances we will first have to dummify our categories using the dummy.data.frame() from the library dummies
You will use a small collection of survey observations stored in the data frame job_survey with the following columns:
job_satisfaction Possible options: "Hi", "Mid", "Low"
is_happy Possible options: "Yes", "No"

# Dummify the Survey Data
dummy_survey <- dummy.data.frame(job_survey)
# Calculate the Distance
dist_survey <- dist(dummy_survey, method = "binary")
# Print the Original Data
job_survey
# Print the Distance Matrix
dist_survey

-----

# The closest observation to a pair
Below you see a pre-calculated distance matrix between four players on a soccer field. You can clearly see that players 1 & 4 are the closest to one another with a Euclidean distance value of 10.
1	2	3
2	11.7		
3	16.8	18.0	
4	10.0	20.6	15.8
If 1 and 4 are the closest players among the four, which player is closest to players 1 and 4?

# Are you kidding me? There isn't enough information to decide.

-----
