#Bar chart expectations
Suppose youve asked 30 people, some young, some old, what their preferred flavor of pie is: apple or pumpkin. That data could be summarized in a side-by-side barchart. Here are three possibilities for how it might look.
Which one of the barcharts shows no relationship between age and flavor? In other words, which shows that pie preference is the same for both young and old?

#Plot 1

-----

# Contingency table review
In this chapter youll continue working with the comics dataset introduced in the video. This is a collection of characteristics on all of the superheroes created by Marvel and DC comics in the last 80 years.
Lets start by creating a contingency table, which is a useful way to represent the total counts of observations that fall into each combination of the levels of categorical variables.

# Print the first rows of the data
comics
# Check levels of align
levels(comics$align)
# Check the levels of gender
levels(comics$gender)
# Create a 2-way contingency table
table(comics$align, comics$gender)

-----

# Dropping levels
The contingency table from the last exercise revealed that there are some levels that have very low counts. To simplify the analysis, it often helps to drop such levels.
In R, this requires two steps: first filtering out any rows with the levels that have very low counts, then removing these levels from the factor variable with droplevels(). This is because the droplevels() function would keep levels that have just 1 or 2 counts; it only drops levels that dont exist in a dataset.

# Load dplyr
library(dplyr)
# Print tab
tab <- table(comics$align, comics$gender)
print(tab)
# Remove align level
comics_filtered <- comics %>%
  filter(align != "Reformed Criminals" ) %>%
  droplevels()
# See the result
comics_filtere

-----

# Side-by-side barcharts
While a contingency table represents the counts numerically, its often more useful to represent them graphically.
Here youll construct two side-by-side barcharts of the comics data. This shows that there can often be two or more options for presenting the same data. Passing the argument position = "dodge" to geom_bar() says that you want a side-by-side (i.e. not stacked) barchart.

# Load ggplot2
library(ggplot2)
# Create side-by-side barchart of gender by alignment
ggplot(comics, aes(x = align, fill = gender)) + 
  geom_bar(position = "dodge")
# Create side-by-side barchart of alignment by gender
ggplot(comics, aes(x = gender, fill = align)) + 
  geom_bar(position = "dodge") +
  theme(axis.text.x = element_text(angle = 90))

-----

# Bar chart interpretation
Which of the following interpretations of the bar charts to your right is not valid?

# Across all genders, "Bad" is the most common alignment.

------

# Conditional proportions
The following code generates tables of joint and conditional proportions, respectively:
tab <- table(comics$align, comics$gender)
options(scipen = 999, digits = 3) # Print fewer digits
prop.table(tab)     # Joint proportions
prop.table(tab, 2)  # Conditional on columns
Go ahead and run it in the console. Approximately what proportion of all female characters are good?

# 51%

-----

# Counts vs. proportions (2)
Bar charts can tell dramatically different stories depending on whether they represent counts or proportions and, if proportions, what the proportions are conditioned on. To demonstrate this difference, youll construct two barcharts in this exercise: one of counts and one of proportions.

# Plot of gender by align
ggplot(comics, aes(x = align, fill = gender)) +
  geom_bar()
# Plot proportion of gender, conditional on align
ggplot(comics, aes(x = align, fill = gender)) + 
  geom_bar(position = "fill") + # bars to fill the entire height of the plotting window, thus displaying proportions and not raw counts.
  ylab("proportion") 

------

# Marginal barchart
If you are interested in the distribution of alignment of all superheroes, it makes sense to construct a barchart for just that single variable.
You can improve the interpretability of the plot, though, by implementing some sensible ordering. Superheroes that are "Neutral" show an alignment between "Good" and "Bad", so it makes sense to put that bar in the middle.

# Change the order of the levels in align
comics$align <- factor(comics$align, 
                       levels = c("Bad", "Neutral", "Good"))
# Create plot of align
ggplot(comics, aes(x = align)) + 
  geom_bar()

-----

# Conditional barchart
Now, if you want to break down the distribution of alignment based on gender, youre looking for conditional distributions.
You could make these by creating multiple filtered datasets (one for each gender) or by faceting the plot of alignment based on gender. As a point of comparison, weve provided your plot of the marginal distribution of alignment from the last exercise.

# Plot of alignment broken down by gender
ggplot(comics, aes(x = align)) + 
  geom_bar() +
  facet_wrap(~ gender)

-----

# Improve piechart
The piechart is a very common way to represent the distribution of a single categorical variable, but they can be more difficult to interpret than barcharts.
This is a piechart of a dataset called pies that contains the favorite pie flavors of 98 people. Improve the representation of these data by constructing a barchart that is ordered in descending order of count.

# Put levels of flavor in descending order
lev <- c("apple", "key lime", "boston creme", "blueberry", "cherry", "pumpkin", "strawberry")
pies$flavor <- factor(pies$flavor, levels = lev)
# Create barchart of flavor
ggplot(pies, aes(x = flavor)) + 
  geom_bar(fill = "chartreuse") + 
  theme(axis.text.x = element_text(angle = 90))

-----
