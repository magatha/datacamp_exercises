# Fitting a line to a binary response
When our response variable is binary, a regression model has several limitations. Among the more obvious—and logically incongruous—is that the regression line extends infinitely in either direction. This means that even though our response variable  only takes on the values 0 and 1, our fitted values can range anywhere from -\infty to infty. This doesnt make sense.
To see this in action, well fit a linear regression model to data about 55 students who applied to medical school. We want to understand how their undergraduate  relates to the probability they will be accepted by a particular school .

# scatterplot with jitter
data_space <- ggplot(MedGPA, aes(x = GPA, y = Acceptance)) + 
  geom_jitter(width = 0, height = 0.05, alpha = 0.5)
# linear regression line
data_space + 
  geom_smooth(method = "lm", se = FALSE)

-----

# Fitting a line to a binary response (2)
In the previous exercise, we identified a major limitation to fitting a linear regression model when we have a binary response variable. However, it is not always inappropriate to do so. Note that our regression line only makes illogical predictions (i.e. \hat{y} \lt 0 or \hat{y} \gt 1) for students with very high or very low GPAs. For GPAs closer to average, the predictions seem fine.
Moreover, the alternative logistic regression model — which we will fit next — is very similar to the linear regression model for observations near the average of the explanatory variable. It just so happens that the logistic curve is very straight near its middle. Thus, in these cases a linear regression model may still be acceptable, even for a binary response.

# filter
MedGPA_middle <- filter(MedGPA, GPA <= 3.77, GPA >= 3.375)
# scatterplot with jitter
data_space <- ggplot(MedGPA_middle, aes(x = GPA, y = Acceptance)) + 
  geom_jitter(width = 0, height = 0.05, alpha = 0.5)
# linear regression line
data_space + 
  geom_smooth(method = "lm", se = FALSE)

-----

# Fitting a model
Logistic regression is a special case of a broader class of generalized linear models, often known as GLMs. Specifying a logistic regression model is very similar to specify a regression model, with two important differences:
We use the glm() function instead of lm()
We specify the family argument and set it to binomial. This tells the GLM function that we want to fit a logistic regression model to our binary response. [The terminology stems from the assumption that our binary response follows a binomial distribution.]
We still use the formula and data arguments with glm().
Note that the mathematical model is now:
     \log{ \left( \frac{y}{1-y} \right) } = \beta_0 + \beta_1 \cdot x + \epsilon \,,
where  is the error term.

# fit model
glm(Acceptance ~ GPA, data = MedGPA, family = binomial)

-----

# Using geom_smooth()
Our logistic regression model can be visualized in the data space by overlaying the appropriate logistic curve. We can use the geom_smooth() function to do this. Recall that geom_smooth() takes a method argument that allows you to specify what type of smoother you want to see. In our case, we need to specify that we want to use the glm() function to do the smoothing.
However we also need to tell the glm() function which member of the GLM family we want to use. To do this, we will pass the family argument to glm() as a list using the method.args argument to geom_smooth(). This mechanism is common in R, and allows one function to pass a list of arguments to another function.

# scatterplot with jitter
data_space <- ggplot(MedGPA, aes(x = GPA, y = Acceptance)) + 
  geom_jitter(width = 0, height = 0.05, alpha = .5)
# add logistic curve
data_space +
  geom_smooth(method = "glm", method.args = list(family = "binomial"), se = FALSE)

-----

# Using bins
One of the difficulties in working with a binary response variable is understanding how it "changes." The response itself () is either 0 or 1, while the fitted values (
)—which are interpreted as probabilities—are between 0 and 1. But if every medical school applicant is either admitted or not, what does it mean to talk about the probability of being accepted?

What wed like is a larger sample of students, so that for each GPA value (e.g. 3.54) we had many observations (say ), and we could then take the average of those  observations to arrive at the estimated probability of acceptance. Unfortunately, since the explanatory variable is continuous, this is hopeless—it would take an infinite amount of data to make these estimates robust.
Instead, what we can do is put the observations into bins based on their GPA value. Within each bin, we can compute the proportion of accepted students, and we can visualize our model as a smooth logistic curve through those binned values.
We have created a data.frame called MedGPA_binned that aggregates the original data into separate bins for each 0.25 of GPA. It also contains the fitted values from the logistic regression model.

Here we are plotting  as a function of , where that function is
     y = \frac{\exp{( \hat{\beta}_0 + \hat{\beta}_1 \cdot x )}}{1 + \exp( \hat{\beta}_0 + \hat{\beta}_1 \cdot x ) } \,.
Note that the left hand side is the expected probability  of being accepted to medical school.

# binned points and line
data_space <- ggplot(MedGPA_binned, aes(x = mean_GPA, y = acceptance_rate)) +
  geom_point() +
  geom_line()
# augmented model
MedGPA_plus <- augment(mod, type.predict = "response")
# logistic model on probability scale
data_space +
  geom_line(data = MedGPA_plus, aes(x = GPA, y = .fitted), color = "red")

-----

# Odds scale
For most people, the idea that we could estimate the probability of being admitted to medical school based on undergraduate GPA is fairly intuitive. However, thinking about how the probability changes as a function of GPA is complicated by the non-linear logistic curve. By translating the response from the probability scale to the odds scale, we make the right hand side of our equation easier to understand.
If the probability of getting accepted is , then the odds are . Expressions of probabilities in terms of odds are common in many situations, perhaps most notably gambling.
Here we are plotting  as a function of , where that function is
  odds(\hat{y}) = \frac{\hat{y}}{1-\hat{y}} = \exp{( \hat{\beta}_0 + \hat{\beta}_1 \cdot x ) }
Note that the left hand side is the expected odds of being accepted to medical school. The right hand side is now a familiar exponential function of .
The MedGPA_binned data frame contains the data for each GPA bin, while the MedGPA_plus data frame records the original observations after being augment()-ed by mod.

# compute odds for bins
MedGPA_binned <- mutate(MedGPA_binned, odds = acceptance_rate / (1 - acceptance_rate))
# plot binned odds
data_space <- ggplot(MedGPA_binned, aes(x = mean_GPA, y = odds)) +
  geom_point() +
  geom_line()
# compute odds for observations
MedGPA_plus <- mutate(MedGPA_plus, odds_hat = .fitted / (1 - .fitted))
# logistic model on odds scale
data_space +
  geom_line(data = MedGPA_plus, aes(x = GPA, y = odds_hat), color = "red")

-----

# Log-odds scale
Previously, we considered two formulations of logistic regression models:
on the probability scale, the units are easy to interpret, but the function is non-linear, which makes it hard to understand
on the odds scale, the units are harder (but not impossible) to interpret, and the function in exponential, which makes it harder (but not impossible) to interpret
Well now add a third formulation:
on the log-odds scale, the units are nearly impossible to interpret, but the function is linear, which makes it easy to understand
As you can see, none of these three is uniformly superior. Most people tend to interpret the fitted values on the probability scale and the function on the log-odds scale. The interpretation of the coefficients is most commonly done on the odds scale. Recall that we interpreted our slope coefficient in linear regression as the expected change in  given a one unit change in . On the probability scale, the function is non-linear and so this approach wont work. On the log-odds, the function is linear, but the units are not interpretable (what does the  of the odds mean??). However, on the odds scale, a one unit change in  leads to the odds being multiplied by a factor of. 
To see why, we form the odds ratio:
    OR = \frac{odds(\hat{y} | x + 1 )}{ odds(\hat{y} | x )} = \exp{\beta_1}
Thus, the exponentiated coefficent tells us how the expected odds change for a one unit increase in the explanatory variable. It is tempting to interpret this as a change in the expected probability, but this is wrong and can lead to nonsensical predictions (e.g. expected probabilities greater than 1).

# compute log odds for bins
MedGPA_binned <- mutate(MedGPA_binned, log_odds = log(acceptance_rate / (1 - acceptance_rate)))
# plot binned log odds
data_space <- ggplot(MedGPA_binned, aes(x = mean_GPA, y = log_odds)) +
  geom_point() +
  geom_line()
# compute log odds for observations
MedGPA_plus <- mutate(MedGPA_plus, log_odds_hat = log(.fitted / (1 - .fitted)))
# logistic model on log odds scale
data_space +
  geom_line(data = MedGPA_plus, aes(x = GPA, y = log_odds_hat), color = "red")

-----

# Interpretation of logistic regression
The fitted coefficient from the medical school logistic regression model is 5.45. The exponential of this is 233.73.
Donalds GPA is 2.9, and thus the model predicts that the probability of him getting into medical school is 3.26%. The odds of Donald getting into medical school are 0.0337, or—phrased in gambling terms—29.6:1. If Donald hacks the schools registrar and changes his GPA to 3.9, then which of the following statements is FALSE:

# His expected probability of getting into medical school improves to 7.9%.

-----

# Making probabilistic predictions
Just as we did with linear regression, we can use our logistic regression model to make predictions about new observations. In this exercise, we will use the newdata argument to the augment() function from the broom package to make predictions about students who were not in our original data set. These predictions are sometimes called out-of-sample.
Following our previous discussion about scales, with logistic regression it is important that we specify on which scale we want the predicted values. Although the default is terms -- which uses the log-odds scale -- we want our predictions on the probability scale, which is the scale of the response variable. The type.predict argument to augment() controls this behavior.
A logistic regression model object, mod, has been defined for you.

# create new data frame
new_data <- data.frame(GPA = 3.51)
# make predictions
augment(mod, newdata = new_data, type.predict = "response")

-----

# Making binary predictions
Naturally, we want to know how well our model works. Did it predict acceptance for the students who were actually accepted to medical school? Did it predict rejections for the student who were not admitted? These types of predictions are called in-sample. One common way to evaluate models with a binary response is with a confusion matrix. [Yes, that is actually what it is called!]
However, note that while our response variable is binary, our fitted values are probabilities. Thus, we have to round them somehow into binary predictions. While the probabilities convey more information, we might ultimately have to make a decision, and so this rounding is common in practice. There are many different ways to round, but for simplicity we will predict admission if the fitted probability is greater than 0.5, and rejection otherwise.
First, well use augment() to make the predictions, and then mutate() and round() to convert these probabilities into binary decisions. Then we will form the confusion matrix using the table() function. table() will compute a 2-way table when given a data frame with two categorical variables, so we will first use select() to grab only those variables.
You will find that this model made only 15 mistakes on these 55 observations, so it is nearly 73% accurate.

# data frame with binary predictions
tidy_mod <- augment(mod, type.predict = "response") %>%
  mutate(Acceptance_hat = round(.fitted))
  
# confusion matrix
tidy_mod %>%
  select(Acceptance, Acceptance_hat) %>% 
  table()

-----
