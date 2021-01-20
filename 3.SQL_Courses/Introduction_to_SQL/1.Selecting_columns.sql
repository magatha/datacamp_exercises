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

