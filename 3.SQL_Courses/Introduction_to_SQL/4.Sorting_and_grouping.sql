
/*
ORDER BY
Congratulations on making it this far! You now know how to select and filter your results.
In this chapter you'll learn how to sort and group your results to gain further insight. Let's go!
In SQL, the ORDER BY keyword is used to sort results in ascending or descending order according to the values of one or more columns.

By default ORDER BY will sort in ascending order. If you want to sort the results in descending order, you can use the DESC keyword. For example,
SELECT title
FROM films
ORDER BY release_year DESC;
gives you the titles of films sorted by release year, from newest to oldest.

How do you think ORDER BY sorts a column of text values by default?
*/
/*
Alphabetically (A-Z)
*/

-----

/*
Sorting single columns
Now that you understand how ORDER BY works, give these exercises a go!
*/

SELECT name
FROM people
ORDER BY name ;

SELECT name 
FROM people
ORDER BY birthdate;

SELECT name, birthdate
FROM people
ORDER BY birthdate;

-----

/*
Sorting single columns (2)
Let's get some more practice with ORDER BY!
*/

SELECT title
FROM films
WHERE (release_year=2000 OR release_year=2012)
ORDER BY release_year;

SELECT *
FROM films
WHERE release_year <> 2015
ORDER BY duration;

SELECT title, gross
FROM films
WHERE title LIKE 'M%'
ORDER BY title;

-----

/*
Sorting single columns (DESC)
To order results in descending order, you can put the keyword DESC after your ORDER BY. 

For example, to get all the names in the people table, in reverse alphabetical order:
SELECT name
FROM people
ORDER BY name DESC;

Now practice using ORDER BY with DESC to sort single columns in descending order!
*/

SELECT imdb_score, film_id
FROM reviews
ORDER BY imdb_score DESC;

SELECT title
FROM films
ORDER by title DESC;

SELECT title, duration
FROM films
ORDER BY duration DESC;

-----

/*
Sorting multiple columns
ORDER BY can also be used to sort on multiple columns. It will sort by the first column specified, then sort by the next, then the next, and so on. 

For example,
SELECT birthdate, name
FROM people
ORDER BY birthdate, name;
sorts on birth dates first (oldest to newest) and then sorts on the names in alphabetical order. The order of columns is important!

Try using ORDER BY to sort multiple columns! Remember, to specify multiple columns you separate the column names with a comma.
*/

SELECT birthdate, name
FROM people
ORDER BY birthdate, name;

SELECT release_year, duration, title
FROM films
ORDER BY release_year, duration;

SELECT certification, release_year, title
FROM films
ORDER BY certification, release_year

SELECT name, birthdate
FROM people
ORDER BY name, birthdate

-----

/*
GROUP BY
Now you know how to sort results! Often you'll need to aggregate results. For example, you might want to count the number of male and female employees in your company. Here, what you want is to group all the males together and count them, and group all the females together and count them. 

In SQL, GROUP BY allows you to group a result by one or more columns, like so:
SELECT sex, count(*)
FROM employees
GROUP BY sex;

This might give, for example:
sex	count
male	15
female	19

Commonly, GROUP BY is used with aggregate functions like COUNT() or MAX(). Note that GROUP BY always goes after the FROM clause!

What is GROUP BY used for?
*/
/*
Performing operations by group
*/

-----

/*
GROUP BY practice
As you've just seen, combining aggregate functions with GROUP BY can yield some powerful results!
A word of warning: SQL will return an error if you try to SELECT a field that is not in your GROUP BY clause without using it to calculate some kind of value about the entire group.

Note that you can combine GROUP BY with ORDER BY to group your results, calculate something about them, and then order your results. 

For example,
SELECT sex, count(*)
FROM employees
GROUP BY sex
ORDER BY count DESC;

might return something like
sex	count
female	19
male	15

because there are more females at our company than males. Note also that ORDER BY always goes after GROUP BY. Let's try some exercises!
*/

SELECT release_year, count(*)
FROM films
GROUP BY release_year;

SELECT release_year, AVG(duration)
FROM films
GROUP BY release_year

SELECT release_year, MAX(budget)
FROM films
GROUP BY release_year

SELECT imdb_score, count(*)
FROM reviews
GROUP BY imdb_score

-----

/*
GROUP BY practice (2)
Now practice your new skills by combining GROUP BY and ORDER BY with some more aggregate functions!
Make sure to always put the ORDER BY clause at the end of your query. You can't sort values that you haven't calculated yet!
*/

SELECT release_year, MIN(gross)
FROM films
GROUP BY release_year

SELECT language, SUM(gross)
FROM films
GROUP BY language

SELECT country, SUM (budget)
FROM films
GROUP BY country

SELECT release_year, country, MAX(budget)
FROM films
GROUP BY release_year, country
ORDER BY release_year, country

SELECT country, release_year, MIN(gross)
FROM films
GROUP BY release_year, country
ORDER BY country, release_year

-----

/*
HAVING a great time
In SQL, aggregate functions can't be used in WHERE clauses. For example, the following query is invalid:
SELECT release_year
FROM films
GROUP BY release_year
WHERE COUNT(title) > 10;

This means that if you want to filter based on the result of an aggregate function, you need another way! That's where the HAVING clause comes in. 

For example,
SELECT release_year
FROM films
GROUP BY release_year
HAVING COUNT(title) > 10;
shows only those years in which more than 10 films were released.

In how many different years were more than 200 movies released?
*/
/*
13
*/

-----

/*
All together now
Time to practice using ORDER BY, GROUP BY and HAVING together.
Now you're going to write a query that returns the average budget and average gross earnings for films in each year after 1990, if the average budget is greater than $60 million.
This is going to be a big query, but you can handle it!
*/

SELECT release_year, budget, gross
FROM films

SELECT release_year, budget, gross
FROM films
WHERE release_year > 1990

SELECT release_year
FROM films
WHERE release_year > 1990
GROUP BY release_year;

SELECT release_year, AVG(budget) as avg_budget, AVG(gross) as avg_gross
FROM films
WHERE release_year > 1990
GROUP BY release_year;

SELECT release_year, AVG(budget) AS avg_budget, AVG(gross) AS avg_gross
FROM films
WHERE release_year > 1990
GROUP BY release_year
HAVING AVG(budget) > 60000000

SELECT release_year, AVG(budget) AS avg_budget, AVG(gross) AS avg_gross
FROM films
WHERE release_year > 1990
GROUP BY release_year
HAVING AVG(budget) > 60000000
ORDER BY AVG(gross) DESC;

-----

/*
All together now (2)
Great work! Now try another large query. This time, all in one go!
Remember, if you only want to return a certain number of results, you can use the LIMIT keyword to limit the number of rows returned
*/

-- select country, average budget, 
--     and average gross
SELECT country, AVG(budget) as avg_budget, AVG(gross) as avg_gross
-- from the films table
FROM films
-- group by country 
GROUP BY country
-- where the country has more than 10 titles
HAVING count(title)>10
-- order by country
ORDER BY country
-- limit to only show 5 results
LIMIT 5;

-----

/*
A taste of things to come
Congrats on making it to the end of the course! By now you should have a good understanding of the basics of SQL.
There's one more concept we're going to introduce. You may have noticed that all your results so far have been from just one table, e.g. films or people.
In the real world however, you will often want to query multiple tables. For example, what if you want to see the IMDB score for a particular movie?
In this case, you'd want to get the ID of the movie from the films table and then use it to get IMDB information from the reviews table. In SQL, this concept is known as a join, and a basic join is shown in the editor to the right.
The query in the editor gets the IMDB score for the film To Kill a Mockingbird! Cool right?
As you can see, joins are incredibly useful and important to understand for anyone using SQL.
We have a whole follow-up course dedicated to them called Joining Data in PostgreSQL for you to hone your database skills further!
*/

SELECT title, imdb_score
FROM films
JOIN reviews
ON films.id = reviews.film_id
WHERE title = 'To Kill a Mockingbird';

/*
8.4
*/

-----
