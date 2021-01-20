/*
Aggregate functions
Often, you will want to perform some calculation on the data in a database. SQL provides a few functions, called aggregate functions, to help you out with this.

For example, it gives you the average value from the budget column of the films table. Similarly, the MAX function returns the highest budget:
SELECT AVG(budget)
FROM films;

SELECT MAX(budget)
FROM films;
The SUM function returns the result of adding up the numeric values in a column:

SELECT SUM(budget)
FROM films;
You can probably guess what the MIN function does! Now it's your turn to try out some SQL functions.
*/

SELECT SUM(duration)
FROM films;

SELECT AVG(duration)
FROM films;

SELECT MIN(duration)
FROM films;

SELECT MAX(duration)
FROM films;

-----
/*
Aggregate functions practice
Good work. Aggregate functions are important to understand, so let's get some more practice!
*/

SELECT SUM(gross)
FROM films;

SELECT AVG(gross)
FROM films;

SELECT MIN(gross)
FROM films;

SELECT MAX(gross)
FROM films;

-----

/*
Combining aggregate functions with WHERE
Aggregate functions can be combined with the WHERE clause to gain further insights from your data.

For example, to get the total budget of movies made in the year 2010 or later:
SELECT SUM(budget)
FROM films
WHERE release_year >= 2010;

Now it's your turn!
*/

SELECT SUM(gross)
FROM films
WHERE release_year >=2000;

SELECT AVG(gross)
FROM films
WHERE title LIKE 'A%';

SELECT MIN(gross)
FROM films
WHERE release_year=1994;

SELECT MAX(gross)
FROM films
WHERE release_year BETWEEN 2000 AND 2012;

-----

/*
A note on arithmetic
In addition to using aggregate functions, you can perform basic arithmetic with symbols like +, -, *, and /.

So, for example, this gives a result of 12:
SELECT (4 * 3);

However, the following gives a result of 1:
SELECT (4 / 3);

What's going on here?
SQL assumes that if you divide an integer by an integer, you want to get an integer back. So be careful when dividing!
If you want more precision when dividing, you can add decimal places to your numbers. 

For example,
SELECT (4.0 / 3.0) AS result;
gives you the result you would expect: 1.333.

What is the result of SELECT (10 / 3);?
*/
/*
3
*/

-----

/*
It's AS simple AS aliasing
You may have noticed in the first exercise of this chapter that the column name of your result was just the name of the function you used. 

For example,
SELECT MAX(budget)
FROM films;
gives you a result with one column, named max. 

But what if you use two functions like this?
SELECT MAX(budget), MAX(duration)
FROM films;

Well, then you'd have two columns named max, which isn't very useful!
To avoid situations like this, SQL allows you to do something called aliasing. Aliasing simply means you assign a temporary name to something. To alias, you use the AS keyword, which you've already seen earlier in this course.

For example, in the above example we could use aliases to make the result clearer:
SELECT MAX(budget) AS max_budget,
       MAX(duration) AS max_duration
FROM films;

Aliases are helpful for making results more readable!
*/

SELECT title, (gross-budget) AS net_profit FROM films

SELECT title, duration/60.0 AS duration_hours FROM films

SELECT AVG(duration) /60.0 AS avg_duration_hours FROM films

-----

/*
Even more aliasing
Let's practice your newfound aliasing skills some more before moving on!
Recall: SQL assumes that if you divide an integer by an integer, you want to get an integer back.

This means that the following will erroneously result in 400.0:
SELECT 45 / 10 * 100.0;

This is because 45 / 10 evaluates to an integer (4), and not a decimal number like we would expect.
So when you're dividing make sure at least one of your numbers has a decimal place:
SELECT 45 * 100.0 / 10;

The above now gives the correct answer of 450.0 since the numerator (45 * 100.0) of the division is now a decimal!
*/

SELECT COUNT(deathdate) * 100.0 / COUNT(*) AS percentage_dead FROM people

SELECT MAX(release_year) - MIN(release_year) AS difference FROM films

SELECT (MAX(release_year) - MIN(release_year)) / 10.0 AS number_of_decades FROM films

----
