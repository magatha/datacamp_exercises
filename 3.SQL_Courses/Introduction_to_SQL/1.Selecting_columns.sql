/*
Onboarding | Tables
If you've used DataCamp to learn R or Python, you'll be familiar with the interface. For SQL, however, there are a few new features you should be aware of.
For this course, you'll be using a database containing information on almost 5000 films. To the right, underneath the editor, you can see the data in this database by clicking through the tabs.
From looking at the tabs, who is the first person listed in the people table?
*/
/*
50 Cent
*/

-----

/*
Onboarding | Query Result
Notice the query result tab in the bottom right corner of your screen. This is where the results of your SQL queries will be displayed.
Run this query in the editor and check out the resulting table in the query result tab!
Who is the second person listed in the query result?
*/
SELECT name 
FROM people;
/*
A. Michael Baldwin
*/

-----

/*
Onboarding | Errors
If you submit the code to the right, you'll see that you get two types of errors.
SQL errors are shown below the editor. These are errors returned by the SQL engine. You should see:
syntax error at or near "'DataCamp <3 SQL'" LINE 2: 'DataCamp <3 SQL' ^

DataCamp errors are shown in the Instructions box. These will let you know in plain English where you went wrong in your code! You should see:
You need to add SELECT at the start of line 2!
*/
-- Try running me!
SELECT 'DataCamp <3 SQL'
AS result;

-----

/*
Onboarding | Bullet Exercises
Another new feature we're introducing is the bullet exercise, which allows you to easily practice a new concept through repetition. Check it out below!
*/
SELECT 'SQL'
AS result;

SELECT 'SQL is'
AS result;

SELECT 'SQL is cool'
AS result;

-----

/*
Beginning your SQL journey
Now that you're familiar with the interface, let's get straight into it.
SQL, which stands for Structured Query Language, is a language for interacting with data stored in something called a relational database.
You can think of a relational database as a collection of tables. A table is just a set of rows and columns, like a spreadsheet, which represents exactly one type of entity. For example, a table might represent employees in a company or purchases made, but not both.
Each row, or record, of a table contains information about a single entity. For example, in a table representing employees, each row represents a single person. Each column, or field, of a table contains a single attribute for all rows in the table. For example, in a table representing employees, we might have a column containing first and last names for all employees.
*/
/*
4
*/

-----
/*
SELECTing single columns
While SQL can be used to create and modify databases, the focus of this course will be querying databases. A query is a request for data from a database table (or combination of tables). Querying is an essential skill for a data scientist, since the data you need for your analyses will often live in databases.

In SQL, you can select data from a table using a SELECT statement. For example, the following query selects the name column from the people table:
SELECT name
FROM people;

In this query, SELECT and FROM are called keywords. In SQL, keywords are not case-sensitive, which means you can write the same query as:
select name
from people;

That said, it's good practice to make SQL keywords uppercase to distinguish them from other parts of your query, like column and table names.
It's also good practice (but not necessary for the exercises in this course) to include a semicolon at the end of your query. This tells SQL where the end of your query is!
Remember, you can see the results of executing your query in the query tab!
*/
SELECT title
FROM films;

SELECT release_year
FROM films;

SELECT name
FROM people;

-----

/*
SELECTing multiple columns
Well done! Now you know how to select single columns.

In the real world, you will often want to select multiple columns. Luckily, SQL makes this really easy. To select multiple columns from a table, simply separate the column names with commas!
For example, this query selects two columns, name and birthdate, from the people table:
SELECT name, birthdate
FROM people;

Sometimes, you may want to select all columns from a table. Typing out every column name would be a pain, so there's a handy shortcut:
SELECT *
FROM people;

If you only want to return a certain number of results, you can use the LIMIT keyword to limit the number of rows returned:
SELECT *
FROM people
LIMIT 10;

Before getting started with the instructions below, check out the column names in the films table!
*/

SELECT *
FROM films;

SELECT title, release_year
FROM films;

SELECT title, release_year, country
FROM films;

SELECT *
FROM films;

-----

/*
SELECT DISTINCT
Often your results will include many duplicate values. If you want to select all the unique values from a column, you can use the DISTINCT keyword.

This might be useful if, for example, you're interested in knowing which languages are represented in the films table:
SELECT DISTINCT language
FROM films;

Remember, you can check out the data in the tables by clicking on the table name!
*/
SELECT DISTINCT country
FROM films;

SELECT DISTINCT certification
FROM films;

SELECT DISTINCT role
FROM roles;

-----

/*
Learning to COUNT
What if you want to count the number of employees in your employees table? The COUNT statement lets you do this by returning the number of rows in one or more columns.

For example, this code gives the number of rows in the people table:
SELECT COUNT(*)
FROM people;

How many records are contained in the reviews table?
*/
/*
4,968
*/

-----

/*
Practice with COUNT
As you've seen, COUNT(*) tells you how many rows are in a table. However, if you want to count the number of non-missing values in a particular column, you can call COUNT on just that column.

For example, to count the number of birth dates present in the people table:
SELECT COUNT(birthdate)
FROM people;

It's also common to combine COUNT with DISTINCT to count the number of distinct values in a column.
For example, this query counts the number of distinct birth dates contained in the people table:
SELECT COUNT(DISTINCT birthdate)
FROM people;

Let's get some practice with COUNT!
*/

SELECT COUNT(*)
FROM people;

SELECT COUNT(birthdate)
FROM people;

SELECT COUNT(DISTINCT birthdate)
FROM people;

SELECT COUNT (DISTINCT language)
FROM films;

SELECT COUNT(DISTINCT country)
FROM films;

-----
