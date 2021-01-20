/*
Union
Near query result to the right, you will see two new tables with names economies2010 and economies2015.
*/

-- pick specified columns from 2010 table
SELECT *
-- 2010 table will be on top
FROM economies2010
-- which set theory clause?
UNION
-- pick specified columns from 2015 table
SELECT *
-- 2015 table on the bottom
FROM economies2015
-- order accordingly
ORDER BY code, year;

-----

/*
Union (2)
UNION can also be used to determine all occurrences of a field across multiple tables. Try out this exercise with no starter code.
*/

SELECT country_code
FROM cities
UNION
SELECT code as country_code
FROM currencies
ORDER BY country_code;

-----

/*
Union all
As you saw, duplicates were removed from the previous two exercises by using UNION.
To include duplicates, you can use UNION ALL.
*/

-- Select fields
SELECT code, year
  -- From economies
  FROM economies
	-- Set theory clause
	UNION ALL
-- Select fields
SELECT country_code, year
  -- From populations
  FROM populations
-- Order by code, year
ORDER BY code, year;

-----

/*
Intersect
Repeat the previous UNION ALL exercise, this time looking at the records in common for country code and year for the economies and populations tables.
*/

-- Select fields
SELECT code, year
  -- From economies
  FROM economies
	-- Set theory clause
	INTERSECT
-- Select fields
SELECT country_code, year
  -- From populations
  FROM populations
-- Order by code and year
ORDER BY code, year;

-----

/*
Intersect (2)
As you think about major world cities and their corresponding country, you may ask which countries also have a city with the same name as their country name?
*/

-- Select fields
SELECT name
  -- From countries
  FROM countries
	-- Set theory clause
	INTERSECT
-- Select fields
SELECT name
  -- From cities
  FROM cities;

-----

/*
Except
Get the names of cities in cities which are not noted as capital cities in countries as a single field result.
Note that there are some countries in the world that are not included in the countries table, which will result in some cities not being labeled as capital cities when in fact they are.
*/

-- Select field
SELECT cities.name
  -- From cities
  FROM cities
	-- Set theory clause
	EXCEPT
-- Select field
SELECT country.capital
  -- From countries
  FROM countries AS country
-- Order by result
ORDER BY name;

-----

/*
Except (2)
Now you will complete the previous query in reverse!
Determine the names of capital cities that are not listed in the cities table.
*/

-- Select field
SELECT country.capital
  -- From countries
  FROM countries AS country
	-- Set theory clause
	EXCEPT
-- Select field
SELECT city.name
  -- From cities
  FROM cities AS city
-- Order by ascending capital
ORDER BY capital;

-----

/*
Semi-join
You are now going to use the concept of a semi-join to identify languages spoken in the Middle East.
*/

-- Select code
SELECT code
  -- From countries
  FROM countries
-- Where region is Middle East
WHERE region ='Middle East';

SELECT code
  FROM countries
WHERE region = 'Middle East';
-- Select field
SELECT DISTINCT name
  -- From languages
  FROM languages
-- Order by name
ORDER BY name;

-- Select distinct fields
SELECT DISTINCT name
  -- From languages
  FROM languages
-- Where in statement
WHERE code IN
  -- Subquery
  (SELECT code
   FROM countries
   WHERE region='Middle East')
-- Order by name
ORDER BY name;

-----

/*
Relating semi-join to a tweaked inner join
Let's revisit the code from the previous exercise, which retrieves languages spoken in the Middle East.
SELECT DISTINCT name
FROM languages
WHERE code IN
  (SELECT code
   FROM countries
   WHERE region = 'Middle East')
ORDER BY name;

Sometimes problems solved with semi-joins can also be solved using an inner join.
SELECT languages.name AS language
FROM languages
INNER JOIN countries
ON languages.code = countries.code
WHERE region = 'Middle East'
ORDER BY language;

This inner join isn't quite right. What is missing from this second code block to get it to match with the correct answer produced by the first block?
*/
/*
DISTINCT
*/

-----

/*
Diagnosing problems using anti-join
Another powerful join in SQL is the anti-join. It is particularly useful in identifying which records are causing an incorrect number of records to appear in join queries.
You will also see another example of a subquery here, as you saw in the first exercise on semi-joins. Your goal is to identify the currencies used in Oceanian countries!
*/

SELECT COUNT(*) FROM countries
WHERE continent = 'Oceania';

SELECT c1.code, c1.name, c2.basic_unit AS currency
FROM countries AS c1
INNER JOIN currencies AS c2
USING (code)
WHERE continent = 'Oceania';

-- 3. Select fields
SELECT c1.code, c1.name
  -- 4. From Countries
  FROM countries AS c1
  -- 5. Where continent is Oceania
 WHERE c1.continent = 'Oceania'
  	-- 1. And code not in
  	AND code NOT IN
  	-- 2. Subquery
  	  (SELECT code 
    FROM currencies);

-----

/*
Set theory challenge
Congratulations! You've now made your way to the challenge problem for this third chapter. Your task here will be to incorporate two of UNION/UNION ALL/INTERSECT/EXCEPT to solve a challenge involving three tables.
In addition, you will use a subquery as you have in the last two exercises! This will be great practice as you hop into subqueries more in Chapter 4!
*/

-- select the city name
SELECT name
-- alias the table where city name resides
FROM cities AS c1
-- choose only records matching the result of multiple set theory clauses
WHERE country_code IN
(
     -- select appropriate field from economies AS e
    SELECT e.code
    FROM economies AS e
    -- get all additional (unique) values of the field from currencies AS c2  
    UNION
    SELECT c2.code
    FROM currencies AS c2
    -- exclude those appearing in populations AS p
    EXCEPT
    SELECT p.country_code
    FROM populations AS p
);

-----
