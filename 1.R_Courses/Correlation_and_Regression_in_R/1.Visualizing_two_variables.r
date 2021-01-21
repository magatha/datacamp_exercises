# Scatterplots
Scatterplots are the most common and effective tools for visualizing the relationship between two numeric variables.
The ncbirths dataset is a random sample of 1,000 cases taken from a larger dataset collected in 2004. Each case describes the birth of a single child born in North Carolina, along with various characteristics of the child (e.g. birth weight, length of gestation, etc.), the childs mother (e.g. age, weight gained during pregnancy, smoking habits, etc.) and the childs father (e.g. age). You can view the help file for these data by running ?ncbirths in the console.

# Scatterplot of weight vs. weeks
ggplot(ncbirths, aes(x = weeks, y = weight)) + 
  geom_point()

------

# Boxplots as discretized/conditioned scatterplots
If it is helpful, you can think of boxplots as scatterplots for which the variable on the x-axis has been discretized.
The cut() function takes two arguments: the continuous variable you want to discretize and the number of breaks that you want to make in that continuous variable in order to discretize it.

# Boxplot of weight vs. weeks
ggplot(data = ncbirths, 
       aes(x = cut(weeks, breaks = 5), y = weight)) + 
  geom_boxplot()

-----

# Creating scatterplots
Creating scatterplots is simple and they are so useful that it is worthwhile to expose yourself to many examples. Over time, you will gain familiarity with the types of patterns that you see. You will begin to recognize how scatterplots can reveal the nature of the relationship between two variables.
In this exercise, and throughout this chapter, we will be using several datasets listed below. These data are available through the openintro package. Briefly:
The mammals dataset contains information about 39 different species of mammals, including their body weight, brain weight, gestation time, and a few other variables.
The mlbBat10 dataset contains batting statistics for 1,199 Major League Baseball players during the 2010 season.
The bdims dataset contains body girth and skeletal diameter measurements for 507 physically active individuals.
The smoking dataset contains information on the smoking habits of 1,691 citizens of the United Kingdom.
To see more thorough documentation, use the ? or help() functions.

# Mammals scatterplot
ggplot(mammals, aes(x = BodyWt, y = BrainWt )) + 
  geom_point()

# Baseball player scatterplot
ggplot(mlbBat10, aes(x = OBP, y = SLG)) + 
  geom_point()

# Body dimensions scatterplot
ggplot(bdims, aes(x = hgt, y = wgt, color = factor(sex))) + 
  geom_point()

# Smoking scatterplot
ggplot(smoking, aes(x = age, y = amtWeekdays)) + 
  geom_point()

-----

# Characterizing scatterplots
This scatterplot shows the relationship between the poverty rates and high school graduation rates of counties in the United States.
Describe the form, direction, and strength of this relationship.

# Linear, negative, moderately strong

-------

# Transformations
The relationship between two variables may not be linear. In these cases we can sometimes see strange and even inscrutable patterns in a scatterplot of the data. Sometimes there really is no meaningful relationship between the two variables. Other times, a careful transformation of one or both of the variables can reveal a clear relationship.
Recall the bizarre pattern that you saw in the scatterplot between brain weight and body weight among mammals in a previous exercise. Can we use transformations to clarify this relationship?
ggplot2 provides several different mechanisms for viewing transformed relationships. The coord_trans() function transforms the coordinates of the plot. Alternatively, the scale_x_log10() and scale_y_log10() functions perform a base-10 log transformation of each axis. Note the differences in the appearance of the axes.
The mammals dataset is available in your workspace.

# Scatterplot with coord_trans()
ggplot(data = mammals, aes(x = BodyWt, y = BrainWt)) +
  geom_point() + 
  coord_trans(x = "log10", y = "log10")

# Scatterplot with scale_x_log10() and scale_y_log10()
ggplot(data = mammals, aes(x = BodyWt, y = BrainWt)) +
  geom_point() +
  scale_x_log10() + 
  scale_y_log10()

-----

# Identifying outliers
In Chapter 5, we will discuss how outliers can affect the results of a linear regression model and how we can deal with them. For now, it is enough to simply identify them and note how the relationship between two variables may change as a result of removing outliers.
Recall that in the baseball example earlier in the chapter, most of the points were clustered in the lower left corner of the plot, making it difficult to see the general pattern of the majority of the data. This difficulty was caused by a few outlying players whose on-base percentages (OBPs) were exceptionally high. These values are present in our dataset only because these players had very few batting opportunities.
Both OBP and SLG are known as rate statistics, since they measure the frequency of certain events (as opposed to their count). In order to compare these rates sensibly, it makes sense to include only players with a reasonable number of opportunities, so that these observed rates have the chance to approach their long-run frequencies.
In Major League Baseball, batters qualify for the batting title only if they have 3.1 plate appearances per game. This translates into roughly 502 plate appearances in a 162-game season. The mlbBat10 dataset does not include plate appearances as a variable, but we can use at-bats (AB) -- which constitute a subset of plate appearances -- as a proxy.

# Filter for AB greater than or equal to 200
ab_gt_200 <- mlbBat10 %>%
  filter(AB >= 200) 

# Scatterplot of SLG vs. OBP
ggplot(ab_gt_200, aes(x = OBP, y = SLG)) +
  geom_point()

# Identify the outlying player
ab_gt_200 %>%
  filter(    AB >= 200, 
             OBP < 0.200)

-----
