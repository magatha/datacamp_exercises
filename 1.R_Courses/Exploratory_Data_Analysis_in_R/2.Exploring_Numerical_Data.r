
# Faceted histogram
In this chapter, youll be working with the cars dataset, which records characteristics on all of the new models of cars for sale in the US in a certain year. You will investigate the distribution of mileage across a categorial variable, but before you get there, youll want to familiarize yourself with the dataset.

# Load package
library(ggplot2)
# Learn data structure
str(cars)
# Create faceted histogram
ggplot(cars, aes(x = city_mpg)) +
  geom_histogram() +
  facet_wrap(~ suv) 

-----

# Boxplots and density plots
The mileage of a car tends to be associated with the size of its engine (as measured by the number of cylinders). To explore the relationship between these two variables, you could stick to using histograms, but in this exercise youll try your hand at two alternatives: the box plot and the density plot.

# Filter cars with 4, 6, 8 cylinders
common_cyl <- filter(cars, ncyl %in% c(4, 6, 8))
# Create box plots of city mpg by ncyl
ggplot(data = common_cyl, aes(x = as.factor(ncyl), y = city_mpg)) + geom_boxplot()
# Create overlaid density plots for same data
ggplot(common_cyl, aes(x = city_mpg, fill = as.factor(ncyl))) +
  geom_density(alpha = .3)

-----

# Compare distribution via plots
Which of the following interpretations of the plot is not valid?

# The variability in mileage of 8 cylinder cars is similar to the variability in mileage of 4 cylinder cars.

-----

# Marginal and conditional histograms
Now, turn your attention to a new variable: horsepwr. The goal is to get a sense of the marginal distribution of this variable and then compare it to the distribution of horsepower conditional on the price of the car being less than $25,000.
Youll be making two plots using the "data pipeline" paradigm, where you start with the raw data and end with the plot.

# Create hist of horsepwr
cars %>%
  ggplot(aes(horsepwr)) +
  geom_histogram() +
  ggtitle("Horsepower Distribution")
# Create hist of horsepwr for affordable cars
cars %>% 
  filter(msrp < 25000) %>%
  ggplot(aes(horsepwr)) +
  geom_histogram() +
  xlim(c(90, 550)) +
  ggtitle("Horsepower distribtion for msrp < 25000")

-----

# Marginal and conditional histograms interpretation
Observe the two histograms in the plotting window and decide which of the following is a valid interpretation.

# The highest horsepower car in the less expensive range has just under 250 horsepower.

-----

# Three binwidths
Before you take these plots for granted, its a good idea to see how things change when you alter the binwidth. The binwidth determines how smooth your distribution will appear: the smaller the binwidth, the more jagged your distribution becomes. Its good practice to consider several binwidths in order to detect different types of structure in your data.

# Create hist of horsepwr with binwidth of 3
cars %>%
  ggplot(aes(horsepwr)) +
  geom_histogram(binwidth = 3) +
  ggtitle("Horse Power - Binwidth 3")
# Create hist of horsepwr with binwidth of 30
cars %>%
  ggplot(aes(horsepwr)) +
  geom_histogram(binwidth = 30) +
  ggtitle("Horse Power - Binwidth 30")
# Create hist of horsepwr with binwidth of 60
cars %>% 
  ggplot(aes(horsepwr)) +
  geom_histogram(binwidth = 60) +
  ggtitle("Horse Power - Binwidth 30")

-----

# Three binwidths interpretation
What feature is present in Plot A thats not found in B or C?

# There is a tendency for cars to have horsepower right at 200 or 300 horsepower.

-----

# Box plots for outliers
In addition to indicating the center and spread of a distribution, a box plot provides a graphical means to detect outliers. You can apply this method to the msrp column (manufacturers suggested retail price) to detect if there are unusually expensive or cheap cars.

# Construct box plot of msrp
cars %>%
  ggplot(aes(x = 1, y = msrp)) +
  geom_boxplot()
# Exclude outliers from data
cars_no_out <- cars %>%
  filter(msrp < 100000)
# Construct box plot of msrp using the reduced dataset
cars_no_out %>%
  ggplot(aes(x = 1, y = msrp)) +
  geom_boxplot()

-----

# Plot selection
Consider two other columns in the cars dataset: city_mpg and width. Which is the most appropriate plot for displaying the important features of their distributions? Remember, both density plots and box plots display the central tendency and spread of the data, but the box plot is more robust to outliers.

# Create plot of city_mpg
cars %>%
  ggplot(aes(x = 1, y = city_mpg)) +
  geom_boxplot()
# Create plot of width
cars %>% 
  ggplot(aes(x = width)) +
  geom_density()

-----

# 3 variable plot
Faceting is a valuable technique for looking at several conditional distributions at the same time. If the faceted distributions are laid out in a grid, you can consider the association between a variable and two others, one on the rows of the grid and the other on the columns.

# Facet hists using hwy mileage and ncyl
common_cyl %>%
  ggplot(aes(x = hwy_mpg)) +
  geom_histogram() +
  facet_grid(ncyl ~ suv) +
  ggtitle("Hwy_mpg by ncyl - suv")

-----

# Interpret 3 var plot
Which of the following interpretations of the plot is valid?

# Across both SUVs and non-SUVs, mileage tends to decrease as the number of cylinders increases.

-----
