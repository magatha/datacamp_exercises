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






