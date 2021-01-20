# Choice of center measure
The choice of measure for center can have a dramatic impact on what we consider to be a typical observation, so it is important that you consider the shape of the distribution before deciding on the measure.
Which set of measures of central tendency would be worst for describing the two distributions shown here?

# A: mean, B: mode

-----

# Calculate center measures
Throughout this chapter, you will use data from gapminder, which tracks demographic data in countries of the world over time. To learn more about it, you can bring up the help file with ?gapminder.
For this exercise, focus on how the life expectancy differs from continent to continent. This requires that you conduct your analysis not at the country level, but aggregated up to the continent level. This is made possible by the one-two punch of group_by() and summarize(), a very powerful syntax for carrying out the same analysis on different subsets of the full dataset.

# Create dataset of 2007 data
gap2007 <- filter(gapminder, year == '2007')
# Compute groupwise mean and median lifeExp
gap2007 %>%
  group_by(continent) %>%
  summarize(mean(lifeExp),
            median(lifeExp))
# Generate box plots of lifeExp for each continent
gap2007 %>%
  ggplot(aes(x = continent, y = lifeExp)) +
  geom_boxplot()

-----

# Choice of spread measure
The choice of measure for spread can dramatically impact how variable we consider our data to be, so it is important that you consider the shape of the distribution before deciding on the measure.
Which set of measures of spread would be worst for describing the two distributions shown here?

# A: Variance, B: Range

----

# Calculate spread measures
Lets extend the powerful group_by() and summarize() syntax to measures of spread. If you're unsure whether you're working with symmetric or skewed distributions, its a good idea to consider a robust measure like IQR in addition to the usual measures of variance or standard deviation.

# Compute groupwise measures of spread
gap2007 %>%
  group_by(continent) %>%
  summarize(sd(lifeExp),
            IQR(lifeExp),
            n())
# Generate overlaid density plots
gap2007 %>%
  ggplot(aes(x = lifeExp, fill = continent)) +
  geom_density(alpha = 0.3)

-----

# Choose measures for center and spread
Consider the density plots shown here. What are the most appropriate measures to describe their centers and spreads? In this exercise, youll select the measures and then calculate them.

# Compute stats for lifeExp in Americas
gap2007 %>%
  filter(continent == "Americas") %>%
  summarize(mean(lifeExp), sd(lifeExp))
# Compute stats for population
gap2007 %>%
  summarize(median(pop), IQR(pop))

-----

# Describe the shape
To build some familiarity with distributions of different shapes, consider the four that are plotted here. Which of the following options does the best job of describing their shape in terms of modality and skew/symmetry?

# A: unimodal left-skewed; B: unimodal symmetric; C: unimodal right-skewed, D: bimodal symmetric.

-----

# Transformations
Highly skewed distributions can make it very difficult to learn anything from a visualization. Transformations can be helpful in revealing the more subtle structure.
Here youll focus on the population variable, which exhibits strong right skew, and transform it with the natural logarithm function (log() in R).

# Create density plot of old variable
gap2007 %>%
  ggplot(aes(x = pop)) +
  geom_density()
# Transform the skewed pop variable
gap2007 <- gap2007 %>%
  mutate(log_pop = log(pop))
# Create density plot of new variable
gap2007 %>%
  ggplot(aes(x = log_pop)) +
  geom_density()

-----

# Identify outliers
Consider the distribution, shown here, of the life expectancies of the countries in Asia. The box plot identifies one clear outlier: a country with a notably low life expectancy. Do you have a guess as to which country this might be? Test your guess in the console using either min() or filter(), then proceed to building a plot with that country removed.

# Filter for Asia, add column indicating outliers
gap_asia <- gap2007 %>%
  filter(continent == "Asia") %>%
  mutate(is_outlier = (lifeExp < 50))
# Remove outliers, create box plot of lifeExp
gap_asia %>%
  filter(!is_outlier) %>%
  ggplot(aes(x = 1, y = lifeExp)) +
  geom_boxplot()

-----
