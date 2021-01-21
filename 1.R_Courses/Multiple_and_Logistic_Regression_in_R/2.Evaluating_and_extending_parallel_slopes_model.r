# R-squared vs. adjusted R-squared
Two common measures of how well a model fits to data are R^2  (the coefficient of determination) and the adjusted R^2 . 
The former measures the percentage of the variability in the response variable that is explained by the model. To compute this, we define
     R^2 = 1 - \frac{SSE}{SST} \,,
where SSE and SST are the sum of the squared residuals, and the total sum of the squares, respectively. One issue with this measure is that the SSE can only decrease as new variable are added to the model, while the  depends only on the response variable and therefore is not affected by changes to the model. This means that you can increase 
R^2 by adding any additional variable to your model—even random noise. 
The adjusted R^2 includes a term that penalizes a model for each additional explanatory variable (where  is the number of explanatory variables).
     R^2_{adj} = 1 - \frac{SSE}{SST} \cdot \frac{n-1}{n-p-1} \,,
We can see both measures in the output of the summary() function on our model object.

# R^2 and adjusted R^2
summary(mod)
# add random noise
mario_kart_noisy <- mario_kart %>%
  mutate(noise = rnorm(nrow(mario_kart)))
# compute new model
mod2 <- lm(totalPr ~ wheels + cond + noise, data = mario_kart_noisy)
# new R^2 and adjusted R^2
summary(mod2)

-----

# Prediction
Once we have fit a regression model, we can use it to make predictions for unseen observations or retrieve the fitted values. Here, we explore two methods for doing the latter.
A traditional way to return the fitted values (i.e. the ys) is to run the predict() function on the model object. This will return a vector of the fitted values. Note that predict() will take an optional newdata argument that will allow you to make predictions for observations that are not in the original data.
A newer alternative is the augment() function from the broom package, which returns a data.frame with the response varible (), the relevant explanatory variables (the xs), the fitted value (y) and some information about the residuals (e). augment() will also take a newdata argument that allows you to make predictions.

# return a vector
predict(mod)
# return a data frame
augment(mod)

-----

# Thought experiments
Suppose that after going apple picking you have 12 apples left over. You decide to conduct an experiment to investigate how quickly they will rot under certain conditions. You place six apples in a cool spot in your basement, and leave the other six on the window sill in the kitchen. Every week, you estimate the percentage of the surface area of the apple that is rotten or moldy.
Consider the following models:
    rot = \beta_0 + \beta_1 \cdot t + \beta_2 \cdot temp \,,
and
    rot = \beta_0 + \beta_1 \cdot t + \beta_2 \cdot temp + \beta_3 \cdot temp \cdot t \,,
where  is time, measured in weeks, and  is a binary variable indicating either cool or warm.
If you decide to keep the interaction term present in the second model, you are implicitly assuming that:

# The rate at which apples rot will vary based on the temperature.

-----

# Fitting a model with interaction
Including an interaction term in a model is easy—we just have to tell lm() that we want to include that new variable. An expression of the form
    lm(y ~ x + z + x:z, data = mydata)
will do the trick. The use of the colon (:) here means that the interaction between  and  will be a third term in the model.

# include interaction
lm(totalPr ~ cond + duration + cond:duration, data = mario_kart)

-----

# Visualizing interaction models
Interaction allows the slope of the regression line in each group to vary. In this case, this means that the relationship between the final price and the length of the auction is moderated by the condition of each item.
Interaction models are easy to visualize in the data space with ggplot2 because they have the same coefficients as if the models were fit independently to each group defined by the level of the categorical variable. In this case, new and used MarioKarts each get their own regression line. To see this, we can set an aesthetic (e.g. color) to the categorical variable, and then add a geom_smooth() layer to overlay the regression line for each color.

# interaction plot
ggplot(mario_kart, aes(x = duration, y = totalPr, color = cond)) + 
  geom_point() + 
  geom_smooth(method = "lm", se = FALSE)

-----

# Consequences of Simpson's paradox
In the simple linear regression model for average SAT score, (total) as a function of average teacher salary (salary), the fitted coefficient was -5.02 points per thousand dollars. This suggests that for every additional thousand dollars of salary for teachers in a particular state, the expected SAT score for a student from that state is about 5 points lower.
In the model that includes the percentage of students taking the SAT, the coefficient on salary becomes 1.84 points per thousand dollars. Choose the correct interpretation of this slope coefficient.

# For every additional thousand dollars of salary for teachers in a particular state, the expected SAT score for a student from that state is about 2 points higher, after controlling for the percentage of students taking the SAT.

-----

# Simpson's paradox in action
A mild version of Simpsons paradox can be observed in the MarioKart auction data. Consider the relationship between the final auction price and the length of the auction. It seems reasonable to assume that longer auctions would result in higher prices, since—other things being equal—a longer auction gives more bidders more time to see the auction and bid on the item.
However, a simple linear regression model reveals the opposite: longer auctions are associated with lower final prices. The problem is that all other things are not equal. In this case, the new MarioKarts—which people pay a premium for—were mostly sold in one-day auctions, while a plurality of the used MarioKarts were sold in the standard seven-day auctions.
Our simple linear regression model is misleading, in that it suggests a negative relationship between final auction price and duration. However, for the used MarioKarts, the relationship is positive.

slr <- ggplot(mario_kart, aes(y = totalPr, x = duration)) + 
  geom_point() + 
  geom_smooth(method = "lm", se = 0)

# model with one slope
lm(totalPr ~ duration, data = mario_kart)

# plot with two slopes
slr + aes(color = cond)

-----
