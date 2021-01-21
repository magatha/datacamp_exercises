# Calculating linkage
Let us revisit the example with three players on a field. The distance matrix between these three players is shown below and is available as the variable dist_players.
From this we can tell that the first group that forms is between players 1 & 2, since they are the closest to one another with a Euclidean distance value of 11.
Now you want to apply the three linkage methods you have learned to determine what the distance of this group is to player 3.
1	2
2	11	
3	16	18

# Extract the pair distances
distance_1_2 <- dist_players[1]
distance_1_3 <- dist_players[2]
distance_2_3 <- dist_players[3]
# Calculate the complete distance between group 1-2 and 3
complete <- max(c(distance_1_3, distance_2_3))
complete
# Calculate the single distance between group 1-2 and 3
single <- min(c(distance_1_3, distance_2_3))
single
# Calculate the average distance between group 1-2 and 3
average <- mean(c(distance_1_3, distance_2_3))
average

------

# Revisited: The closest observation to a pair
You are now ready to answer this question!
Below you see a pre-calculated distance matrix between four players on a soccer field. You can clearly see that players 1 & 4 are the closest to one another with a Euclidean distance value of 10. This distance matrix is available for your exploration as the variable dist_players
1	2	3
2	11.7		
3	16.8	18.0	
4	10.0	20.6	15.8
If 1 and 4 are the closest players among the four, which player is closest to players 1 and 4?

# Complete Linkage: Player 3,
Single & Average Linkage: Player 2

-----

# Assign cluster membership
In this exercise you will leverage the hclust() function to calculate the iterative linkage steps and you will use the cutree() function to extract the cluster assignments for the desired number (k) of clusters.
You are given the positions of 12 players at the start of a 6v6 soccer match. This is stored in the lineup data frame.
You know that this match has two teams (k = 2), lets use the clustering methods you learned to assign which team each player belongs in based on their position.

Notes:
The linkage method can be passed via the method parameter: hclust(distance_matrix, method = "complete")
Remember that in soccer opposing teams start on their half of the field.
Because these positions are measured using the same scale we do not need to re-scale our data.

# Calculate the Distance
dist_players <- dist(lineup)
# Perform the hierarchical clustering using the complete linkage
hc_players <- hclust(dist_players, method = "complete")
# Calculate the assignment vector with a k of 2
clusters_k2 <- cutree(hc_players, k = 2)
# Create a new data frame storing these results
lineup_k2_complete <- mutate(lineup, cluster = clusters_k2)

-----

# Exploring the clusters
Because clustering analysis is always in part qualitative, it is incredibly important to have the necessary tools to explore the results of the clustering.
In this exercise you will explore that data frame you created in the previous exercise lineup_k2_complete.
Reminder: The lineup_k2_complete data frame contains the x & y positions of 12 players at the start of a 6v6 soccer game to which you have added clustering assignments based on the following parameters:
Distance: Euclidean
Number of Clusters (k): 2
Linkage Method: Complete

# Count the cluster assignments
count(lineup_k2_complete, cluster)
# Plot the positions of the players and color them using their cluster
ggplot(lineup_k2_complete, aes(x = x, y = y, color = factor(cluster))) +
  geom_point()

-----

# Validating the clusters
In the plot below you see the clustering results of the same lineup data youve previously worked with but with some minor modifications in the clustering steps.
The left plot was generated using a k=2 and method = 'average'
The right plot was generated using a k=3 and method = 'complete'
If our goal is to correctly assign each player to their correct team then based on what you see in the above plot and what you know about the data set which of the statements below are correct?

# Answers 3 & 4 are both correct.

-----

# Comparing average, single & complete linkage
You are now ready to analyze the clustering results of the lineup dataset using the dendrogram plot. This will give you a new perspective on the effect the decision of the linkage method has on your resulting cluster analysis.

# Prepare the Distance Matrix
dist_players <- dist(lineup)
# Generate hclust for complete, single & average linkage methods
hc_complete <- hclust(dist_players, method = "complete")
hc_single <- hclust(dist_players, method = "single")
hc_average <- hclust(dist_players, method = "average")
# Plot & Label the 3 Dendrograms Side-by-Side
# Hint: To see these Side-by-Side run the 4 lines together as one command
par(mfrow = c(1,3))
plot(hc_complete, main = 'Complete Linkage')
plot(hc_single, main = 'Single Linkage')
plot(hc_average, main = 'Average Linkage')

-----

# Height of the tree
An advantage of working with a clustering method like hierarchical clustering is that you can describe the relationships between your observations based on both the distance metric and the linkage metric selected (the combination of which defines the height of the tree).
Based on the code below what can you concretely say about the height of a branch in the resulting dendrogram?
dist_players <- dist(lineup, method = 'euclidean')
hc_players <- hclust(dist_players, method = 'single')
plot(hc_players)
All of the observations linked by this branch must have:

# a minimum Euclidean distance amongst each other less than or equal to the height of the branch.

-----

# Clusters based on height
In previous exercises you have grouped your observations into clusters using a pre-defined number of clusters (k). In this exercise you will leverage the visual representation of the dendrogram in order to group your observations into clusters using a maximum height (h), below which clusters form.
You will work the color_branches() function from the dendextend library in order to visually inspect the clusters that form at any height along the dendrogram.
The hc_players has been carried over from your previous work with the soccer line-up data.

library(dendextend)
dist_players <- dist(lineup, method = 'euclidean')
hc_players <- hclust(dist_players, method = "complete")
# Create a dendrogram object from the hclust variable
dend_players <- as.dendrogram(hc_players)
# Plot the dendrogram
plot(dend_players)
# Color branches by cluster formed from the cut at a height of 20 & plot
dend_20 <- color_branches(dend_players, h = 20)
# Plot the dendrogram with clusters colored below height 20
plot(dend_20)
# Color branches by cluster formed from the cut at a height of 40 & plot
dend_40 <- color_branches(dend_players, h = 40)
# Plot the dendrogram with clusters colored below height 40
plot(dend_40)

-----

# Exploring the branches cut from the tree
The cutree() function you used in exercises 5 & 6 can also be used to cut a tree at a given height by using the h parameter. Take a moment to explore the clusters you have generated from the previous exercises based on the heights 20 & 40.

dist_players <- dist(lineup, method = 'euclidean')
hc_players <- hclust(dist_players, method = "complete")
# Calculate the assignment vector with a h of 20
clusters_h20 <- cutree(hc_players, h = 20)
# Create a new data frame storing these results
lineup_h20_complete <- mutate(lineup, cluster = clusters_h20)
# Calculate the assignment vector with a h of 40
clusters_h40 <- cutree(hc_players, h = 40)
# Create a new data frame storing these results
lineup_h40_complete <- mutate(lineup, cluster = clusters_h40)
# Plot the positions of the players and color them using their cluster for height = 20
ggplot(lineup_h20_complete, aes(x = x, y = y, color = factor(cluster))) +
  geom_point()
# Plot the positions of the players and color them using their cluster for height = 40
ggplot(lineup_h40_complete, aes(x = x, y = y, color = factor(cluster))) +
  geom_point()

-----

# What do we know about our clusters?
Based on the code below, what can you concretely say about the relationships of the members within each cluster?
dist_players <- dist(lineup, method = 'euclidean')
hc_players <- hclust(dist_players, method = 'complete')
clusters <- cutree(hc_players, h = 40)
Every member belonging to a cluster must have:

# a maximum Euclidean distance to all other members of its cluster that is less than 40.

-----

# Segment wholesale customers
Youre now ready to use hierarchical clustering to perform market segmentation (i.e. use consumer characteristics to group them into subgroups).
In this exercise you are provided with the amount spent by 45 different clients of a wholesale distributor for the food categories of Milk, Grocery & Frozen. This is stored in the data frame customers_spend. Assign these clients into meaningful clusters.
Note: For this exercise you can assume that because the data is all of the same type (amount spent) and you will not need to scale it.

# Calculate Euclidean distance between customers
dist_customers <- dist(customers_spend)
# Generate a complete linkage analysis 
hc_customers <- hclust(dist_customers, method = "complete")
# Plot the dendrogram
plot(hc_customers)
# Create a cluster assignment vector at h = 15000
clust_customers <- cutree(hc_customers, h = 15000)
# Generate the segmented customers data frame
segment_customers <- mutate(customers_spend, cluster = clust_customers)

-----

# Explore wholesale customer clusters
Continuing your work on the wholesale dataset you are now ready to analyze the characteristics of these clusters.
Since you are working with more than 2 dimensions it would be challenging to visualize a scatter plot of the clusters, instead you will rely on summary statistics to explore these clusters. In this exercise you will analyze the mean amount spent in each cluster for all three categories.

dist_customers <- dist(customers_spend)
hc_customers <- hclust(dist_customers)
clust_customers <- cutree(hc_customers, h = 15000)
segment_customers <- mutate(customers_spend, cluster = clust_customers)
# Count the number of customers that fall into each cluster
count(segment_customers, cluster)
# Color the dendrogram based on the height cutoff
dend_customers <- as.dendrogram(hc_customers)
dend_colored <- color_branches(dend_customers, h = 15000)
# Plot the colored dendrogram
plot(dend_colored)
# Calculate the mean for each category
segment_customers %>% 
  group_by(cluster) %>% 
  summarise_all(funs(mean(.)))

------

# Interpreting the wholesale customer clusters
What observations can we make about our segments based on their average spending in each category?

# All of the above.

-----
