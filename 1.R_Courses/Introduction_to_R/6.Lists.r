# Lists, why would you need them?
Congratulations! At this point in the course you are already familiar with:

Vectors (one dimensional array): can hold numeric, character or logical values. The elements in a vector all have the same data type.
Matrices (two dimensional array): can hold numeric, character or logical values. The elements in a matrix all have the same data type.
Data frames (two-dimensional objects): can hold numeric, character or logical values. Within a column all elements have the same data type, but different columns can be of different data type.
Pretty sweet for an R newbie, right? ;-)

# Just submit the answer

-----

# Lists, why would you need them? (2)
A list in R is similar to your to-do list at work or school: the different items on that list most likely differ in length, characteristic, and type of activity that has to be done.
A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
You could say that a list is some kind super data type: you can store practically any piece of information in it!

# Just submit the answer to start the first exercise on lists.

-----

# Creating a list
Let us create our first list! To construct a list you use the function list():
my_list <- list(comp1, comp2 ...)
The arguments to the list function are the list components. Remember, these components can be matrices, vectors, other lists, …

# Vector with numerics from 1 up to 10
my_vector <- 1:10 
# Matrix with numerics from 1 up to 9
my_matrix <- matrix(1:9, ncol = 3)
# First 10 elements of the built-in data frame mtcars
my_df <- mtcars[1:10,]
# Construct list with these different elements:
my_list <- list(my_vector, my_matrix, my_df)

-----

# Creating a named list
Well done, youre on a roll!
Just like on your to-do list, you want to avoid not knowing or remembering what the components of your list stand for. That is why you should give names to them:
my_list <- list(name1 = your_comp1, 
                name2 = your_comp2)
This creates a list with components that are named name1, name2, and so on. If you want to name your lists after youve created them, you can use the names() function as you did with vectors. The following commands are fully equivalent to the assignment above:
my_list <- list(your_comp1, your_comp2)
names(my_list) <- c("name1", "name2")

# Vector with numerics from 1 up to 10
my_vector <- 1:10 
# Matrix with numerics from 1 up to 9
my_matrix <- matrix(1:9, ncol = 3)
# First 10 elements of the built-in data frame mtcars
my_df <- mtcars[1:10,]
# Adapt list() call to give the components names
my_list <- list(vec = my_vector, mat = my_matrix, df = my_df)
# Print out my_list
my_list

-----

# Creating a named list (2)
Being a huge movie fan (remember your job at LucasFilms), you decide to start storing information on good movies with the help of lists.
Start by creating a list for the movie "The Shining". We have already created the variables mov, act and rev in your R workspace. Feel free to check them out in the console.
Instructions
100 XP
Complete the code in the editor to create shining_list; it contains three elements:
moviename: a character string with the movie title (stored in mov)
actors: a vector with the main actors names (stored in act)
reviews: a data frame that contains some reviews (stored in rev)
Do not forget to name the list components accordingly (names are moviename, actors and reviews).

# The variables mov, act and rev are available
# Finish the code to build shining_list
shining_list <- list(moviename = mov, actors = act, reviews = rev)

-----

# Selecting elements from a list
Your list will often be built out of numerous elements and components. Therefore, getting a single element, multiple elements, or a component out of it is not always straightforward.
One way to select a component is using the numbered position of that component. For example, to "grab" the first component of shining_list you type
shining_list[[1]]
A quick way to check this out is typing it in the console. Important to remember: to select elements from vectors, you use single square brackets: [ ]. Dont mix them up!
You can also refer to the names of the components, with [[ ]] or with the $ sign. Both will select the data frame representing the reviews:
shining_list[["reviews"]]
shining_list$reviews
Besides selecting components, you often need to select specific elements out of these components. For example, with shining_list[[2]][1] you select from the second component, actors (shining_list[[2]]), the first element ([1]). When you type this in the console, you will see the answer is Jack Nicholson.

# shining_list is already pre-loaded in the workspace
# Print out the vector representing the actors
shining_list$actors
# Print the second element of the vector representing the actors
shining_list$actors[2]

-----

# Creating a new list for another movie
You found reviews of another, more recent, Jack Nicholson movie: The Departed!
Scores	Comments
4.6	I would watch it again
5	Amazing!
4.8	I liked it
5	One of the best movies
4.2	Fascinating plot
It would be useful to collect together all the pieces of information about the movie, like the title, actors, and reviews into a single variable. Since these pieces of data are different shapes, it is natural to combine them in a list variable.
movie_title, containing the title of the movie, and movie_actors, containing the names of some of the actors in the movie, are available in your workspace.

# Use the table from the exercise to define the comments and scores vectors
scores <- c(4.6, 5, 4.8, 5, 4.2)
comments <- c("I would watch it again", "Amazing!", "I liked it", "One of the best movies", "Fascinating plot")
# Save the average of the scores vector as avg_review 
avg_review <- mean(scores)
# Combine scores and comments into the reviews_df data frame
reviews_df <- data.frame(scores, comments)
# Create and print out a list, called departed_list
departed_list <- list(movie_title, movie_actors, reviews_df, avg_review)
departed_list

-----
