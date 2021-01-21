# Interpretation of coefficients
Recall that the fitted model for the poverty rate of U.S. counties as a function of high school graduation rate is:
    \widehat{poverty} = 64.594 - 0.591 \cdot hs\_grad
Which of the following is the correct interpretation of the slope coefficient?

# Among U.S. counties, each additional percentage point increase in the high school graduation rate is associated with about a 0.591 percentage point decrease in the poverty rate.

-----

# Interpretation in context
A politician interpreting the relationship between poverty rates and high school graduation rates implores his constituents:
If we can lower the poverty rate by 59%, we'll double the high school graduate rate in our county (i.e. raise it by 100%).
Which of the following mistakes in interpretation has the politician made?

# All of above

-----

# Fitting simple linear models
While the geom_smooth(method = "lm") function is useful for drawing linear models on a scatterplot, it doesnt actually return the characteristics of the model. As suggested by that syntax, however, the function that creates linear models is lm(). This function generally takes two arguments:
A formula that specifies the model
A data argument for the data frame that contains the data you want to use to fit the model
The lm() function return a model object having class "lm". This object contains lots of information about your regression model, including the data used to fit the model, the specification of the model, the fitted values and residuals, etc.

# Linear model for weight as a function of height
lm(wgt ~ hgt, data = bdims)
# Linear model for SLG as a function of OBP
lm(SLG ~ OBP, data = mlbBat10)
# Log-linear model for body weight as a function of brain weight
lm(log(BodyWt) ~ log(BrainWt), data = mammals)

-----

# Units and scale
In the previous examples, we fit two regression models:
    \widehat{wgt} = -105.011 + 1.018 \cdot hgt
and
    \widehat{SLG} = 0.009 + 1.110 \cdot OBP \,.
Which of the following statements is incorrect?

# Because the slope coefficient for  is larger (1.110) than the slope coefficient for  (1.018), we can conclude that the association between  and  is stronger than the association between height and weight.

-----

# The lm summary output
An "lm" object contains a host of information about the regression model that you fit. There are various ways of extracting different pieces of information.
The coef() function displays only the values of the coefficients. Conversely, the summary() function displays not only that information, but a bunch of other information, including the associated standard error and p-value for each coefficient, the R^2, adjusted R^2 , and the residual standard error. The summary of an "lm" object in R is very similar to the output you would see in other statistical computing environments (e.g. Stata, SPSS, etc.)

# Show the coefficients
coef(mod)
# Show the full output
summary(mod)

-----

# Fitted values and residuals
Once you have fit a regression model, you are often interested in the fitted values (\hat{y}_i) and the residuals (e_i), where  indexes the observations. Recall that:
  e_i = y_i - \hat{y}_i
The least squares fitting procedure guarantees that the mean of the residuals is zero (n.b., numerical instability may result in the computed values not being exactly zero). At the same time, the mean of the fitted values must equal the mean of the response variable.
In this exercise, we will confirm these two mathematical facts by accessing the fitted values and residuals with the fitted.values() and residuals() functions, respectively, for the following model:
{r, eval=FALSE} mod <- lm(wgt ~ hgt, data = bdims)

# Mean of weights equal to mean of fitted values?
mean(fitted.values(mod)) == mean(bdims$wgt)
# Mean of the residuals
mean(residuals(mod))

-----

# Tidying your linear model
As you fit a regression model, there are some quantities (e.g. R^2) that apply to the model as a whole, while others apply to each observation (e.g. \hat{y}_i). If there are several of these per-observation quantities, it is sometimes convenient to attach them to the original data as new variables.
The augment() function from the broom package does exactly this. It takes a model object as an argument and returns a data frame that contains the data on which the model was fit, along with several quantities specific to the regression model, including the fitted values, residuals, leverage scores, and standardized residuals.

# Load broom
library(broom)
# Create bdims_tidy
bdims_tidy <- augment(mod)
# Glimpse the resulting data frame
glimpse(bdims_tidy)

-----

# Making predictions
The fitted.values() function or the augment()-ed data frame provides us with the fitted values for the observations that were in the original data. However, once we have fit the model, we may want to compute expected values for observations that were not present in the data on which the model was fit. These types of predictions are called out-of-sample.
The ben data frame contains a height and weight observation for one person. The mod object contains the fitted model for weight as a function of height for the observations in the bdims dataset. We can use the predict() function to generate expected values for the weight of new individuals. We must pass the data frame of new observations through the newdata argument.

# Print ben
ben
# Predict the weight of ben
predict(mod, newdata = ben)

-----

# Adding a regression line to a plot manually
The geom_smooth() function makes it easy to add a simple linear regression line to a scatterplot of the corresponding variables. And in fact, there are more complicated regression models that can be visualized in the data space with geom_smooth(). However, there may still be times when we will want to add regression lines to our scatterplot manually. To do this, we will use the geom_abline() function, which takes slope and intercept arguments. Naturally, we have to compute those values ahead of time, but we already saw how to do this (e.g. using coef()).
The coefs data frame contains the model estimates retrieved from coef(). Passing this to geom_abline() as the data argument will enable you to draw a straight line on your scatterplot.

# Add the line to the scatterplot
ggplot(data = bdims, aes(x = hgt, y = wgt)) + 
  geom_point() + 
  geom_abline(data = coefs, 
              aes(intercept = `(Intercept)`, slope = hgt),  
              color = "dodgerblue")

-----
