# read_csv
CSV files can be imported with read_csv(). Its a wrapper function around read_delim() that handles all the details for you. For example, it will assume that the first row contains the column names.
The dataset youll be working with here is potatoes.csv. It gives information on the impact of storage period and cooking on potatoes flavor. It uses commas to delimit fields in a record, and contains column names in the first row. The file is available in your workspace. Remember that you can inspect your workspace with dir().

# Load the readr package
library(readr)
# Import potatoes.csv with read_csv(): potatoes
potatoes <- read_csv("potatoes.csv")

------

# read_tsv
Where you use read_csv() to easily read in CSV files, you use read_tsv() to easily read in TSV files. TSV is short for tab-separated values.
This time, the potatoes data comes in the form of a tab-separated values file; potatoes.txt is available in your workspace. In contrast to potatoes.csv, this file does not contain columns names in the first row, though.
Theres a vector properties that you can use to specify these column names manually.

# readr is already loaded
# Column names
properties <- c("area", "temp", "size", "storage", "method",
                "texture", "flavor", "moistness")
# Import potatoes.txt: potatoes
potatoes <- read_tsv("potatoes.txt", col_names = properties)
# Call head() on potatoes
head(potatoes)

-----

# read_delim
Just as read.table() was the main utils function, read_delim() is the main readr function.
read_delim() takes two mandatory arguments:
file: the file that contains the data
delim: the character that separates the values in the data file
Youll again be working potatoes.txt; the file uses tabs ("\t") to delimit values and does not contain column names in its first line. Its available in your working directory so you can start right away. As before, the vector properties is available to set the col_names.

# readr is already loaded
# Column names
properties <- c("area", "temp", "size", "storage", "method",
                "texture", "flavor", "moistness")
# Import potatoes.txt using read_delim(): potatoes
potatoes <- read_delim("potatoes.txt", delim = "\t", col_names = properties)
# Print out potatoes
potatoes

-----

# skip and n_max
Through skip and n_max you can control which part of your flat file youre actually importing into R.
skip specifies the number of lines youre ignoring in the flat file before actually starting to import data.
n_max specifies the number of lines youre actually importing.
Say for example you have a CSV file with 20 lines, and set skip = 2 and n_max = 3, youre only reading in lines 3, 4 and 5 of the file.
Watch out: Once you skip some lines, you also skip the first line that can contain column names!
potatoes.txt, a flat file with tab-delimited records and without column names, is available in your workspace.

# readr is already loaded
# Column names
properties <- c("area", "temp", "size", "storage", "method",
                "texture", "flavor", "moistness")
# Import 5 observations from potatoes.txt: potatoes_fragment
potatoes_fragment <- read_tsv("potatoes.txt", skip = 6,
                              n_max = 5, col_names = properties)

-----

# col_types
You can also specify which types the columns in your imported data frame should have. You can do this with col_types. If set to NULL, the default, functions from the readr package will try to find the correct types themselves. You can manually set the types with a string, where each character denotes the class of the column: character, double, integer and logical. _ skips the column as a whole.
potatoes.txt, a flat file with tab-delimited records and without column names, is again available in your workspace.

# readr is already loaded
# Column names
properties <- c("area", "temp", "size", "storage", "method",
                "texture", "flavor", "moistness")
# Import all data, but force all columns to be character: potatoes_char
potatoes_char <- read_tsv("potatoes.txt", col_types = "cccccccc", col_names = properties)
# Print out structure of potatoes_char
str(potatoes_char)

-----

# col_types with collectors
Another way of setting the types of the imported columns is using collectors. Collector functions can be passed in a list() to the col_types argument of read_ functions to tell them how to interpret values in a column.
For a complete list of collector functions, you can take a look at the collector documentation. For this exercise you will need two collector functions:
col_integer(): the column should be interpreted as an integer.
col_factor(levels, ordered = FALSE): the column should be interpreted as a factor with levels.
In this exercise, you will work with hotdogs.txt, which is a tab-delimited file without column names in the first row.

# readr is already loaded
# Import without col_types
hotdogs <- read_tsv("hotdogs.txt", col_names = c("type", "calories", "sodium"))
# Display the summary of hotdogs
summary(hotdogs)
# The collectors you will need to import the data
fac <- col_factor(levels = c("Beef", "Meat", "Poultry"))
int <- col_integer()
# Edit the col_types argument to import the data correctly: hotdogs_factor
hotdogs_factor <- read_tsv("hotdogs.txt",
                           col_names = c("type", "calories", "sodium"),
                           col_types = list(fac, int, int))
# Display the summary of hotdogs_factor
summary(hotdogs_factor)

-----

# fread
You still remember how to use read.table(), right? Well, fread() is a function that does the same job with very similar arguments. It is extremely easy to use and blazingly fast! Often, simply specifying the path to the file is enough to successfully import your data.
Dont take our word for it, try it yourself! Youll be working with the potatoes.csv file, thats available in your workspace. Fields are delimited by commas, and the first line contains the column names.

# load the data.table package using library()
library(data.table)
# Import potatoes.csv with fread(): potatoes
potatoes <- fread ("potatoes.csv")
# Print out potatoes
potatoes

-----

# fread: more advanced use
Now that you know the basics about fread(), you should know about two arguments of the function: drop and select, to drop or select variables of interest.
Suppose you have a dataset that contains 5 variables and you want to keep the first and fifth variable, named "a" and "e". The following options will all do the trick:
fread("path/to/file.txt", drop = 2:4)
fread("path/to/file.txt", select = c(1, 5))
fread("path/to/file.txt", drop = c("b", "c", "d"))
fread("path/to/file.txt", select = c("a", "e"))
Let's stick with potatoes since we're particularly fond of them here at DataCamp. The data is again available in the file potatoes.csv, containing comma-separated records.

# fread is already loaded
# Import columns 6 and 8 of potatoes.csv: potatoes
potatoes <- fread("potatoes.csv", select = c(6, 8))
# Plot texture (x) and moistness (y) of potatoes
plot(potatoes$texture, potatoes$moistness)

------

# Dedicated classes
You might have noticed that the fread() function produces data frames that look slightly different when you print them out. Thats because another class named data.table is assigned to the resulting data frames. The printout of such data.table objects is different. Does something similar happen with the data frames generated by readr?
In your current working directory, we prepared the potatoes.csv file. The packages data.table and readr are both loaded, so you can experiment straight away.
Which of the following statements is true?

# The class of the result of fread() is both data.table and data.frame. read_csv() creates an object with three classes: tbl_df, tbl and data.frame.

-----
