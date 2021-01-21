# Connect to a workbook
When working with XLConnect, the first step will be to load a workbook in your R session with loadWorkbook(); this function will build a "bridge" between your Excel file and your R session.
In this and the following exercises, you will continue to work with urbanpop.xlsx, containing urban population data throughout time. The Excel file is available in your current working directory.

# urbanpop.xlsx is available in your working directory
# Load the XLConnect package
library(XLConnect)
# Build connection to urbanpop.xlsx: my_book
my_book <- loadWorkbook("urbanpop.xlsx")
# Print out the class of my_book
class(my_book)

------

# List and read Excel sheets
Just as readxl and gdata, you can use XLConnect to import data from Excel file into R.
To list the sheets in an Excel file, use getSheets(). To actually import data from a sheet, you can use readWorksheet(). Both functions require an XLConnect workbook object as the first argument.
Youll again be working with urbanpop.xlsx. The my_book object that links to this Excel file has already been created.

# XLConnect is already available
# Build connection to urbanpop.xlsx
my_book <- loadWorkbook("urbanpop.xlsx")
# List the sheets in my_book
getSheets(my_book)
# Import the second sheet in my_book
readWorksheet(my_book, sheet = 2)

-----

# Customize readWorksheet
To get a clear overview about urbanpop.xlsx without having to open up the Excel file, you can execute the following code:
my_book <- loadWorkbook("urbanpop.xlsx")
sheets <- getSheets(my_book)
all <- lapply(sheets, readWorksheet, object = my_book)
str(all)
Suppose were only interested in urban population data of the years 1968, 1969 and 1970. The data for these years is in the columns 3, 4, and 5 of the second sheet. Only selecting these columns will leave us in the dark about the actual countries the figures belong to.

# XLConnect is already available
# Build connection to urbanpop.xlsx
my_book <- loadWorkbook("urbanpop.xlsx")
# Import columns 3, 4, and 5 from second sheet in my_book: urbanpop_sel
urbanpop_sel <- readWorksheet(my_book, sheet = 2,startCol = 3,endCol = 5)
# Import first column from second sheet in my_book: countries
countries <- readWorksheet(my_book, sheet = 2, startCol = 1,endCol = 1)
# cbind() urbanpop_sel and countries together: selection
selection <- cbind(countries,urbanpop_sel)

-----

# Add worksheet
Where readxl and gdata were only able to import Excel data, XLConnects approach of providing an actual interface to an Excel file makes it able to edit your Excel files from inside R. In this exercise, you'll create a new sheet. In the next exercise, you'll populate the sheet with data, and save the results in a new Excel file.
Youll continue to work with urbanpop.xlsx. The my_book object that links to this Excel file is already available.

# XLConnect is already available
# Build connection to urbanpop.xlsx
my_book <- loadWorkbook("urbanpop.xlsx")
# Add a worksheet to my_book, named "data_summary"
createSheet(my_book,name="data_summary")
# Use getSheets() on my_book
getSheets(my_book)

-----

# Populate worksheet
The first step of creating a sheet is done; lets populate it with some data now! summ, a data frame with some summary statistics on the two Excel sheets is already coded so you can take it from there.

# XLConnect is already available
# Build connection to urbanpop.xlsx
my_book <- loadWorkbook("urbanpop.xlsx")
# Add a worksheet to my_book, named "data_summary"
createSheet(my_book, "data_summary")
# Create data frame: summ
sheets <- getSheets(my_book)[1:3]
dims <- sapply(sheets, function(x) dim(readWorksheet(my_book, sheet = x)), USE.NAMES = FALSE)
summ <- data.frame(sheets = sheets,
                   nrows = dims[1, ],
                   ncols = dims[2, ])
# Add data in summ to "data_summary" sheet
writeWorksheet(my_book,summ,sheet="data_summary")
# Save workbook as summary.xlsx
saveWorkbook(my_book,"summary.xlsx")

-----

# Renaming sheets
Come to think of it, "data_summary" is not an ideal name. As the summary of these excel sheets is always data-related, you simply want to name the sheet "summary".
The code to build a connection to "urbanpop.xlsx" and create my_book is already provided for you. It refers to an Excel file with 4 sheets: the three data sheets, and the "data_summary" sheet.

# Build connection to urbanpop.xlsx: my_book
my_book <- loadWorkbook("urbanpop.xlsx")
# Rename "data_summary" sheet to "summary"
renameSheet(my_book,"data_summary","summary")
# Print out sheets of my_book
getSheets(my_book)
# Save workbook to "renamed.xlsx"
saveWorkbook(my_book,"renamed.xlsx")

-----

# Removing sheets
After presenting the new Excel sheet to your peers, it appears not everybody is a big fan. Why summarize sheets and store the info in Excel if all the information is implicitly available? To hell with it, just remove the entire fourth sheet!

# Load the XLConnect package
library(XLConnect)
# Build connection to renamed.xlsx: my_book
my_book <- loadWorkbook("renamed.xlsx")
# Remove the fourth sheet
removeSheet(my_book,sheet=4)
# Save workbook to "clean.xlsx"
saveWorkbook(my_book,"clean.xlsx")

-----
