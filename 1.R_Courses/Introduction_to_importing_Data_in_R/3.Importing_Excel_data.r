# List the sheets of an Excel file
Before you can start importing from Excel, you should find out which sheets are available in the workbook. You can use the excel_sheets() function for this.
You will find the Excel file urbanpop.xlsx in your working directory (type dir() to see it). This dataset contains urban population metrics for practically all countries in the world throughout time (Source: Gapminder). It contains three sheets for three different time periods. In each sheet, the first row contains the column names.

# Load the readxl package
library(readxl)
# Print the names of all worksheets
excel_sheets("urbanpop.xlsx")

-----

# Import an Excel sheet
Now that you know the names of the sheets in the Excel file you want to import, it is time to import those sheets into R. You can do this with the read_excel() function. Have a look at this recipe:
data <- read_excel("data.xlsx", sheet = "my_sheet")
This call simply imports the sheet with the name "my_sheet" from the "data.xlsx" file. You can also pass a number to the sheet argument; this will cause read_excel() to import the sheet with the given sheet number. sheet = 1 will import the first sheet, sheet = 2 will import the second sheet, and so on.
In this exercise, youll continue working with the urbanpop.xlsx file.

# The readxl package is already loaded
# Read the sheets, one by one
pop_1 <- read_excel("urbanpop.xlsx", sheet = 1)
pop_2 <- read_excel("urbanpop.xlsx", sheet = 2)
pop_3 <- read_excel("urbanpop.xlsx", sheet = 3)
# Put pop_1, pop_2 and pop_3 in a list: pop_list
pop_list <- list(pop_1, pop_2, pop_3)
# Display the structure of pop_list
str(pop_list)

-----

# Reading a workbook
In the previous exercise you generated a list of three Excel sheets that you imported. However, loading in every sheet manually and then merging them in a list can be quite tedious. Luckily, you can automate this with lapply(). If you have no experience with lapply(), feel free to take Chapter 4 of the Intermediate R course.
Have a look at the example code below:
my_workbook <- lapply(excel_sheets("data.xlsx"),
                      read_excel,
                      path = "data.xlsx")
The read_excel() function is called multiple times on the "data.xlsx" file and each sheet is loaded in one after the other. The result is a list of data frames, each data frame representing one of the sheets in data.xlsx.
Youre still working with the urbanpop.xlsx file.

# The readxl package is already loaded
# Read all Excel sheets with lapply(): pop_list
pop_list <- lapply(excel_sheets("urbanpop.xlsx"), read_excel, path="urbanpop.xlsx")
# Display the structure of pop_list
str(pop_list)

-----

# The col_names argument
Apart from path and sheet, there are several other arguments you can specify in read_excel(). One of these arguments is called col_names.
By default it is TRUE, denoting whether the first row in the Excel sheets contains the column names. If this is not the case, you can set col_names to FALSE. In this case, R will choose column names for you. You can also choose to set col_names to a character vector with names for each column. It works exactly the same as in the readr package.
Youll be working with the urbanpop_nonames.xlsx file. It contains the same data as urbanpop.xlsx but has no column names in the first row of the excel sheets.

# The readxl package is already loaded
# Import the first Excel sheet of urbanpop_nonames.xlsx (R gives names): pop_a
pop_a <- read_excel("urbanpop_nonames.xlsx", sheet=1, col_names = FALSE)
# Import the first Excel sheet of urbanpop_nonames.xlsx (specify col_names): pop_b
cols <- c("country", paste0("year_", 1960:1966))
pop_b <- read_excel("urbanpop_nonames.xlsx", sheet=1, col_names=cols)
# Print the summary of pop_a
summary(pop_a)
# Print the summary of pop_b
summary(pop_b)

-----

#The skip argument
Another argument that can be very useful when reading in Excel files that are less tidy, is skip. With skip, you can tell R to ignore a specified number of rows inside the Excel sheets youre trying to pull data from. Have a look at this example:
read_excel("data.xlsx", skip = 15)
In this case, the first 15 rows in the first sheet of "data.xlsx" are ignored.
If the first row of this sheet contained the column names, this information will also be ignored by readxl. Make sure to set col_names to FALSE or manually specify column names in this case!
The file urbanpop.xlsx is available in your directory; it has column names in the first rows.

# The readxl package is already loaded
# Import the second sheet of urbanpop.xlsx, skipping the first 21 rows: urbanpop_sel
urbanpop_sel <- read_excel("urbanpop.xlsx", sheet=2, skip=21, col_names=FALSE)
# Print out the first observation from urbanpop_sel
urbanpop_sel [1,]

-----

# Import a local file
In this part of the chapter youll learn how to import .xls files using the gdata package. Similar to the readxl package, you can import single Excel sheets from Excel sheets to start your analysis in R.
Youll be working with the urbanpop.xls dataset, the .xls version of the Excel file you've been working with before. It's available in your current working directory.

# Load the gdata package
library(gdata)
# Import the second sheet of urbanpop.xls: urban_pop
urban_pop <- read.xls("urbanpop.xls", sheet = "1967-1974")
# Print the first 11 observations using head()
head(urban_pop, 11)

-----

# read.xls() wraps around read.table()
Remember how read.xls() actually works? It basically comes down to two steps: converting the Excel file to a .csv file using a Perl script, and then reading that .csv file with the read.csv() function that is loaded by default in R, through the utils package.
This means that all the options that you can specify in read.csv(), can also be specified in read.xls().
The urbanpop.xls dataset is already available in your workspace. Its still comprised of three sheets, and has column names in the first row of each sheet.

# The gdata package is alreaded loaded
# Column names for urban_pop
columns <- c("country", paste0("year_", 1967:1974))
# Finish the read.xls call
urban_pop <- read.xls("urbanpop.xls", sheet = 2,
                      skip = 50, header = FALSE, stringsAsFactors = FALSE,
                      col.names = columns)
# Print first 10 observation of urban_pop
head(urban_pop, 10)

-----

# Work that Excel data!
Now that you can read in Excel data, lets try to clean and merge it. You already used the cbind() function some exercises ago. Lets take it one step further now.
The urbanpop.xls dataset is available in your working directory. The file still contains three sheets, and has column names in the first row of each sheet.

# Add code to import data from all three sheets in urbanpop.xls
path <- "urbanpop.xls"
urban_sheet1 <- read.xls(path, sheet = 1, stringsAsFactors = FALSE)
urban_sheet2 <- read.xls(path, sheet = 2, stringsAsFactors = FALSE)
urban_sheet3 <- read.xls(path, sheet=3, stringsAsFactors = FALSE)
# Extend the cbind() call to include urban_sheet3: urban
urban <- cbind(urban_sheet1, urban_sheet2[-1], urban_sheet3[-1])
# Remove all rows with NAs from urban: urban_clean
urban_clean <- na.omit(urban)
# Print out a summary of urban_clean
summary(urban_clean)

-----
