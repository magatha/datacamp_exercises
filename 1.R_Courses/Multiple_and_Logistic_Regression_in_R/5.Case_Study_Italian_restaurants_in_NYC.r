# Exploratory data analysis
Multiple regression can be an effective technique for understanding how a response variable changes as a result of changes to more than one explanatory variable. But it is not magic -- understanding the relationships among the explanatory variables is also necessary, and will help us build a better model. This process is often called exploratory data analysis (EDA) and is covered in another DataCamp course.
One quick technique for jump-starting EDA is to examine all of the pairwise scatterplots in your data. This can be achieved using the pairs() function. Look for variables in the nyc data set that are strongly correlated, as those relationships will help us check for multicollinearity later on.
Which pairs of variables appear to be strongly correlated?

# Price and Food

-----

# SLR models
Based on your knowledge of the restaurant industry, do you think that the quality of the food in a restaurant is an important determinant of the price of a meal at that restaurant? It would be hard to imagine that it wasn't. We'll start our modeling process by plotting and fitting a model for Price as a function of Food.
On your own, interpret these coefficients and examine the fit of the model. What does the coefficient of Food mean in plain English? "Each additional rating point of food quality is associated with a..."

# Price by Food plot
ggplot(nyc, aes(x = Food, y = Price)) +
  geom_point()
# Price by Food model
lm(Price ~ Food, data = nyc)

-----

# Parallel lines with location
In real estate, a common mantra is that the three most important factors in determining the price of a property are "location, location, and location." If location drives up property values and rents, then we might imagine that location would increase a restaurants costs, which would result in them having higher prices. In many parts of New York, the east side (east of 5th Avenue) is more developed and perhaps more expensive. [This is increasingly less true, but was more true at the time these data were collected.]
Lets expand our model into a parallel slopes model by including the East variable in addition to Food.
Use lm() to fit a parallel slopes model for Price as a function of Food and East. Interpret the coefficients and the fit of the model. Can you explain the meaning of the coefficient on East in simple terms? Did the coefficient on Food change from the previous model? If so, why? Did it change by a lot or just a little?
Identify the statement that is FALSE:

# The change in the coefficient of food from $2.94 in the simple linear model to $2.88 in this model has profound practical implications for restaurant owners.

-----

# A plane in 3D
One reason that many people go to a restaurant—apart from the food—is that they dont have to cook or clean up. Many people appreciate the experience of being waited upon, and we can all agree that the quality of the service at restaurants varies widely. Are people willing to pay more for better restaurant Service? More interestingly, are they willing to pay more for better service, after controlling for the quality of the food?
Multiple regression gives us a way to reason about these questions. Fit the model with Food and Service and interpret the coefficients and fit. Did the coefficient on Food change from the previous model? What do the coefficients on Food and Service tell you about how these restaurants set prices?
Next, lets visually assess our model using plotly. The x and y vectors, as well as the plane matrix, have been created for you.

# fit model
lm(Price ~ Food + Service, data = nyc)
# draw 3D scatterplot
p <- plot_ly(data = nyc, z = ~Price, x = ~Food, y = ~Service, opacity = 0.6) %>%
  add_markers() 
# draw a plane
p %>%
  add_surface(x = ~x, y = ~y, z = ~plane, showscale = FALSE) 

-----

# Parallel planes with location
We have explored models that included the quality of both food and service, as well as location, but we havent put these variables all into the same model. Lets now build a parallel planes model that incorporates all three variables.
Examine the coefficients closely. Do they make sense based on what you understand about these data so far? How did the coefficients change from the previous models that you fit?

# Price by Food and Service and East
lm(Price ~ Food + Service + East, data = nyc)

-----

# Interpretation of location coefficient
The fitted coefficients from the parallel planes model are listed below.
(Intercept)        Food     Service        East 
-20.8154761   1.4862725   1.6646884   0.9648814 
Which of the following statements is FALSE?
Reason about the magnitude of the East coefficient.

# The expected price of a meal on the East side is about 96% of the cost of a meal on the West side, after controlling for the quality of food and service.

-----

# Impact of location
The impact of location brings us to a modeling question: should we keep this variable in our model? In a later course, you will learn how we can conduct formal hypothesis tests to help us answer that question. In this course, we will focus on the size of the effect. Is the impact of location big or small?
One way to think about this would be in terms of the practical significance. Is the value of the coefficient large enough to make a difference to your average person? The units are in dollars so in this case this question is not hard to grasp.
Another way is to examine the impact of location in the context of the variability of the other variables. We can do this by building our parallel planes in 3D and seeing how far apart they are. Are the planes close together or far apart? Does the East variable clearly separate the data into two distinct groups? Or are the points all mixed up together?

# draw 3D scatterplot
p <- plot_ly(data = nyc, z = ~Price, x = ~Food, y = ~Service, opacity = 0.6) %>%
  add_markers(color = ~factor(East)) 
# draw two planes
p %>%
  add_surface(x = ~x, y = ~y, z = ~plane0, showscale = FALSE) %>%
  add_surface(x = ~x, y = ~y, z = ~plane1, showscale = FALSE)

-----

# Full model
One variable we havent considered is Decor. Do people, on average, pay more for a meal in a restaurant with nicer decor? If so, does it still matter after controlling for the quality of food, service, and location?
By adding a third numeric explanatory variable to our model, we lose the ability to visualize the model in even three dimensions. Our model is now a hyperplane -- or rather, parallel hyperplanes -- and while we wont go any further with the geometry, know that we can continue to add as many variables to our model as we want. As humans, our spatial visualization ability taps out after three numeric variables (maybe you could argue for four, but certainly no further), but neither the mathematical equation for the regression model, nor the formula specification for the model in R, is bothered by the higher dimensionality.
Use lm() to fit a parallel planes model for Price as a function of Food, Service, Decor, and East.
Notice the dramatic change in the value of the Service coefficient.
Which of the following interpretations is invalid?

# Service is not an important factor in determining the price of a meal.

------
