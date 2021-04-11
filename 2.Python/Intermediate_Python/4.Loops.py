#while: warming up
The while loop is like a repeated if statement. The code is executed over and over again, as long as the condition is True. Have another look at its recipe.

while condition :
    expression
Can you tell how many printouts the following while loop will do?

x = 1
while x < 4 :
    print(x)
    x = x + 1

3

-------

#Basic while loop
Below you can find the example from the video where the error variable, initially equal to 50.0, is divided by 4 and printed out on every run:
error = 50.0
while error > 1 :
    error = error / 4
    print(error)
This example will come in handy, because it's time to build a while loop yourself! We're going to code a while loop that implements a very basic control system for an inverted pendulum. If there's an offset from standing perfectly straight, the while loop will incrementally fix this offset.
Note that if your while loop takes too long to run, you might have made a mistake. In particular, remember to indent the contents of the loop!

# Initialize offset
offset = 8

# Code the while loop
while offset != 0 :
    print("correcting...")
    offset = offset - 1
    print(offset)

-----

#Add conditionals
The while loop that corrects the offset is a good start, but what if offset is negative? You can try to run the following code where offset is initialized to -6:

# Initialize offset
offset = -6

# Code the while loop
while offset != 0 :
    print("correcting...")
    offset = offset - 1
    print(offset)
but your session will be disconnected. The while loop will never stop running, because offset will be further decreased on every run. offset != 0 will never become False and the while loop continues forever.
Fix things by putting an if-else statement inside the while loop. If your code is still taking too long to run, you probably made a mistake!

# Initialize offset
offset = -6

# Code the while loop
while offset != 0 :
    print("correcting...")
    if offset > 0 :
    	offset = offset - 1
    else:
    	offset = offset + 1
    print(offset)

-----

#Loop over a list
Have another look at the for loop that Hugo showed in the video:
fam = [1.73, 1.68, 1.71, 1.89]
for height in fam : 
    print(height)
As usual, you simply have to indent the code with 4 spaces to tell Python which code should be executed in the for loop.
The areas variable, containing the area of different rooms in your house, is already defined.

# areas list
areas = [11.25, 18.0, 20.0, 10.75, 9.50]

# Code the for loop
for elements in areas :
    print(elements)

-----

#Indexes and values (1)
Using a for loop to iterate over a list only gives you access to every list element in each run, one after the other. If you also want to access the index information, so where the list element you're iterating over is located, you can use enumerate().
As an example, have a look at how the for loop from the video was converted:
fam = [1.73, 1.68, 1.71, 1.89]
for index, height in enumerate(fam) :
    print("person " + str(index) + ": " + str(height))

 # areas list
areas = [11.25, 18.0, 20.0, 10.75, 9.50]

# Change for loop to use enumerate() and update print()
for index, area in enumerate(areas):
    print("room " + str(index) + ": " + str(area))

-----

#ndexes and values (2)
For non-programmer folks, room 0: 11.25 is strange. Wouldn't it be better if the count started at 1?

# areas list
areas = [11.25, 18.0, 20.0, 10.75, 9.50]

# Code the for loop
for index, area in enumerate(areas) :
    print("room " + str(index + 1) + ": " + str(area))

-----

#Loop over list of lists
Remember the house variable from the Intro to Python course? Have a look at its definition on the right. It's basically a list of lists, where each sublist contains the name and area of a room in your house.
It's up to you to build a for loop from scratch this time!

# house list of lists
house = [["hallway", 11.25], 
         ["kitchen", 18.0], 
         ["living room", 20.0], 
         ["bedroom", 10.75], 
         ["bathroom", 9.50]]
         
# Build a for loop from scratch
for x, y in house :
    print("the " + str(x) + " is " + str(y) + " sqm")

-------

#Loop over dictionary
In Python 3, you need the items() method to loop over a dictionary:
world = { "afghanistan":30.55, 
          "albania":2.77,
          "algeria":39.21 }

for key, value in world.items() :
    print(key + " -- " + str(value))
Remember the europe dictionary that contained the names of some European countries as key and their capitals as corresponding value? Go ahead and write a loop to iterate over it!

# Definition of dictionary
europe = {'spain':'madrid', 'france':'paris', 'germany':'berlin',
          'norway':'oslo', 'italy':'rome', 'poland':'warsaw', 'austria':'vienna' }
          
# Iterate over europe
for x, y in europe.items() :
    print("the capital of " + str(x) + " is " + str(y))

-----
#Loop over Numpy array
If you're dealing with a 1D Numpy array, looping over all elements can be as simple as:
for x in my_array :
    ...
If you're dealing with a 2D Numpy array, it's more complicated. A 2D array is built up of multiple 1D arrays. To explicitly iterate over all separate elements of a multi-dimensional array, you'll need this syntax:

for x in np.nditer(my_array) :
    ...
Two Numpy arrays that you might recognize from the intro course are available in your Python session: np_height, a Numpy array containing the heights of Major League Baseball players, and np_baseball, a 2D Numpy array that contains both the heights (first column) and weights (second column) of those players.

# Import numpy as np
import numpy as np

# For loop over np_height
for x in np_height :
    print(str(x) + " inches")

# For loop over np_baseball
for y in np.nditer(np_baseball) :
    print(y)

-----

#Loop over DataFrame (1)
Iterating over a Pandas DataFrame is typically done with the iterrows() method. Used in a for loop, every observation is iterated over and on every iteration the row label and actual row contents are available:
for lab, row in brics.iterrows() :
    ...
In this and the following exercises you will be working on the cars DataFrame. It contains information on the cars per capita and whether people drive right or left for seven countries in the world.

# Import cars data
import pandas as pd
cars = pd.read_csv('cars.csv', index_col = 0)

# Iterate over rows of cars
for label, contents in cars.iterrows() :
    print(label)
    print(contents)

-----

#Loop over DataFrame (2)
The row data that's generated by iterrows() on every run is a Pandas Series. This format is not very convenient to print out. Luckily, you can easily select variables from the Pandas Series using square brackets:
for lab, row in brics.iterrows() :
    print(row['country'])

# Import cars data
import pandas as pd
cars = pd.read_csv('cars.csv', index_col = 0)

# Adapt for loop
for lab, row in cars.iterrows() :
    print(str(lab) + ": ")
    print(str(row["cars_per_cap"]))

-----

#Add column (1)
In the video, Hugo showed you how to add the length of the country names of the brics DataFrame in a new column:
for lab, row in brics.iterrows() :
    brics.loc[lab, "name_length"] = len(row["country"])
You can do similar things on the cars DataFrame.

# Import cars data
import pandas as pd
cars = pd.read_csv('cars.csv', index_col = 0)

# Code for loop that adds COUNTRY column
for lab, row in cars.iterrows() :
    cars.loc[lab, 'COUNTRY'] = row['country'].upper()

# Print cars
print(cars)

-----

#Add column (2)
Using iterrows() to iterate over every observation of a Pandas DataFrame is easy to understand, but not very efficient. On every iteration, you're creating a new Pandas Series.
If you want to add a column to a DataFrame by calling a function on another column, the iterrows() method in combination with a for loop is not the preferred way to go. Instead, you'll want to use apply().
Compare the iterrows() version with the apply() version to get the same result in the brics DataFrame:
for lab, row in brics.iterrows() :
    brics.loc[lab, "name_length"] = len(row["country"])

brics["name_length"] = brics["country"].apply(len)
We can do a similar thing to call the upper() method on every name in the country column. However, upper() is a method, so we'll need a slightly different approach:


# Import cars data
import pandas as pd
cars = pd.read_csv('cars.csv', index_col = 0)

# Use .apply(str.upper)
for lab, row in cars.iterrows() :
    cars.loc[lab, "COUNTRY"] = row["country"].upper()
    
cars["COUNTRY"] = cars["country"].apply(str.upper)

-----
