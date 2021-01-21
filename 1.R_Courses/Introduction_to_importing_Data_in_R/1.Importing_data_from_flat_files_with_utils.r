#read.csv
The utils package, which is automatically loaded in your R session on startup, can import CSV files with the read.csv() function.
In this exercise, you'll be working with swimming_pools.csv; it contains data on swimming pools in Brisbane, Australia (Source: data.gov.au). The file contains the column names in the first row. It uses a comma to separate values within rows.
Type dir() in the console to list the files in your working directory. You'll see that it contains swimming_pools.csv, so you can start straight away.

# Import swimming_pools.csv: pools
pools <- read.csv("swimming_pools.csv")
# Print the structure of pools
str(pools)

-----
  
# stringsAsFactors
With stringsAsFactors, you can tell R whether it should convert strings in the flat file to factors.
For all importing functions in the utils package, this argument is TRUE, which means that you import strings as factors. This only makes sense if the strings you import represent categorical variables in R. If you set stringsAsFactors to FALSE, the data frame columns corresponding to strings in your text file will be character.
Youll again be working with the swimming_pools.csv file. It contains two columns (Name and Address), which shouldnt be factors.

# Import swimming_pools.csv correctly: pools
pools <- read.csv("swimming_pools.csv", stringsAsFactors = FALSE)
# Check the structure of pools
str(pools)

-----

# Any changes?
Consider the code below that loads data from swimming_pools.csv in two distinct ways:
# Option A
pools <- read.csv("swimming_pools.csv", stringsAsFactors = TRUE)
# Option B
pools <- read.csv("swimming_pools.csv", stringsAsFactors = FALSE)
How many variables in the resulting pools data frame have different types if you specify the stringsAsFactors argument differently?
The swimming_pools.csv file is available in your current working directory so you can experiment in the console.

# Two variables: Name and Address.

------

# read.delim
Aside from .csv files, there are also the .txt files which are basically text files. You can import these functions with read.delim(). By default, it sets the sep argument to "\t" (fields in a record are delimited by tabs) and the header argument to TRUE (the first row contains the field names).
In this exercise, you will import hotdogs.txt, containing information on sodium and calorie levels in different hotdogs (Source: UCLA). The dataset has 3 variables, but the variable names are not available in the first line of the file. The file uses tabs as field separators.

# Import hotdogs.txt: hotdogs
hotdogs <- read.delim("hotdogs.txt", header = FALSE)
# Summarize hotdogs
summary(hotdogs)

-----

# read.table
If youre dealing with more exotic flat file formats, youll want to use read.table(). Its the most basic importing function; you can specify tons of different arguments in this function. Unlike read.csv() and read.delim(), the header argument defaults to FALSE and the sep argument is "" by default.
Up to you again! The data is still hotdogs.txt. It has no column names in the first row, and the field separators are tabs. This time, though, the file is in the data folder inside your current working directory. A variable path with the location of this file is already coded for you.

# Path to the hotdogs.txt file: path
path <- file.path("data", "hotdogs.txt")
# Import the hotdogs.txt file: hotdogs
hotdogs <- read.table(path, 
                      sep = "\t", 
                      col.names = c("type", "calories", "sodium"))
# Call head() on hotdogs
head(hotdogs)

-----

# Arguments
Lily and Tom are having an argument because they want to share a hot dog but they cant seem to agree on which one to choose. After some time, they simply decide that they will have one each. Lily wants to have the one with the fewest calories while Tom wants to have the one with the most sodium.
Next to calories and sodium, the hotdogs have one more variable: type. This can be one of three things: Beef, Meat, or Poultry, so a categorical variable: a factor is fine.

# Finish the read.delim() call
hotdogs <- read.delim("hotdogs.txt", header = FALSE,
                      col.names = c("type", "calories", "sodium"))
# Select the hot dog with the least calories: lily
lily <- hotdogs[which.min(hotdogs$calories), ]
# Select the observation with the most sodium: tom
tom <- hotdogs[which.max(hotdogs$sodium),]
# Print lily and tom
lily 
tom

-----

# Column classes
Next to column names, you can also specify the column types or column classes of the resulting data frame. 
You can do this by setting the colClasses argument to a vector of strings representing classes:
read.delim("my_file.txt", 
           colClasses = c("character",
                          "numeric",
                          "logical"))
This approach can be useful if you have some columns that should be factors and others that should be characters. You dont have to bother with stringsAsFactors anymore; just state for each column what the class should be.
If a column is set to "NULL" in the colClasses vector, this column will be skipped and will not be loaded into the data frame.

# Previous call to import hotdogs.txt
hotdogs <- read.delim("hotdogs.txt", header = FALSE, col.names = c("type", "calories", "sodium"))
# Display structure of hotdogs
str(hotdogs)
# Edit the colClasses argument to import the data correctly: hotdogs2
hotdogs2 <- read.delim("hotdogs.txt", header = FALSE, 
                       col.names = c("type", "calories", "sodium"),
                       colClasses = c("factor", "NULL", "numeric"))
# Display structure of hotdogs2
str(hotdogs2)

-----
