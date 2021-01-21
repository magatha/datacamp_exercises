# Fitting a parallel slopes model
We use the lm() function to fit linear models to data. In this case, we want to understand how the price of MarioKart games sold at auction varies as a function of not only the number of wheels included in the package, but also whether the item is new or used. Obviously, it is expected that you might have to pay a premium to buy these new. But how much is that premium? Can we estimate its value after controlling for the number of wheels?
We will fit a parallel slopes model using lm(). In addition to the data argument, lm() needs to know which variables you want to include in your regression model, and how you want to include them. It accomplishes this using a formula argument. A simple linear regression formula looks like y ~ x, where y is the name of the response variable, and x is the name of the explanatory variable. Here, we will simply extend this formula to include multiple explanatory variables. A parallel slopes model has the form y ~ x + z, where z is a categorical explanatory variable, and x is a numerical explanatory variable.
The output from lm() is a model object, which when printed, will show the fitted coefficients.

# Explore the data
str(mario_kart)
# fit parallel slopes
lm(totalPr ~ wheels + cond, data = mario_kart)

------

# Reasoning about two intercepts
The mario_kart data contains several other variables. The totalPr, startPr, and shipPr variables are numeric, while the cond and stockPhoto variables are categorical.
Which formula will result in a parallel slopes model?

# totalPr ~ shipPr + stockPhoto

-----

# Using geom_line() and augment()
Parallel slopes models are so-named because we can visualize these models in the data space as not one line, but two parallel lines. To do this, well draw two things:
a scatterplot showing the data, with color separating the points into groups
a line for each value of the categorical variable

Our plotting strategy is to compute the fitted values, plot these, and connect the points to form a line. The augment() function from the broom package provides an easy way to add the fitted values to our data frame, and the geom_line() function can then use that data frame to plot the points and connect them.
Note that this approach has the added benefit of automatically coloring the lines appropriately to match the data.
You already know how to use ggplot() and geom_point() to make the scatterplot. The only twist is that now youll pass your augment()-ed model as the data argument in your ggplot() call. When you add your geom_line(), instead of letting the y aesthetic inherit its values from the ggplot() call, you can set it to the .fitted column of the augment()-ed model. This has the advantage of automatically coloring the lines for you.

# Augment the model
augmented_mod <- augment(mod)
glimpse(augmented_mod)
# scatterplot, with color
data_space <- ggplot(augmented_mod, aes(x = wheels, y = totalPr, color = cond)) +
  geom_point()
# single call to geom_line()
data_space + 
  geom_line(aes(y = .fitted))

-----

# Intercept interpretation
Recall that the cond variable is either new or used. Here are the fitted coefficients from your model:
Call:
lm(formula = totalPr ~ wheels + cond, data = mario_kart)
Coefficients:
(Intercept)       wheels     condused  
     42.370        7.233       -5.585  
Choose the correct interpretation of the coefficient on condused:

# he expected price of a used MarioKart is $5.58 less than that of a new one with the same number of wheels.

-----

# Common slope interpretation
Recall the fitted coefficients from our model:
Call:
lm(formula = totalPr ~ wheels + cond, data = mario_kart)
Coefficients:
(Intercept)       wheels     condused  
     42.370        7.233       -5.585  
Choose the correct interpretation of the slope coefficient:

# For each additional wheel, the expected price of a MarioKart increases by $7.23 regardless of whether it is new or used.

-----

# Syntax from math
The babies data set contains observations about the birthweight and other characteristics of children born in the San Francisco Bay area from 1960--1967.
We would like to build a model for birthweight as a function of the mothers age and whether this child was her first (parity == 0). Use the mathematical specification below to code the model in R.
    birthweight = \beta_0 + \beta_1 \cdot age + \beta_2 \cdot parity + \epsilon

# build model
lm(bwt ~ age + parity, data = babies)

-----

# Syntax from plot
This time, wed like to build a model for birthweight as a function of the length of gestation and the mothers smoking status. Use the plot to inform your model specification.

# build model
lm(bwt ~ gestation + smoke, data = babies)

-----
