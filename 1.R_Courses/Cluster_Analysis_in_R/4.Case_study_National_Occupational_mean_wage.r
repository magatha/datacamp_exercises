# Initial exploration of the data
You are presented with data from the Occupational Employment Statistics (OES) program which produces employment and wage estimates annually. This data contains the yearly average income from 2001 to 2016 for 22 occupation groups. You would like to use this data to identify clusters of occupations that maintained similar income trends.
The data is stored in your environment as the data.matrix oes.
Before you begin to cluster this data you should determine whether any pre-processing steps (such as scaling and imputation) are necessary.
Leverage the functions head() and summary() to explore the oes data in order to determine which of the pre-processing steps below are necessary:

# None of these pre-processing steps are necessary for this data.

-----

# Hierarchical clustering: Occupation trees
In the previous exercise you have learned that the oes data is ready for hierarchical clustering without any preprocessing steps necessary. In this exercise you will take the necessary steps to build a dendrogram of occupations based on their yearly average salaries and propose clusters using a height of 100,000.

# Calculate Euclidean distance between the occupations
dist_oes <- dist(oes, method = "euclidean")
# Generate an average linkage analysis 
hc_oes <- hclust(dist_oes, method = "average")
# Create a dendrogram object from the hclust variable
dend_oes <- as.dendrogram(hc_oes)
# Plot the dendrogram
plot(dend_oes)
# Color branches by cluster formed from the cut at a height of 100000
dend_colored <- color_branches(dend_oes, h = 100000)
# Plot the colored dendrogram
plot(dend_oes)

-----

# Hierarchical clustering: Preparing for exploration
You have now created a potential clustering for the oes data, before you can explore these clusters with ggplot2 you will need to process the oes data matrix into a tidy data frame with each occupation assigned its cluster.

dist_oes <- dist(oes, method = 'euclidean')
hc_oes <- hclust(dist_oes, method = 'average')

library(tibble)
library(tidyr)
# Use rownames_to_column to move the rownames into a column of the data frame
df_oes <- rownames_to_column(as.data.frame(oes), var = 'occupation')
# Create a cluster assignment vector at h = 100,000
cut_oes <- cutree(hc_oes, h = 100000)
# Generate the segmented the oes data frame
clust_oes <- mutate(df_oes, cluster = cut_oes)
# Create a tidy data frame by gathering the year and values into two columns
gathered_oes <- gather(data = clust_oes, 
                       key = year, 
                       value = mean_salary, 
                       -occupation, -cluster)

----

# Hierarchical clustering: Plotting occupational clusters
You have succesfully created all the parts necessary to explore the results of this hierarchical clustering work. In this exercise you will leverage the named assignment vector cut_oes and the tidy data frame gathered_oes to analyze the resulting clusters.

# View the clustering assignments by sorting the cluster assignment vector
sort(cut_oes)
# Plot the relationship between mean_salary and year and color the lines by the assigned cluster
ggplot(gathered_oes, aes(x = year, y = mean_salary, color = factor(cluster))) + 
    geom_line(aes(group = occupation))

-----

# K-means: Elbow analysis
In the previous exercises you used the dendrogram to propose a clustering that generated 3 trees. In this exercise you will leverage the k-means elbow plot to propose the "best" number of clusters.

# Use map_dbl to run many models with varying value of k (centers)
tot_withinss <- map_dbl(1:10,  function(k){
  model <- kmeans(x = oes, centers = k)
  model$tot.withinss
})
# Generate a data frame containing both k and tot_withinss
elbow_df <- data.frame(
  k = 1:10,
  tot_withinss = tot_withinss
)
# Plot the elbow plot
ggplot(elbow_df, aes(x = k, y = tot_withinss)) +
  geom_line() +
  scale_x_continuous(breaks = 1:10)

-----

# K-means: Average Silhouette Widths
So hierarchical clustering resulting in 3 clusters and the elbow method suggests 2. In this exercise use average silhouette widths to explore what the "best" value of k should be.

# Use map_dbl to run many models with varying value of k
sil_width <- map_dbl(2:10,  function(k){
  model <- pam(oes, k = k)
  model$silinfo$avg.width
})
# Generate a data frame containing both k and sil_width
sil_df <- data.frame(
  k = 2:10,
  sil_width = sil_width
)
# Plot the relationship between k and sil_width
ggplot(sil_df, aes(x = k, y = sil_width)) +
  geom_line() +
  scale_x_continuous(breaks = 2:10)

-----

# The "best" number of clusters
You ran three different methods for finding the optimal number of clusters and their assignments and you arrived with three different answers.
Below you will find a comparison between the 3 clustering results (via coloring of the occupations based on the clusters to which they belong).
What can you say about the "best" way to cluster this data?

# All of the above are correct but the best way to cluster is highly dependent on how you would use this data after.

-----
