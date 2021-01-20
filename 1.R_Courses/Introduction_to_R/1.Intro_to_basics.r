# How it works
In the editor on the right you should type R code to solve the exercises. When you hit the 'Submit Answer' button, every line of code is interpreted and executed by R and you get a message whether or not your code was correct. The output of your R code is shown in the console in the lower right corner.
R makes use of the # sign to add comments, so that you and others can understand what the R code is about. Just like Twitter! Comments are not run as R code, so they will not influence your result. For example, Calculate 3 + 4 in the editor on the right is a comment.
You can also execute R commands straight in the console. This is a good way to experiment with R code, as your submission is not checked for correctness.

# Calculate 3 + 4
3 + 4
# Calculate 6 + 12
6 + 12

-----

# Arithmetic with R
In its most basic form, R can be used as a simple calculator. Consider the following arithmetic operators:
Addition: +
Subtraction: -
Multiplication: *
Division: /
Exponentiation: ^
Modulo: %%

The last two might need some explaining:
The ^ operator raises the number to its left to the power of the number to its right: for example 3^2 is 9.
The modulo returns the remainder of the division of the number to the left by the number on its right, for example 5 modulo 3 or 5 %% 3 is 2.
With this knowledge, follow the instructions to complete the exercise.

# An addition
5 + 5 
# A subtraction
5 - 5 
# A multiplication
3 * 5
 # A division
(5 + 5) / 2 
# Exponentiation
2^5
# Modulo
28 %% 6

-----

#Variable assignment
A basic concept in (statistical) programming is called a variable.
A variable allows you to store a value (e.g. 4) or an object (e.g. a function description) in R. You can then later use this variable name to easily access the value or the object that is stored within this variable.
You can assign a value 4 to a variable my_var with the command
my_var <- 4

# Assign the value 42 to x
x <- 42
# Print out the value of the variable x
x

-----

#Variable assignment (2)
Suppose you have a fruit basket with five apples. As a data analyst in training, you want to store the number of apples in a variable with the name my_apples.

# Assign the value 5 to the variable my_apples
my_apples <- 5
# Print out the value of the variable my_apples
my_apples

-----

#Variable assignment (3)
Every tasty fruit basket needs oranges, so you decide to add six oranges. As a data analyst, your reflex is to immediately create the variable my_oranges and assign the value 6 to it. Next, you want to calculate how many pieces of fruit you have in total. Since you have given meaningful names to these values, you can now code this in a clear way:
my_apples + my_oranges

# Assign a value to the variables my_apples and my_oranges
my_apples <- 5
my_oranges <- 6
# Add these two variables together
my_apples + my_oranges 
# Create the variable my_fruit
my_fruit <- my_apples + my_oranges

-----

#Apples and oranges
Common knowledge tells you not to add apples and oranges. But hey, that is what you just did, no :-)? The my_apples and my_oranges variables both contained a number in the previous exercise. The + operator works with numeric variables in R. If you really tried to add "apples" and "oranges", and assigned a text value to the variable my_oranges (see the editor), you would be trying to assign the addition of a numeric and a character variable to the variable my_fruit. This is not possible.

# Assign a value to the variable my_apples
my_apples <- 5 
# Fix the assignment of my_oranges
my_oranges <- 6 
# Create the variable my_fruit and print it out
my_fruit <- my_apples + my_oranges 
my_fruit

-----

#Basic data types in R
R works with numerous data types. Some of the most basic types to get started are:
Decimal values like 4.5 are called numerics.
Whole numbers like 4 are called integers. Integers are also numerics.
Boolean values (TRUE or FALSE) are called logical.
Text (or string) values are called characters.
Note how the quotation marks in the editor indicate that "some text" is a string.

# Change my_numeric to be 42
my_numeric <- 42
# Change my_character to be "universe"
my_character <- "universe"
# Change my_logical to be FALSE
my_logical <- FALSE

-----

#What's that data type?
Do you remember that when you added 5 + "six", you got an error due to a mismatch in data types? You can avoid such embarrassing situations by checking the data type of a variable beforehand. You can do this with the class() function, as the code in the editor shows.

# Declare variables of different types
my_numeric <- 42
my_character <- "universe"
my_logical <- FALSE 
# Check class of my_numeric
class(my_numeric)
# Check class of my_character
class(my_character)
# Check class of my_logical
class(my_logical)

-----
