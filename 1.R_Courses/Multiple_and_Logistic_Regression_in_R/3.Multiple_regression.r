# Fitting a MLR model
In terms of the R code, fitting a multiple linear regression model is easy: simply add variables to the model formula you specify in the lm() command.
In a parallel slopes model, we had two explanatory variables: one was numeric and one was categorical. Here, we will allow both explanatory variables to be numeric.

# Fit the model using duration and startPr
mod <- lm(totalPr ~ duration + startPr, data = mario_kart)

-----

# Tiling the plane
One method for visualizing a multiple linear regression model is to create a heatmap of the fitted values in the plane defined by the two explanatory variables. This heatmap will illustrate how the model output changes over different combinations of the explanatory variables.
This is a multistep process:
First, create a grid of the possible pairs of values of the explanatory variables. The grid should be over the actual range of the data present in each variable. Weve done this for you and stored the result as a data frame called grid.
Use augment() with the newdata argument to find the y corresponding to the values in grid.
Add these to the data_space plot by using the fill aesthetic and geom_tile().

# add predictions to grid
price_hats <- augment(mod, newdata = grid)
# tile the plane
data_space + 
  geom_tile(data = price_hats, aes(fill = .fitted), alpha = 0.5)

------

# Models in 3D
An alternative way to visualize a multiple regression model with two numeric explanatory variables is as a plane in three dimensions. This is possible in R using the plotly package.
We have created three objects that you will need:
x: a vector of unique values of duration
y: a vector of unique values of startPr
plane: a matrix of the fitted values across all combinations of x and y
Much like ggplot(), the plot_ly() function will allow you to create a plot object with variables mapped to x, y, and z aesthetics. The add_markers() function is similar to geom_point() in that it allows you to add points to your 3D plot.
Note that plot_ly uses the pipe (%>%) operator to chain commands together.

# draw the 3D scatterplot
p <- plot_ly(data = mario_kart, z = ~totalPr, x = ~duration, y = ~startPr, opacity = 0.6) %>%
  add_markers() 
# draw the plane
p %>%
  add_surface(x = ~x, y = ~y, z = ~plane, showscale = FALSE)

-----

# Coefficient magnitude
The coefficients from our model for the total auction price of MarioKarts as a function of auction duration and starting price are shown below.
Call:
lm(formula = totalPr ~ duration + startPr, data = mario_kart)
Coefficients:
(Intercept)     duration      startPr  
     51.030       -1.508        0.233  
A colleague claims that these results imply that the duration of the auction is a more important determinant of final price than starting price, because the coefficient is larger. This interpretation is false because:

# The coefficients have different units (dollars per day and dollars per dollar, respectively) and so they are not directly comparable.

-----

# Practicing interpretation
Fit a multiple regression model for the total auction price of an item in the mario_kart data set as a function of the starting price and the duration of the auction. Compute the coefficients and choose the correct interpretation of the duration variable.

# For each additional day the auction lasts, the expected final price declines by $1.51, after controlling for starting price.

-----

# Visualizing parallel planes
By including the duration, starting price, and condition variables in our model, we now have two explanatory variables and one categorical variable. Our model now takes the geometric form of two parallel planes!
The first plane corresponds to the model output when the condition of the item is new, while the second plane corresponds to the model output when the condition of the item is used. The planes have the same slopes along both the duration and starting price axes—it is the -intercept that is different.
Once again we have stored the x and y vectors for you. Since we now have two planes, there are matrix objects plane0 and plane1 stored for you as well.

# draw the 3D scatterplot
p <- plot_ly(data = mario_kart, z = ~totalPr, x = ~duration, y = ~startPr, opacity = 0.6) %>%
  add_markers(color = ~cond) 
# draw two planes
p %>%
  add_surface(x = ~x, y = ~y, z = ~plane0, showscale = FALSE) %>%
  add_surface(x = ~x, y = ~y, z = ~plane1, showscale = FALSE)

-----

# Parallel plane interpretation
The coefficients from our parallel planes model is shown below.
Call:
lm(formula = totalPr ~ duration + startPr + cond, data = mario_kart)
Coefficients:
(Intercept)     duration      startPr     condUsed  
    53.3448      -0.6560       0.1982      -8.9493  
Choose the right interpretation of  (the coefficient on condUsed):

# The expected premium for new (relative to used) MarioKarts is $8.95, after controlling for the duration and starting price of the auction.

-----

# Interpretation of coefficient in a big model
This time we have thrown even more variables into our model, including the number of bids in each auction (nBids) and the number of wheels. Unfortunately this makes a full visualization of our model impossible, but we can still interpret the coefficients.
Call:
lm(formula = totalPr ~ duration + startPr + cond + wheels + nBids, 
    data = mario_kart)
Coefficients:
(Intercept)     duration      startPr     condused       wheels  
    39.3741      -0.2752       0.1796      -4.7720       6.7216  
      nBids  
     0.1909  
Choose the correct interpretation of the coefficient on the number of wheels:

# Each additional wheel is associated with an increase in the expected auction price of $6.72, after controlling for auction duration, starting price, number of bids, and the condition of the item.

------
