# Understanding correlation scale
In a scientific paper, three correlations are reported with the following values:
-0.395
1.827
0.738
Choose the correct interpretation of these findings.

# (2) is invalid

-----

# Understanding correlation sign
In a scientific paper, three correlations are reported with the following values:
0.582
0.134
-0.795
Which of these values represents the strongest correlation?

# -0.795

-----

# Computing correlation
The cor(x, y) function will compute the Pearson product-moment correlation between variables, x and y. Since this quantity is symmetric with respect to x and y, it doesnt matter in which order you put the variables.
At the same time, the cor() function is very conservative when it encounters missing data (e.g. NAs). The use argument allows you to override the default behavior of returning NA whenever any of the values encountered is NA. Setting the use argument to "pairwise.complete.obs" allows cor() to compute the correlation coefficient for those observations where the values of x and y are both not missing.

# Compute correlation
ncbirths %>%
  summarize(N = n(), r = cor(mage, weight))
# Compute correlation for all non-missing pairs
ncbirths %>%
  summarize(N = n(), r = cor(weeks, weight, use = "pairwise.complete.obs"))

-----

# Exploring Anscombe
In 1973, Francis Anscombe famously created four datasets with remarkably similar numerical properties, but obviously different graphic relationships. The Anscombe dataset contains the x and y coordinates for these four datasets, along with a grouping variable, set, that distinguishes the quartet.
It may be helpful to remind yourself of the graphic relationship by viewing the four scatterplots:
ggplot(data = Anscombe, aes(x = x, y = y)) +
  geom_point() +
  facet_wrap(~ set)

# Compute properties of Anscombe
Anscombe %>%
  group_by(set) %>%
  summarize(
    N = n(),
    mean_of_x = mean(x), 
    std_dev_of_x = sd(x), 
    mean_of_y = mean(y), 
    std_dev_of_y = sd(y), 
    correlation_between_x_and_y = cor(x, y)
  )

-----

# Perception of correlation
Recall the scatterplot between the poverty rate of counties in the United States and the high school graduation rate in those counties from the previous chapter. Which of the following values is the correct correlation between poverty rate and high school graduation rate?

# -0.681

-----

# Perception of correlation (2)
Estimating the value of the correlation coefficient between two quantities from their scatterplot can be tricky. Statisticians have shown that peoples perception of the strength of these relationships can be influenced by design choices like the x and y scales.
Nevertheless, with some practice your perception of correlation will improve. Toggle through the four scatterplots in the plotting window, each of which youve seen in a previous exercise. Jot down your best estimate of the value of the correlation coefficient between each pair of variables. Then, compare these values to the actual values you compute in this exercise.
If youre having trouble recalling variable names, it may help to preview a dataset in the console with str() or glimpse().

# Run this and look at the plot
ggplot(data = mlbBat10, aes(x = OBP, y = SLG)) +
  geom_point()
# Correlation for all baseball players
mlbBat10 %>%
  summarize(N = n(), r = cor(OBP, SLG))

# Run this and look at the plot
mlbBat10 %>% 
  filter(AB > 200) %>%
  ggplot(aes(x = OBP, y = SLG)) + 
  geom_point()
# Correlation for all players with at least 200 ABs
mlbBat10 %>%
  filter(AB >= 200) %>%
  summarize(N = n(), r = cor(OBP, SLG))

# Run this and look at the plot
ggplot(data = bdims, aes(x = hgt, y = wgt, color = factor(sex))) +
  geom_point() 
# Correlation of body dimensions
bdims %>%
  group_by(sex) %>%
  summarize(N = n(), r = cor(hgt, wgt))

# Run this and look at the plot
ggplot(data = mammals, aes(x = BodyWt, y = BrainWt)) +
  geom_point() + scale_x_log10() + scale_y_log10()
# Correlation among mammals, with and without log
mammals %>%
  summarize(N = n(), 
            r = cor(BodyWt, BrainWt), 
            r_log = cor(log(BodyWt), log(BrainWt)))

-----

# Interpreting correlation in context
Recall that you previously determined the value of the correlation coefficient between the poverty rate of counties in the United States and the high school graduation rate in those counties was -0.681. Choose the correct interpretation of this value.

# Counties with lower high school graduation rates are likely to have higher poverty rates.

-----

# Correlation and causation
In the San Francisco Bay Area from 1960-1967, the correlation between the birthweight of 1,236 babies and the length of their gestational period was 0.408. Which of the following conclusions is not a valid statistical interpretation of these results.

# Staying in the womb longer causes babies to be heavier when they are born.

-----

# Spurious correlation in random data
Statisticians must always be skeptical of potentially spurious correlations. Human beings are very good at seeing patterns in data, sometimes when the patterns themselves are actually just random noise. To illustrate how easy it can be to fall into this trap, we will look for patterns in truly random data.
The noise dataset contains 20 sets of x and y variables drawn at random from a standard normal distribution. Each set, denoted as z, has 50 observations of x, y pairs. Do you see any pairs of variables that might be meaningfully correlated? Are all of the correlation coefficients close to zero?

# Create faceted scatterplot
ggplot(noise, aes(x, y)) + 
  geom_point() + 
  facet_wrap(~ z)
# Compute correlations for each dataset
noise_summary <- noise %>%
  group_by(z) %>%
  summarize(N = n(), spurious_cor = cor(x, y))
# Isolate sets with correlations above 0.2 in absolute strength
noise_summary %>%
  filter(abs(spurious_cor) > 0.2)

-----
