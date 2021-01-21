# RMSE
The residual standard error reported for the regression model for poverty rate of U.S. counties in terms of high school graduation rate is 4.67. What does this mean?

# The typical difference between the observed poverty rate and the poverty rate predicted by the model is about 4.67 percentage points.

-----

# Standard error of residuals
One way to assess strength of fit is to consider how far off the model is for a typical case. That is, for some observations, the fitted value will be very close to the actual value, while for others it will not. The magnitude of a typical residual can give us a sense of generally how close our estimates are.
However, recall that some of the residuals are positive, while others are negative. In fact, it is guaranteed by the least squares fitting procedure that the mean of the residuals is zero. Thus, it makes more sense to compute the square root of the mean squared residual, or root mean squared error (RMSE). R calls this quantity the residual standard error.
To make this estimate unbiased, you have to divide the sum of the squared residuals by the degrees of freedom in the model. Thus,
    RMSE = \sqrt{ \frac{\sum_i{e_i^2}}{d.f.} } = \sqrt{ \frac{SSE}{d.f.} }
You can recover the residuals from mod with residuals(), and the degrees of freedom with df.residual().

# View summary of model
summary(mod)
# Compute the mean of the residuals
mean(residuals(mod))
# Compute RMSE
sqrt(sum(residuals(mod)^2) / df.residual(mod))

-----

# Assessing simple linear model fit
Recall that the coefficient of determination (R^2), can be computed as
    R^2 = 1 - \frac{SSE}{SST} = 1 - \frac{Var(e)}{Var(y)} \,,
where  is the vector of residuals and  is the response variable. This gives us the interpretation of R^2 as the percentage of the variability in the response that is explained by the model, since the residuals are the part of that variability that remains unexplained by the model.

# View model summary
summary(mod)
# Compute R-squared
bdims_tidy %>%
  summarize(var_y = var(wgt), var_e = var(.resid)) %>%
  mutate(R_squared =  1 - (var_e/var_y))

-----

# Interpretation of R^2
The R^2 reported for the regression model for poverty rate of U.S. counties in terms of high school graduation rate is 0.464.
lm(formula = poverty ~ hs_grad, data = countyComplete) %>%
  summary()
How should this result be interpreted?

# 46.4% of the variability in poverty rate among U.S. counties can be explained by high school graduation rate.

-----

# Linear vs. average
The R^2 gives us a numerical measurement of the strength of fit relative to a null model based on the average of the response variable:
    \hat{y}_{null} = \bar{y}
This model has an R^2 of zero because . That is, since the fitted values (\hat{y}_{null}) are all equal to the average (\bar{y}), the residual for each observation is the distance between that observation and the mean of the response. Since we can always fit the null model, it serves as a baseline against which all other models will be compared.
In the graphic, we visualize the residuals for the null model (mod_null at left) vs. the simple linear regression model (mod_hgt at right) with height as a single explanatory variable. Try to convince yourself that, if you squared the lengths of the grey arrows on the left and summed them up, you would get a larger value than if you performed the same operation on the grey arrows on the right.
It may be useful to preview these augment()-ed data frames with glimpse():
glimpse(mod_null)
glimpse(mod_hgt)

-----

# Leverage
The leverage of an observation in a regression model is defined entirely in terms of the distance of that observation from the mean of the explanatory variable. That is, observations close to the mean of the explanatory variable have low leverage, while observations far from the mean of the explanatory variable have high leverage. Points of high leverage may or may not be influential.
The augment() function from the broom package will add the leverage scores (.hat) to a model data frame.

# Rank points of high leverage
mod %>%
  augment %>%
  arrange(desc(.hat)) %>%
  head()

-----

# Influence
As noted previously, observations of high leverage may or may not be influential. The influence of an observation depends not only on its leverage, but also on the magnitude of its residual. Recall that while leverage only takes into account the explanatory variable (), the residual depends on the response variable () and the fitted value (). 
Influential points are likely to have high leverage and deviate from the general relationship between the two variables. We measure influence using Cooks distance, which incorporates both the leverage and residual of each observation.

# Rank influential points
mod %>%
  augment() %>%
  arrange(desc(.cooksd)) %>%
  head()

-----

# Removing outliers
Observations can be outliers for a number of different reasons. Statisticians must always be careful—and more importantly, transparent—when dealing with outliers. Sometimes, a better model fit can be achieved by simply removing outliers and re-fitting the model. However, one must have strong justification for doing this. A desire to have a higher R^2 is not a good enough reason!
In the mlbBat10 data, the outlier with an OBP of 0.550 is Bobby Scales, an infielder who had four hits in 13 at-bats for the Chicago Cubs. Scales also walked seven times, resulting in his unusually high OBP. The justification for removing Scales here is weak. While his performance was unusual, there is nothing to suggest that it is not a valid data point, nor is there a good reason to think that somehow we will learn more about Major League Baseball players by excluding him.
Nevertheless, we can demonstrate how removing him will affect our model.

# Create nontrivial_players
nontrivial_players <- mlbBat10 %>%
  filter(AB >= 10, OBP < 0.5)
# Fit model to new data
mod_cleaner <- lm(SLG ~ OBP, data = nontrivial_players)
# View model summary
summary(mod_cleaner)
# Visualize new model
ggplot(data = nontrivial_players, aes(x = OBP, y = SLG)) +
  geom_point() + 
  geom_smooth(method = "lm")

-----

# High leverage points
Not all points of high leverage are influential. While the high leverage observation corresponding to Bobby Scales in the previous exercise is influential, the three observations for players with OBP and SLG values of 0 are not influential.
This is because they happen to lie right near the regression anyway. Thus, while their extremely low OBP gives them the power to exert influence over the slope of the regression line, their low SLG prevents them from using it.

# Rank high leverage points
mod %>%
  augment() %>%
  arrange(desc(.hat), .cooksd) %>%
  head()

-----


























