
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
