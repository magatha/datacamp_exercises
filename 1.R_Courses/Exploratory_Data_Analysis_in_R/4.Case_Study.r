# Spam and num_char
Is there an association between spam and the length of an email? You could imagine a story either way:
Spam is more likely to be a short message tempting me to click on a link, or
My normal email is likely shorter since I exchange brief emails with my friends all the time.
Here, youll use the email dataset to settle that question. Begin by bringing up the help file and learning about all the variables with ?email.
As you explore the association between spam and the length of an email, use this opportunity to try out linking a dplyr chain with the layers in a ggplot2 object.

# Load packages
library("ggplot2")
library(dplyr)
library(openintro)
# Compute summary statistics
email %>%
  group_by(spam) %>%
  summarize( 
    median(num_char),
    IQR(num_char))
# Create plot
email %>%
  mutate(log_num_char = log(num_char)) %>%
  ggplot(aes(x = spam, y = log_num_char)) +
  geom_boxplot()

-----

# Spam and num_char interpretation
Which of the following interpretations of the plot is valid?

# The median length of not-spam emails is greater than that of spam emails.

-----

# Spam and !!!
Lets look at a more obvious indicator of spam: exclamation marks. exclaim_mess contains the number of exclamation marks in each message. Using summary statistics and visualization, see if there is a relationship between this variable and whether or not a message is spam.
Experiment with different types of plots until you find one that is the most informative. Recall that youve seen:
Side-by-side box plots
Faceted histograms
Overlaid density plots

# Compute center and spread for exclaim_mess by spam
email %>%
  group_by(spam) %>%
  summarise(mean(exclaim_mess),
sd(exclaim_mess))

# Create plot for spam and exclaim_mess
ggplot(email, aes(x=log(exclaim_mess + 0.01))) +
geom_histogram() +
facet_wrap(~ spam)

-----

# Spam and !!! interpretation
Which interpretation of these faceted histograms is not correct?

# There are more cases of spam in this dataset than not-spam.

-----

# Collapsing levels
If it was difficult to work with the heavy skew of exclaim_mess, the number of images attached to each email (image) poses even more of a challenge. Run the following code at the console to get a sense of its distribution:
table(email$image)
Recall that this tabulates the number of cases in each category (so there were 3811 emails with 0 images, for example). Given the very low counts at the higher number of images, lets collapse image into a categorical variable that indicates whether or not the email had at least one image. In this exercise, youll create this new variable and explore its association with spam.

# Create plot of proportion of spam by image
email %>%
  mutate(has_image = image > 0) %>%
  ggplot(aes(x = has_image, fill = spam)) +
  geom_bar(position = "fill")

-----

# Image and spam interpretation
Which of the following interpretations of the plot is valid?

# An email without an image is more likely to be not-spam than spam.

-----

# Data Integrity
In the process of exploring a dataset, youll sometimes come across something that will lead you to question how the data were compiled. For example, the variable num_char contains the number of characters in the email, in thousands, so it could take decimal values, but it certainly shouldnt take negative values.
You can formulate a test to ensure this variable is behaving as we expect:
email$num_char < 0
If you run this code at the console, youll get a long vector of logical values indicating for each case in the dataset whether that condition is TRUE. Here, the first 1000 values all appear to be FALSE. To verify that all of the cases indeed have non-negative values for num_char, we can take the sum of this vector:
sum(email$num_char < 0)
This is a handy shortcut. When you do arithmetic on logical values, R treats TRUE as 1 and FALSE as 0. Since the sum over the whole vector is zero, you learn that every case in the dataset took a value of FALSE in the test. That is, the num_char column is behaving as we expect and taking only non-negative values.

# Test if images count as attachments
sum(email$image > email$attach)

-----

# Answering questions with chains
When you have a specific question about a dataset, you can find your way to an answer by carefully constructing the appropriate chain of R code. For example, consider the following question:
"Within non-spam emails, is the typical length of emails shorter for those that were sent to multiple people?"
This can be answered with the following chain:
email %>%
   filter(spam == "not-spam") %>%
   group_by(to_multiple) %>%
   summarize(median(num_char))
The code makes it clear that you are using num_char to measure the length of an email and median() as the measure of what is typical. If you run this code, youll learn that the answer to the question is "yes": the typical length of non-spam sent to multiple people is a bit lower than those sent to only one person.
This chain concluded with summary statistics, but others might end in a plot; it all depends on the question that youre trying to answer.

# Question 1
email %>%
  filter(dollar > 0) %>%
  group_by(spam) %>%
  summarize(median(dollar))

# Question 2
email %>%
  filter(dollar > 10) %>%
  ggplot(aes(x = spam)) +
  geom_bar()

-----

# What's in a number?
Turn your attention to the variable called number. Read more about it by pulling up the help file with ?email.
To explore the association between this variable and spam, select and construct an informative plot. For illustrating relationships between categorical variables, youve seen
Faceted barcharts
Side-by-side barcharts
Stacked and normalized barcharts.
Lets practice constructing a faceted barchart.
                                                               
# Reorder levels
email$number_reordered <- factor(email$number,
                              levels=c("none","small","big"))
# Construct plot of number_reordered
ggplot(email, aes(x=number_reordered)) +
  geom_bar() +
  facet_wrap(~ spam)

-----

# What's in a number interpretation
Which of the following interpretations of the plot is not valid?

# Given that an email contains no number, it is more likely to be spam.

---- 
